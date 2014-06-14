 	XDEF DISP_TIME
	XREF init_LCD,read_pot,pot_value,display_string, HEX_VALUE, port_S, HEX_READ, disp, RUN_TIME, WATTAGE, SPIN_SPEED_OPTION, port_T


  DISP_TIME: 
             
             movb #'T',disp
             movb #'i',disp+1
             movb #'m',disp+2
             movb #'e',disp+3
             movb #':',disp+4
             movb #' ',disp+5
             movb #'0',disp+6
             movb #'0',disp+7
             movb #'0',disp+8
             movb #'s',disp+9
             movb #' ',disp+10
             movb #'@',disp+11
             movb #'0',disp+12
             movb #'0',disp+13
             movb #'0',disp+14
             movb #'W',disp+15
             movb #'S',disp+16
             movb #'p',disp+17
             movb #'e',disp+18
             movb #'e',disp+19
             movb #'d',disp+20
             movb #':',disp+21
             movb #' ',disp+22
             movb #' ',disp+23
             movb #' ',disp+24
             movb #' ',disp+25
             movb #' ',disp+26
             movb #' ',disp+27
             movb #' ',disp+28
             movb #' ',disp+29
             movb #' ',disp+30
             movb #' ',disp+31
             movb #0,disp+32    ;string terminator, acts like '\0'
             
             
             
                                ;WATTAGE DISPLAY    
 ;=============================================================================================
             ldaa WATTAGE;stores the watage value into the constant
             
             adda #48;convert to ascii
             staa disp+12
             
             
             
                                ;RUN TIME DISPLAY
 ;=============================================================================================            
             ldd RUN_TIME
              ldx #100;hundres place
             idiv
             tfr x,a
             adda #48
             staa disp+6
             ldaa #0;reset a to its original value which will always be 0
             
             ldx #10 ;tens place
             idiv
             tfr x,a
             adda #48             
             staa disp+7
             ldaa #0;reset a to its original value which will always be 0
             
             addb #48 ;ones place
             stab disp+8

             jsr init_LCD
             
;=============================================================================================               
             	brclr port_T,%00000001,FAN_OFF;check if bit 0 is off, if so the fan is OFF
    
;=============================================================================================             
             
             ldaa SPIN_SPEED_OPTION;checks to see which mode the fan is in
             cmpa #1
             beq SLOW_DISPLAY;because out of beq range
             
             cmpa #2
             beq MED_DISPLAY;because out of beq range
             
             bra FAST_DISPLAY
 ;=============================================================================================  
    RETURN:
             ldd #disp
             jsr display_string
             rts
             
    SLOW_DISPLAY:
             movb #'S',disp+23
             movb #'l',disp+24
             movb #'o',disp+25
             movb #'w',disp+26
              
             bra RETURN
    
    
    MED_DISPLAY:
             movb #'M',disp+22
             movb #'e',disp+23
             movb #'d',disp+24
             movb #'i',disp+25
             movb #'u',disp+26
             movb #'m',disp+27

             bra RETURN
             
    FAST_DISPLAY:
             movb #'F',disp+23
             movb #'a',disp+24
             movb #'s',disp+25
             movb #'t',disp+26
              
             bra RETURN
    
    FAN_OFF:
             movb #'F',disp+16
             movb #'a',disp+17
             movb #'n',disp+18
             movb #' ',disp+19
             movb #'i',disp+20
             movb #'s',disp+21
             movb #' ',disp+22
             movb #'O',disp+23
             movb #'F',disp+24
             movb #'F',disp+25
             
             jmp RETURN
           
             
             
             
             
              