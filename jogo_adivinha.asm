                              Org     0000h          
      RS                      Equ     P1.3           
      E                       Equ     P1.2           
       
      ; ---------------------------------- Main -------------------------------------
      Main:                                           
0000|         Clr     RS                     
0002|         Call    FuncSet         
0004|         Call    DispCon         
0006|         Call    EntryMode       
       
0008|         SetB    RS              
000A|         Mov     DPTR,#LUT1      
000D| Print1:  Clr     A               
000E|         Movc    A,@A+DPTR       
000F|         JZ      NextLine        
0011|         Call    SendChar        
0013|         Inc     DPTR            
0014|         Jmp     Print1          
       
      NextLine:
0016|         Call    CursorPos       
0018|         SetB    RS              
001A|         Mov     DPTR,#LUT2      
001D| Print2:  Clr     A
001E|         Movc    A,@A+DPTR       
001F|         JZ      WaitStart       
0021|         Call    SendChar        
0023|         Inc     DPTR
0024|         Jmp     Print2          
       
      WaitStart:
0026|         Call    ScanKeyPad      
0028|         CJNE    R7,#'1',WaitStart 
002B|         Clr     RS              
002D|         Mov     A,#01h          
002F|         Call    SendChar        
       
      ; ----------------------------- Escaneia as teclas -------------------------------
0031| Next:   Call    ScanKeyPad      
0033|         SetB    RS              
0035|         Clr     A
0036|         Mov     A,R7            
0037|         Call    SendChar        
0039|         CJNE    R7,#'#',Next    
              
      EndHere:
003C|         Jmp     $               
       
      ;------------------------------ *Fim da Main* -----------------------------------
       
      ;--------------------------------- Sub-rotinas ----------------------------------
      
      ; --------------------------------- Dados (LUT) --------------------------------
                              Org     0200h          
      LUT1:       DB 'B','E','M',' ','V','I','N','D','O',0
      LUT2:       DB 'J','O','G','O',' ','A','D','I','V','I','N','H','A',0
       
       
                              End                     
