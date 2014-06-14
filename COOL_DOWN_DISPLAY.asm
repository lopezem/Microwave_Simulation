	XDEF COOL_DOWN_DISPLAY
	XREF init_LCD,read_pot,pot_value,display_string, HEX_VALUE, port_S, HEX_READ, disp


  COOL_DOWN_DISPLAY: 
             movb #'C',disp
             movb #'o',disp+1
             movb #'o',disp+2
             movb #'l',disp+3
             movb #'i',disp+4
             movb #'n',disp+5
             movb #'g',disp+6
             movb #'.',disp+7
             movb #'.',disp+8
             movb #'.',disp+9
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
             movb #' ',disp+25
             movb #' ',disp+26
             movb #' ',disp+27
             movb #' ',disp+28
             movb #' ',disp+29
             movb #' ',disp+30
             movb #' ',disp+31
             movb #0,disp+32    ;string terminator, acts like '\0'    

             jsr init_LCD
             ldd #disp
             jsr display_string
             rts  


