  XDEF SPIN_STEPPER_MOTOR
  XREF COOL_Y_N, ON_OFF
    
    My_Const: SECTION         
          array:  dc.b  $ff,$0a,$12,$14,$0c,$ff ;sequence will be sent to the motor

          port_P_DDR: equ $25a
          port_P:  equ $258
          port_T:  equ $240
; code section
MyCode:     SECTION

SPIN_STEPPER_MOTOR:   
          ldaa  port_P_DDR ;loads port p ddr into acc a
             
          oraa  #%00011110 ;sets the bits 1-4 in port p ddr
          staa  port_P_DDR ;places new value into port p ddr
          
  RETRY:
          
          ldy   #65535
  SAFE_DELAY:;safety delay for no sudden changes in rotating
          dey              
          cpy   #0         
          bne   SAFE_DELAY  
          
          
          ldaa  COOL_Y_N
          beq   CLOCK_W;not in a cool down phase
          
          ldaa #7;this is for the cool down phase, it shall cool down for 10 cycles
          psha
          
          bra   COUNTER_CW;it is a cool down phase
          
;====================================================================================================================          
 CLOCK_W:         
          ldx   #array     ;loads first element of array into reg. x
AGAIN_CW: ldab  #1         ;acc. b will act as a counter
 LOOP_CW: 
          
          ldaa  b,x
    
          cmpa  #$ff        ;compares with the terminator $ff
          beq   AGAIN_CW
          
          ldy   #25000     
                           
 DELAY_CW_1:dey              
          cpy   #1         
          bne   DELAY_CW_1   
          
          ldy   #25000     
            
          
          staa  port_P
                   
          incb             ;increments b by one
          
          ldaa  port_T

          
          ldaa  ON_OFF
          bne   BRANCH_CW;the microwave has not been turned off
          rts
          
  BRANCH_CW:bra   LOOP_CW 
;==================================================================================================================== 		    
 COUNTER_CW:
          pula;getting the cool down counter phase
          deca
          beq STOP_COOLING;stop cooling and return to the main program
          
          psha;pushes the cool down counter back onto the stack
                   
          ldx   #array      ;loads first element of array into reg. x
AGAIN_CCW: ldab  #4         ;acc. b will act as a counter
 LOOP_CCW: ldaa  b,x
    
          cmpa  #$ff        ;compares with the terminator $ff
          beq   COUNTER_CW
          
          ldy   #50000     ;120 cycles means 30microseconds of a delay
                           ;just a for loop with 120 itterations
DELAY_CCW:dey              ;decrements y by 1
          cpy   #0         ;compares y to see if it is the end of the delay loop
          bne   DELAY_CCW   ;branches back to delay when y!=0
          
          staa  port_P
                   
          decb             ;increments b by one
 
  		    bra   LOOP_CCW  
  		    
 STOP_COOLING:    
                movb #0,COOL_Y_N
                rts