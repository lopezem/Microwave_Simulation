	XDEF COOK_MENU
	XREF init_LCD,read_pot,pot_value,display_string, HEX_VALUE, port_S, HEX_READ, disp, WATTAGE, MAIN_MENU, RUN_TIME, START_COOKING_Y_N


  COOK_MENU:

  ;**************************************************************
             movb #'T',disp
             movb #'i',disp+1
             movb #'m' ,disp+2
             movb #'e',disp+3
             movb #':',disp+4
             movb #'0',disp+5
             movb #'0',disp+6
             movb #'0',disp+7
             movb #'s',disp+8
             movb #' ',disp+9
             movb #' ',disp+10
             movb #' ',disp+11
             movb #' ',disp+12
             movb #' ',disp+13
             movb #' ',disp+14
             movb #' ',disp+15
             movb #'C',disp+16
             movb #'o',disp+17
             movb #'o',disp+18
             movb #'k',disp+19
             movb #'-',disp+20
             movb #'C',disp+21
             movb #' ',disp+22
             movb #'E',disp+23
             movb #'x',disp+24
             movb #'i',disp+25
             movb #'t',disp+26
             movb #'-',disp+27
             movb #'F',disp+28
             movb #' ',disp+29
             movb #' ',disp+30
             movb #' ',disp+31
             movb #0,disp+32    ;string terminator, acts like '\0'
   ;**************************************************************            
                          
             jsr init_LCD
             movb #$ff,HEX_VALUE;init hex value to ensure something is pressed

                    
 KEEP_DISPLAYING:;DELAY loop to keep displaying the value of wattage
 
                ;placing RUN_TIME value to array
 ;----------------------------------------------------------------------------------------
              ldd RUN_TIME
              ldx #100;hundres place
             idiv
             tfr x,a
             adda #48
             staa disp+5
             ldaa #0;reset a to its original value which will always be 0
             
             ldx #10 ;tens place
             idiv
             tfr x,a
             adda #48             
             staa disp+6
             ldaa #0;reset a to its original value which will always be 0
             
             addb #48 ;ones place
             stab disp+7
             
             
                                  ;display array to LCD
;----------------------------------------------------------------------------------------- 
             ldd #disp
             jsr display_string
;-----------------------------------------------------------------------------------------             
                                  ;read from the hex keypad
             jsr HEX_READ
             ldaa HEX_VALUE
             
             cmpa #$0f
             beq  EXIT
             
             cmpa #$0c
             beq COOK
;-----------------------------------------------------------------------------------------                
             bra KEEP_DISPLAYING              
     
     EXIT:   jsr MAIN_MENU;resets the LCD to main menu 
             rts
             
     COOK:  
              
              ldaa #1
              staa START_COOKING_Y_N
              rts


