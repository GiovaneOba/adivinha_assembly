                              Org     0000h          
      RS                      Equ     P1.3           
      E                       Equ     P1.2           
       
      ; ---------------------------------- Main -------------------------------------
      Main:                                           
         Clr     RS                     
         Call    FuncSet         
         Call    DispCon         
         Call    EntryMode       
       
         SetB    RS              
         Mov     DPTR,#LUT1      
 Print1:  Clr     A               
         Movc    A,@A+DPTR       
         JZ      NextLine        
         Call    SendChar        
         Inc     DPTR            
         Jmp     Print1          
       
      NextLine:
         Call    CursorPos       
         SetB    RS              
         Mov     DPTR,#LUT2      
 Print2:  Clr     A
         Movc    A,@A+DPTR       
         JZ      WaitStart       
         Call    SendChar        
         Inc     DPTR
         Jmp     Print2          
       
      WaitStart:
         Call    ScanKeyPad      
         CJNE    R7,#'1',WaitStart 
         Clr     RS              
         Mov     A,#01h          
         Call    SendChar        
       
      ; ----------------------------- Escaneia as teclas -------------------------------
 Next:   Call    ScanKeyPad      
         SetB    RS              
         Clr     A
         Mov     A,R7            
         Call    SendChar        
         CJNE    R7,#'#',Next    
              
      EndHere:
         Jmp     $               
       
      ;------------------------------ *Fim da Main* -----------------------------------
       
      ;--------------------------------- Sub-rotinas ----------------------------------
      ; LCD
FuncSet:
        Clr     P1.7            
        Clr     P1.6
        SetB    P1.5            
        Clr     P1.4            
        Call    Pulse           

        Call    Delay           
        Call    Pulse           

        SetB    P1.7            
        Clr     P1.6
        Clr     P1.5
        Clr     P1.4
        Call    Pulse           
        Call    Delay           
        Ret

; Liga cursor
DispCon:
        Clr     P1.7            
        Clr     P1.6
        Clr     P1.5
        Clr     P1.4
        Call    Pulse

        SetB    P1.7            
        SetB    P1.6
        SetB    P1.5
        SetB    P1.4
        Call    Pulse
        Call    Delay           
        Ret

EntryMode:
        Clr     P1.7            
        Clr     P1.6
        Clr     P1.5
        Clr     P1.4
        Call    Pulse

        Clr     P1.7            
        SetB    P1.6
        SetB    P1.5
        Clr     P1.4
        Call    Pulse
        Call    Delay
        Ret

CursorPos:
        Clr     RS              
        SetB    P1.7            
        SetB    P1.6
        Clr     P1.5
        Clr     P1.4
        Call    Pulse           
        Clr     P1.7            
        Clr     P1.6
        Clr     P1.5
        Clr     P1.4
        Call    Pulse           
        Call    Delay           
        Ret

Pulse:
        SetB    E               
        Clr     E               
        Ret

SendChar:
        Mov     C,ACC.7
        Mov     P1.7,C
        Mov     C,ACC.6
        Mov     P1.6,C
        Mov     C,ACC.5
        Mov     P1.5,C
        Mov     C,ACC.4
        Mov     P1.4,C
        Call    Pulse           

        Mov     C,ACC.3
        Mov     P1.7,C
        Mov     C,ACC.2
        Mov     P1.6,C
        Mov     C,ACC.1
        Mov     P1.5,C
        Mov     C,ACC.0
        Mov     P1.4,C
        Call    Pulse           

        Call    Delay           
        Ret

Delay:
        Mov     R0,#50          
	DJNZ    R0,$         
        Ret

ScanKeyPad:
        CLR     P0.3            
        CALL    IDCode0         
        SETB    P0.3            
        JB      F0,Done         

        CLR     P0.2            
        CALL    IDCode1         
        SETB    P0.2            
        JB      F0,Done         

        CLR     P0.1            
        CALL    IDCode2         
        SETB    P0.1            
        JB      F0,Done         

        CLR     P0.0            
        CALL    IDCode3         
        SETB    P0.0            
        JB      F0,Done         

        JMP     ScanKeyPad      

Done:   CLR     F0              
        Ret

IDCode0:        
        JNB P0.4,KeyCode03     
        JNB P0.5,KeyCode13     
        JNB P0.6,KeyCode23     
        Ret

IDCode1:        
        JNB P0.4,KeyCode02     
        JNB P0.5,KeyCode12     
        JNB P0.6,KeyCode22     
        Ret

IDCode2:        
        JNB P0.4,KeyCode01    
        JNB P0.5,KeyCode11     
        JNB P0.6,KeyCode21
        Ret

IDCode3:        
        JNB P0.4,KeyCode00    
        JNB P0.5,KeyCode10     
        JNB P0.6,KeyCode20     
        Ret

KeyCode03:      SETB    F0      
                Mov     R7,#'3' 
                Ret
KeyCode13:      SETB    F0
                Mov     R7,#'2' 
                Ret
KeyCode23:      SETB    F0
                Mov     R7,#'1' 
                Ret

KeyCode02:      SETB    F0
                Mov     R7,#'6' 
                Ret
KeyCode12:      SETB    F0
                Mov     R7,#'5' 
                Ret
KeyCode22:      SETB    F0
                Mov     R7,#'4' 
                Ret

KeyCode01:      SETB    F0
                Mov     R7,#'9' 
                Ret
KeyCode11:      SETB    F0
                Mov     R7,#'8' 
                Ret
KeyCode21:      SETB    F0
                Mov     R7,#'7'
                Ret

KeyCode00:      SETB    F0
                Mov     R7,#'#' 
                Ret
KeyCode10:      SETB    F0
                Mov     R7,#'0' 
                Ret
KeyCode20:      SETB    F0
                Mov     R7,#'*' 
                Ret
      ; --------------------------------- Dados (LUT) --------------------------------
                              Org     0200h          
      LUT1:       DB 'B','E','M',' ','V','I','N','D','O',0
      LUT2:       DB 'J','O','G','O',' ','A','D','I','V','I','N','H','A',0
       
       
                              End                     
