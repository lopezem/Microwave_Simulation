;**************************************************************
;* This stationery serves as the framework for a              *
;* user application. For a more comprehensive program that    *
;* demonstrates the more advanced functionality of this       *
;* processor, please see the demonstration applications       *
;* located in the examples subdirectory of the                *
;* Freescale CodeWarrior for the HC12 Program directory       *
;**************************************************************
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; export symbols
            XDEF Entry, _Startup, main, port_S, ROW_VAL, COORD_TBL, VALUE_TBL, HEX_VALUE , port_T,port_T_DDR, ON_OFF, port_U,port_U_DDR, port_U_PSR,PERUu
            XDEF COOL_Y_N,disp,WATTAGE, START_COOKING_Y_N, RUN_TIME, SPIN_SPEED_OPTION, SLOW_SPEED_COUNT, MED_SPEED_COUNT, TIME_COUNTER
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK, CHECK_STATUS, HEX_READ, SPIN_STEPPER_MOTOR,SET_WATT,SET_TIME,MAIN_MENU,DISP_TIME, read_pot,pot_value      ; symbol defined by the linker for the end of the stack
            XREF   COOK_MENU, COOL_DOWN_DISPLAY, SET_MOTOR_SPEED



; variable/data section
MY_EXTENDED_RAM: SECTION
; Insert here your data definition.
          WATTAGE:     ds.b 1
          HEX_VALUE: ds.b 1
          TIME_SECOND: ds.b 1;runtime of the microwave
          ON_OFF:      ds.b 1;power status of the microwave
          COOL_Y_N:    ds.b 1;checks to see if the microwave timer has ran out
          LCD_SECTION: ds.b 1
          START_COOKING_Y_N:		ds.b	1;checks to see if c has been press from key pad in COOK_MENU
          RUN_TIME:         ds.w  1  ;runtime extracted from the pot
          SPIN_SPEED_OPTION:    ds.b 1;spin speed of the dc motor
          SLOW_SPEED_COUNT: ds.b 1
          MED_SPEED_COUNT: ds.b 1
          TIME_COUNTER:    ds.b 1
          
          
          disp:	ds.b 33
          
 My_Constants: SECTION
 
 ;====================================================================================================================
          port_T:      equ $240
          port_T_DDR:  equ $242
 ;====================================================================================================================         
          ;LED RELATED          
          port_S:      equ $248
          port_S_DDR:  equ $24A
 ;====================================================================================================================
          ;HEX RELATED
          port_U:      equ $268;Port U bits
          port_U_DDR:  equ $26A;Direction Register
          port_U_PSR:  equ $26D;Polarity Select Register
          PERUu:       equ $26C;Pull up Registers
          counter_1:   equ 65000
          counter_2:   equ 1000
          
          ROW_VAL:   dc.b $70,$b0,$d0,$e0,$ff; is at begining to compensate for iny at beginning of ROW_LOOP          
          COORD_TBL: dc.b $77,$7b,$7d,$7e,$b7,$bb,$bd,$be,$d7,$db,$dd,$de,$e7,$eb,$ed,$ee,$ff;the ternimator                           
          VALUE_TBL:  dc.b $1,$2,$3,$c,$4,$5,$6,$d,$7,$8,$9,$e,$a,$0,$b,$f
 ;===================================================================================================================         
          ;RTI RELATED
          MYRTIFLG:	equ	$0037 	; RTI flag register address CRGFLG
          MYRTIENA:	equ	$0038	  ; RTI init register address  CRGINT
          MYRTICTL:	equ	$003B	  ; RTI control register address  RTICTL         
;====================================================================================================================          
;====================================================================================================================
;====================================================================================================================
;====================================================================================================================
;====================================================================================================================
;====================================================================================================================
;====================================================================================================================
;====================================================================================================================

  
; code section
MyCode:     SECTION
main:
_Startup:
Entry:
                 lds #__SEG_END_SSTACK ;initalize stack                 
                 movb #%1000, port_T_DDR;for the dc motor to spin
                 movb #0,COOL_Y_N;0 means it is not in a cool down cycle
                 movb #0,ON_OFF;initalizes the on off status                 
                 movb #0,TIME_SECOND;value extracted from the potentiometer
                 ;movb #0,TIME_MINUTE;value extracted from the potentiometer                  
                 movb #$ff,port_S_DDR
                 movb #0,HEX_VALUE
                 movb #0,TIME_COUNTER;default timer counter for rti is 0                                                          
                 movb  	#$17, MYRTICTL 	;1MS DELAY
              	 movb  	#$80, MYRTIENA 	;Enable  RTI 
              	 ldaa #0
              	 staa START_COOKING_Y_N;initailization
              	 staa RUN_TIME ;initailization
              	 ;need to initialize vector table in linker parameter file
              	 cli			;enable interrupt
              	 jsr MAIN_MENU;init main menu on LCD
              	 
              	 
              	 
 ;====================================================================================================================               	         	 
     AGAIN:      
                 ldaa ON_OFF                          
        	       cmpa #1;if the micro wave is on
        	       beq INIT;start the microwave if it is on
   
                 jsr  HEX_READ                 
                 
                 cmpa #$a;chose the menu to set the time
                 beq TIME_SET
                 
                 cmpa  #$b;chose the menu to set the wattage
                 beq WATT_SET
                 
                 cmpa  #$c;chose the menu to set the wattage
                 beq COOK_SET
                 
                 cmpa  #$d;chose the menu to set the wattage
                 beq MOTOR_SET                 
                 
                 
                 bra AGAIN                 
 ;====================================================================================================================                  
     TIME_SET:
                jsr SET_TIME  
                bra AGAIN
 ;====================================================================================================================                 
     WATT_SET:  jsr SET_WATT;go set the wattage routine
                bra AGAIN
 ;====================================================================================================================   
     COOK_SET:
                jsr COOK_MENU
                bra AGAIN
 ;==================================================================================================================== 
      MOTOR_SET:
                jsr SET_MOTOR_SPEED
                bra AGAIN
 ;====================================================================================================================   
    INIT:
                 ldaa #3
                 	jsr DISP_TIME;DISPLAY STATUS
                 staa  SLOW_SPEED_COUNT
                 ldaa #1
                 staa MED_SPEED_COUNT
                 
                 movb #%10000000,port_S;bit 7 is turned on to indicate on time
                 jsr SPIN_STEPPER_MOTOR;spin the motor
                 ;jsr DISP_LCD;displaying runtime
                 ldaa  ON_OFF 
                 beq COOL_DOWN;means it is off;
                 jsr DISP_TIME;displays time left on LCD
                 bra AGAIN
                 
      COOL_DOWN: movb #1,COOL_Y_N
                 jsr COOL_DOWN_DISPLAY;display to the lcd that the microwave is cooling down
                 movb #%00000001,port_S;cool down phase
                 jsr SPIN_STEPPER_MOTOR;now in the cool down phase
                 
                 movb #0,port_S
                 jsr MAIN_MENU;reset main menu to lcd
                 bra AGAIN
                  
                 
        	       end
            
            
