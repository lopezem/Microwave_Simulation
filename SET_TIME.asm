	XDEF SET_TIME
	XREF init_LCD,read_pot,pot_value,display_string, HEX_VALUE, HEX_READ, disp, MAIN_MENU, RUN_TIME


  My_variable: section
  
  hundreds_place:		ds.b	1
  tens_place:         ds.b  1
  ones_place:         ds.b  1

  
  SET_TIME:
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
             movb #' ',disp+11
             movb #' ',disp+12
             movb #' ',disp+13
             movb #' ',disp+14
             movb #' ',disp+15
             movb #' ',disp+16
             movb #' ',disp+17
             movb #' ',disp+18
             movb #' ',disp+19
             movb #' ',disp+20
             movb #' ',disp+21
             movb #' ',disp+22
             movb #' ',disp+23
             movb #' ',disp+24
             movb #'E',disp+25
             movb #'n',disp+26
             movb #'t',disp+27
             movb #'e',disp+28
             movb #'r',disp+29
             movb #'-',disp+30
             movb #'E',disp+31
             movb #0,disp+32    ;string terminator, acts like '\0'    
  ;*********************string initialization*********************





  ;**************************************************************
             
             jsr init_LCD
             movb #$ff,HEX_VALUE;init hex value to ensure something is pressed
             ldy #disp;starting address
             
             ldd #disp
             jsr display_string
             
 KEEP_READING:

             jsr read_pot
             ldd pot_value
             
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
             
             ldd #disp
             jsr display_string
             
             jsr HEX_READ
             
             ldaa HEX_VALUE
             
             cmpa #$0e;checks to see if the user wants to exit the main menu
             bne KEEP_READING
             
             ldd pot_value
             std RUN_TIME
                          
             jsr MAIN_MENU;resets the lcd to main menu
             rts  


