	XDEF SET_WATT
	XREF init_LCD,read_pot,pot_value,display_string, HEX_VALUE, port_S, HEX_READ, disp, WATTAGE, MAIN_MENU


  SET_WATT:  
             movb #'E',disp
             movb #'n',disp+1
             movb #'t',disp+2
             movb #'e',disp+3
             movb #'r',disp+4
             movb #' ',disp+5
             movb #'t',disp+6
             movb #'h',disp+7
             movb #'e',disp+8
             movb #' ',disp+9
             movb #'W',disp+10
             movb #'A',disp+11
             movb #'T',disp+12
             movb #'T',disp+13
             movb #' ',disp+14
             movb #' ',disp+15
             movb #'V',disp+16
             movb #'A',disp+17
             movb #'L',disp+18
             movb #':',disp+19
             movb #' ',disp+20
             movb #'(',disp+21
             movb #'0',disp+22
             movb #'-',disp+23
             movb #'9',disp+24
             movb #')',disp+25
             movb #'*',disp+26
             movb #'1',disp+27
             movb #'0',disp+28
             movb #'0',disp+29
             movb #' ',disp+30
             movb #' ',disp+31
             movb #0,disp+32    ;string terminator, acts like '\0'    
  ;*********************string initialization*********************





  ;**************************************************************
             
             jsr init_LCD
             movb #$ff,HEX_VALUE;init hex value to ensure something is pressed
             ldy #disp;starting address
             
       Loop: jsr HEX_READ;go to the hex read subroutine
            
             
             ldd #disp
             jsr display_string
             
             ldaa HEX_VALUE
             staa port_S
             cmpa #$ff;checks to see if the hex value is the same as the initailzation
                      ;this means that the hex keypad has not been changed                  
             beq Loop
            
             

  ;**************************************************************
             movb #'Y',disp
             movb #'o',disp+1
             movb #'u' ,disp+2
             movb #' ',disp+3
             movb #'e',disp+4
             movb #'n',disp+5
             movb #'t',disp+6
             movb #'e',disp+7
             movb #'r',disp+8
             movb #'e',disp+9
             movb #'d',disp+10
             movb #':',disp+11
             movb #' ',disp+12
             movb #'0',disp+13
             movb #'0',disp+14
             movb #'W',disp+15
             movb #' ',disp+16
             movb #' ',disp+17
             movb #' ',disp+18
             movb #' ',disp+19
             movb #' ',disp+20
             movb #' ',disp+21
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
             
             
             staa WATTAGE;stores the watage value into the constant
             
             adda #48;convert to ascii
             staa disp+12 
             
             ldy   #30
                    
 KEEP_DISPLAYING:;DELAY loop to keep displaying the value of wattage
             ldd #disp
             jsr display_string
             dey
             bne KEEP_DISPLAYING 
             
             
             jsr MAIN_MENU;resets the LCD to main menu 
             rts  


