	XDEF   SET_MOTOR_SPEED
	XREF init_LCD,read_pot,pot_value,display_string, HEX_VALUE, port_S, HEX_READ, disp, WATTAGE, MAIN_MENU, SPIN_SPEED_OPTION


  SET_MOTOR_SPEED:  
             movb #'S',disp
             movb #'p',disp+1
             movb #'e',disp+2
             movb #'e',disp+3
             movb #'d',disp+4
             movb #':',disp+5
             movb #' ',disp+6
             movb #'1',disp+7
             movb #'-',disp+8
             movb #'S',disp+9
             movb #'l',disp+10
             movb #'o',disp+11
             movb #'w',disp+12
             movb #' ',disp+13
             movb #' ',disp+14
             movb #' ',disp+15
             movb #'2',disp+16
             movb #'-',disp+17
             movb #'M',disp+18
             movb #'e',disp+19
             movb #'d',disp+20
             movb #'i',disp+21
             movb #'u',disp+22
             movb #'m',disp+23
             movb #' ',disp+24
             movb #'3',disp+25
             movb #'-',disp+26
             movb #'F',disp+27
             movb #'a',disp+28
             movb #'s',disp+29
             movb #'t',disp+30
             movb #' ',disp+31
             movb #0,disp+32    ;string terminator, acts like '\0'    
  ;*********************string initialization*********************




                                         ;read hex key pad
 ;================================================================================================================
             
             jsr init_LCD
             movb #$ff,HEX_VALUE;init hex value to ensure something is pressed
             ldy #disp;starting address
             
             ldy   #1
                    

             
       Loop: jsr HEX_READ;go to the hex read subroutine
            
             
             ldd #disp
             jsr display_string

             ldaa HEX_VALUE
             cmpa #$01;
             beq SLOW_SPEED
             
             cmpa #$02
             beq MED_JMP;cannot jump to the MED_SPEED bc out of range
             
             cmpa #$03
             beq FAST_JMP;cannot jump to the FAST_SPEED bc out of range
             
             bra Loop;nothing has been selected
;================================================================================================================
      MED_JMP:
                jmp MED_SPEED
      FAST_JMP:
                jmp FAST_SPEED            
             
                                                    ;Slow speed
;================================================================================================================
  SLOW_SPEED:
             movb #'S',disp
             movb #'L',disp+1
             movb #'O' ,disp+2
             movb #'W',disp+3
             movb #' ',disp+4
             movb #'s',disp+5
             movb #'p',disp+6
             movb #'e',disp+7
             movb #'e',disp+8
             movb #'d',disp+9
             movb #' ',disp+10
             movb #'h',disp+11
             movb #'a',disp+12
             movb #'s',disp+13
             movb #' ',disp+14
             movb #' ',disp+15
             movb #'b',disp+16
             movb #'e',disp+17
             movb #'e',disp+18
             movb #'n',disp+19
             movb #' ',disp+20
             movb #'s',disp+21
             movb #'e',disp+22
             movb #'l',disp+23
             movb #'e',disp+24
             movb #'c',disp+25
             movb #'t',disp+26
             movb #'e',disp+27
             movb #'d',disp+28
             movb #'.',disp+29
             movb #' ',disp+30
             movb #' ',disp+31
             movb #0,disp+32    ;string terminator, acts like '\0'
             
             
             ldaa #1;                                                                       CHANGE!!!!!!!!!!!!!!!
             staa SPIN_SPEED_OPTION
             
             adda #48;convert to ascii
             ;staa disp+12 
             
             ldy   #45
                    
 KEEP_DISPLAYING_SLOW:;DELAY loop to keep displaying the value of wattage
             ldd #disp
             jsr display_string
             dey
             bne KEEP_DISPLAYING_SLOW
             
             
             jsr MAIN_MENU;resets the LCD to main menu 
             rts  
;================================================================================================================

                                            ;Medium Speed
;================================================================================================================
  MED_SPEED:
             movb #'M',disp
             movb #'E',disp+1
             movb #'D' ,disp+2
             movb #'.',disp+3
             movb #' ',disp+4
             movb #'s',disp+5
             movb #'p',disp+6
             movb #'e',disp+7
             movb #'e',disp+8
             movb #'d',disp+9
             movb #' ',disp+10
             movb #'h',disp+11
             movb #'a',disp+12
             movb #'s',disp+13
             movb #' ',disp+14
             movb #' ',disp+15
             movb #'b',disp+16
             movb #'e',disp+17
             movb #'e',disp+18
             movb #'n',disp+19
             movb #' ',disp+20
             movb #'s',disp+21
             movb #'e',disp+22
             movb #'l',disp+23
             movb #'e',disp+24
             movb #'c',disp+25
             movb #'t',disp+26
             movb #'e',disp+27
             movb #'d',disp+28
             movb #'.',disp+29
             movb #' ',disp+30
             movb #' ',disp+31
             movb #0,disp+32    ;string terminator, acts like '\0'
             
             
             ldaa #2;                                                                       CHANGE!!!!!!!!!!!!!!!
             staa SPIN_SPEED_OPTION
             
             adda #48;convert to ascii
             ;staa disp+12 
             
             ldy   #45
                    
 KEEP_DISPLAYING_MED:;DELAY loop to keep displaying the value of wattage
             ldd #disp
             jsr display_string
             dey
             bne KEEP_DISPLAYING_MED 
             
             
             jsr MAIN_MENU;resets the LCD to main menu 
             rts  
;================================================================================================================

                                            ;Fast Speed
;================================================================================================================
  FAST_SPEED:
             movb #'F',disp
             movb #'A',disp+1
             movb #'S',disp+2
             movb #'T',disp+3
             movb #' ',disp+4
             movb #'s',disp+5
             movb #'p',disp+6
             movb #'e',disp+7
             movb #'e',disp+8
             movb #'d',disp+9
             movb #' ',disp+10
             movb #'h',disp+11
             movb #'a',disp+12
             movb #'s',disp+13
             movb #' ',disp+14
             movb #' ',disp+15
             movb #'b',disp+16
             movb #'e',disp+17
             movb #'e',disp+18
             movb #'n',disp+19
             movb #' ',disp+20
             movb #'s',disp+21
             movb #'e',disp+22
             movb #'l',disp+23
             movb #'e',disp+24
             movb #'c',disp+25
             movb #'t',disp+26
             movb #'e',disp+27
             movb #'d',disp+28
             movb #'.',disp+29
             movb #' ',disp+30
             movb #' ',disp+31
             movb #0,disp+32    ;string terminator, acts like '\0'
             
             
             ldaa #3;                                                                       CHANGE!!!!!!!!!!!!!!!
             staa SPIN_SPEED_OPTION
             
             adda #48;convert to ascii
            ; staa disp+12 
             
             ldy   #45
                    
 KEEP_DISPLAYING_FAST:;DELAY loop to keep displaying the value of wattage
             ldd #disp
             jsr display_string
             dey
             bne KEEP_DISPLAYING_FAST 
             
             
             jsr MAIN_MENU;resets the LCD to main menu 
             rts  
;================================================================================================================