	XDEF MAIN_MENU
	XREF init_LCD,read_pot,pot_value,display_string, HEX_VALUE, port_S, HEX_READ, disp


  MAIN_MENU: 
             movb #'A',disp
             movb #'-',disp+1
             movb #'T',disp+2
             movb #'i',disp+3
             movb #'m',disp+4
             movb #'e',disp+5
             movb #' ',disp+6
             movb #'B',disp+7
             movb #'-',disp+8
             movb #'W',disp+9
             movb #'a',disp+10
             movb #'t',disp+11
             movb #'t',disp+12
             movb #'a',disp+13
             movb #'g',disp+14
             movb #'e',disp+15
             movb #'C',disp+16
             movb #'-',disp+17
             movb #'C',disp+18
             movb #'o',disp+19
             movb #'o',disp+20
             movb #'k',disp+21
             movb #' ',disp+22
             movb #'D',disp+23
             movb #'-',disp+24
             movb #'F',disp+25
             movb #'a',disp+26
             movb #'n',disp+27
             movb #' ',disp+28
             movb #' ',disp+29
             movb #' ',disp+30
             movb #' ',disp+31
             movb #0,disp+32    ;string terminator, acts like '\0'    

             jsr init_LCD
             ldd #disp
             jsr display_string
             rts  


