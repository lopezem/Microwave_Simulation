  		xdef	CHECK_STATUS
  		xref	SECOND,port_S,ON_OFF, port_T, port_T_DDR,START_COOKING_Y_N,SPIN_SPEED_OPTION, SLOW_SPEED_COUNT, MED_SPEED_COUNT, DISP_TIME, TIME_COUNTER
      xref  RUN_TIME  		
  		
  
  My_Constants: SECTION
  RTIE: equ $80
  

  	          	
  	          	
  CHECK_STATUS: 
             	  
            		
                brset port_T,%10000000,MICRO_ON;check if bit 0 is on, if so the fan is on
                	
;===================================================================================================================              	
     MICRO_OFF:	movb #0,ON_OFF;the microwave is off
                bclr port_T,%1000;turn the DC MOTOR OFF
              	ldaa	#RTIE	;re-enable interrupt
            		staa	$37
            		rti
            		
     MICRO_ON:  
     

                ldaa START_COOKING_Y_N;to check if C has been pressed in the cook menu
                cmpa #1
                bne EXIT
                
                                                ;TIME CHECKER
                                                ldx	TIME_COUNTER
                                            		inx	;increase ms counter in memory
                                            		stx TIME_COUNTER
                                            		cpx	#860	;equal to 1 second?
                                            		bne	SWITCH_ON_OFF_CHECK;means it has not been 1s yet
                                            	
                                            		ldx	#0	;reset to 0 if = 1 sec
                                            		stx	TIME_COUNTER
                                            		jsr DISP_TIME
                                            		ldd RUN_TIME
                                            		cmpb #0
                                            		beq EXIT
                                            		decb
                                            		std RUN_TIME
                
    	SWITCH_ON_OFF_CHECK:
    	          movb #1,ON_OFF;the microwave is on
                
                ldaa	#RTIE	;re-enable interrupt
            		staa	$37
            		brset port_T,%00000001,SPIN_FAN;check if bit 0 is on, if so the fan is on
            		bclr port_T,%1000;turn the DC MOTOR OFF
            	
            		rti
            		
      SPIN_FAN:
                 ldaa SPIN_SPEED_OPTION
                 
                 cmpa #1;slow spin speed
                 beq SLOW_FAN_SPEED
                 
                 cmpa #2;medium spin speed
                 beq MED_FAN_SPEED
                 
                 bset port_T,%1000;Otherwise it is a fast spin speed     		
            		 rti 
;========================================================================================================            		 
     SLOW_FAN_SPEED:
                ldaa SLOW_SPEED_COUNT
                beq SLOW_FAN_SPEED_INIT
                deca
                staa SLOW_SPEED_COUNT
                bclr port_T,%1000;turn the DC MOTOR OFF
                rti 
                
     SLOW_FAN_SPEED_INIT:
                ldaa #3
                staa SLOW_SPEED_COUNT
                bset port_T,%1000;turn the DC MOTOR OFF
                rti       
                
      
;========================================================================================================
      MED_FAN_SPEED:
                ldaa MED_SPEED_COUNT
                beq MED_FAN_SPEED_INIT
                deca
                staa MED_SPEED_COUNT
                bclr port_T,%1000;turn the DC MOTOR OFF
                rti 
                
     MED_FAN_SPEED_INIT:
                ldaa #2
                staa MED_SPEED_COUNT
                bset port_T,%1000;turn the DC MOTOR OFF
                rti                 
                                		 
            		 
            		 
            		            		

            		
     EXIT:      
                movb #0,ON_OFF;the microwave is off
                movb #0,START_COOKING_Y_N;resets the c button that has been clicked
                bclr port_T,%1000;turn the DC MOTOR OFF
              	
              	ldaa	#RTIE	;re-enable interrupt
            		staa	$37
                rti
