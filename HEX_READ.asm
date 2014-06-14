 XDEF HEX_READ
 XREF HEX_VALUE,port_S,port_S_DDR,DELAY,port_U,port_U_DDR,port_U_PSR, PERUu, ROW_VAL, COORD_TBL, VALUE_TBL
   

   HEX_READ:
          pshx;save registers on the stack
          pshy

            
          ldx #$0000
                                   
          ldaa #$f0
          staa port_U_DDR ;initalize
          staa port_U_PSR
          
          movb #$0f,PERUu    
                        
          ldx  #ROW_VAL


          deca
          cmpa #0
          beq QUIT
          
          
 NEXT_ROW:          
          ldab #0;b is a counter
          ldaa x; a is a pointer of the row value
          oraa #$0f
          STAA port_U
          ldy #COORD_TBL;y is a pointer of the corrd table
          
NEXT_VALUE:
          incb
          ldaa y
          cmpa #$ff
          beq INC_X
          ldaa port_U
          cmpa 1,y+
          beq EQUAL
          bra NEXT_VALUE
          
   INC_X:  
          inx
          ldaa x
          cmpa #$ff
          beq QUIT;scaned everything, so exit
          bra NEXT_ROW
          
   EQUAL: ldx #VALUE_TBL
  CHECK_B:
          cmpb #1
          beq SET_HEX
          inx
          decb
          bra CHECK_B
          
          
   SET_HEX:

          ldaa x;a now has hex keypad value
          staa HEX_VALUE
          
          ;staa port_S

          puly
          pulx
          rts
          
   QUIT:
       
        puly
        pulx
        
        ;ldaa HEX_VALUE ;get the old hex value, not the ff one from x
        ;staa port_S

        rts
         
