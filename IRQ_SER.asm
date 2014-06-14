	XDEF IRQ_SER
	XREF init_LCD,read_pot,pot_value,display_string, HEX_VALUE, port_S, HEX_READ, disp, port_T


  IRQ_SER:
  
             
            
             movb #'E',disp
             movb #'m',disp+1
             movb #'e',disp+2
             movb #'r',disp+3
             movb #'g',disp+4
             movb #'e',disp+5
             movb #'n',disp+6
             movb #'c',disp+7
             movb #'y',disp+8
             movb #' ',disp+9
             movb #'P',disp+10
             movb #'o',disp+11
             movb #'w',disp+12
             movb #'e',disp+13
             movb #'r',disp+14
             movb #' ',disp+15
             movb #'S',disp+16
             movb #'h',disp+17
             movb #'u',disp+18
             movb #'t',disp+19
             movb #' ',disp+20
             movb #'D',disp+21
             movb #'o',disp+22
             movb #'w',disp+23
             movb #'n',disp+24
             movb #'.',disp+25
             movb #'.',disp+26
             movb #'.',disp+27
             movb #' ',disp+28
             movb #' ',disp+29
             movb #' ',disp+30
             movb #' ',disp+31
             movb #0,disp+32    ;string terminator, acts like '\0'    

             jsr init_LCD
             ldd #disp
             jsr display_string

             
             bclr port_T,%1000;turn the DC MOTOR OFF
             ldx #8;loop again
             
             FLASH: 
                                        
                           pshx;temp save x             
                                        ldy #3      
                           KEEP_DISPLAYING_1:;DELAY loop to keep displaying the value of wattage
                                        movb #$0,port_S

                                       ldd #disp
                                      
                                       jsr display_string

                                       movb #0,port_S
                                      
                                       dey
                                       bne KEEP_DISPLAYING_1
                            
                                       
                                       ldy #3 
                                              
                           KEEP_DISPLAYING_2:;DELAY loop to keep displaying the value of wattage
                                        movb #$ff,port_S

                                       ldd #disp
                                      
                                       jsr display_string

                                       movb #0,port_S
                                      
                                       dey
                                       bne KEEP_DISPLAYING_2
                      pulx
                      dex
                      bne FLASH                 
             

  STOP_COOLING:
   
             bclr port_T,%1000;turn the DC MOTOR OFF 
                     
             movb #'P',disp
             movb #'l',disp+1
             movb #'e',disp+2
             movb #'a',disp+3
             movb #'s',disp+4
             movb #'e',disp+5
             movb #' ',disp+6
             movb #'R',disp+7
             movb #'e',disp+8
             movb #'s',disp+9
             movb #'t',disp+10
             movb #'a',disp+11
             movb #'r',disp+12
             movb #'t',disp+13
             movb #' ',disp+14
             movb #' ',disp+15
             movb #'T',disp+16
             movb #'h',disp+17
             movb #'e',disp+18
             movb #' ',disp+19
             movb #'P',disp+20
             movb #'r',disp+21
             movb #'o',disp+22
             movb #'g',disp+23
             movb #'r',disp+24
             movb #'a',disp+25
             movb #'m',disp+26                     
              
             jsr init_LCD
             ldd #disp
             jsr display_string

             end  


