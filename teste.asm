ORG 0000h          
RS EQU P1.3           
E EQU P1.2           
       
; ---------------------------------- Main -------------------------------------
Main:                                           
        CLR RS                     
        CALL FuncSet         
        CALL DispCon         
        CALL EntryMode       
       
        SetB RS              
        MOV     DPTR,#LINHA1      
EscreveLinha1: CLR     A               
        MOVC    A,@A+DPTR       
        JZ      ProximaLinha        
        CALL    SendChar        
        INC     DPTR            
        JMP     EscreveLinha1          
       
ProximaLinha:
        CALL    CursorPos       
        SetB    RS              
        MOV     DPTR,#LINHA2      
EscreveLinha2: CLR     A
        MOVC    A,@A+DPTR       
        JZ      AguardaComecar       
        CALL    SendChar        
        INC     DPTR
        JMP     EscreveLinha2          
       
AguardaComecar:
        MOV     R6, #0           ; Inicializa pseudoaleatório
        MOV     R4, #7           ; Valor base para soma

LoopRandom:
        ; Incrementa R6 com R4
        MOV     A, R6
        ADD     A, R4
        MOV     R6, A

        ; Zera R6 se passar de 100
        CJNE    R6, #101, NoResetR6
NoResetR6: MOV     R6, #0

        ; Incrementa R4 também (pra variar mais o R6)
        INC     R4
        CJNE    R4, #50, NoResetR4
        MOV     R4, #5
NoResetR4:

        ; Pequeno delay pra deixar o loop mais humano
        ACALL   Delay

        ; Escaneia teclado
        CALL    ScanKeyPad
        CJNE    R7, #'1', LoopRandom

        ; Se apertou '1', limpa e segue
        CLR     RS
        MOV     A, #01h
        CALL    SendChar

ContOk:

        ; Aqui um pequeno delay pra não ir rápido demais
        ACALL   Delay

        ; Verifica se o jogador pressionou algo
        CALL    ScanKeyPad

        ; Verifica se foi '1'
        CJNE    R7, #'1', LoopRandom

        ; Se pressionou '1', continua o jogo
        CLR     RS
        MOV     A, #01h
        CALL    SendChar
        
       
; ----------------------------- Escaneia as teclas -------------------------------
Proximo: CALL    ScanKeyPad      
         SetB    RS              
         CLR     A
         MOV     A,R7            
         CALL    SendChar        
         CJNE    R7,#'#',Proximo    
              
EndHere:
        JMP     $               
;------------------------------ *Fim da Main* -----------------------------------


;--------------------------------- Sub-rotinas ----------------------------------
FuncSet:
        CLR     P1.7            
        CLR     P1.6
        SetB    P1.5            
        CLR     P1.4            
        CALL    Pulse           

        CALL    Delay           
        CALL    Pulse           

        SetB    P1.7            
        CLR     P1.6
        CLR     P1.5
        CLR     P1.4
        CALL    Pulse           
        CALL    Delay           
        RET

; Liga cursor
DispCon:
        CLR     P1.7            
        CLR     P1.6
        CLR     P1.5
        CLR     P1.4
        CALL    Pulse

        SetB    P1.7            
        SetB    P1.6
        SetB    P1.5
        SetB    P1.4
        CALL    Pulse
        CALL    Delay           
        RET

EntryMode:
        CLR     P1.7            
        CLR     P1.6
        CLR     P1.5
        CLR     P1.4
        CALL    Pulse

        CLR     P1.7            
        SetB    P1.6
        SetB    P1.5
        CLR     P1.4
        CALL    Pulse
        CALL    Delay
        RET

CursorPos:
        CLR     RS              
        SetB    P1.7            
        SetB    P1.6
        CLR     P1.5
        CLR     P1.4
        CALL    Pulse           
        CLR     P1.7            
        CLR     P1.6
        CLR     P1.5
        CLR     P1.4
        CALL    Pulse           
        CALL    Delay        
        RET

Pulse:
        SetB    E               
        CLR     E               
        RET

SendChar:
        MOV     C,ACC.7
        MOV     P1.7,C
        MOV     C,ACC.6
        MOV     P1.6,C
        MOV     C,ACC.5
        MOV     P1.5,C
        MOV     C,ACC.4
        MOV     P1.4,C
        CALL    Pulse           

        MOV     C,ACC.3
        MOV     P1.7,C
        MOV     C,ACC.2
        MOV     P1.6,C
        MOV     C,ACC.1
        MOV     P1.5,C
        MOV     C,ACC.0
        MOV     P1.4,C
        CALL    Pulse           

        CALL    Delay           
        RET

Delay:
        MOV     R0,#50          
	DJNZ    R0,$         
        RET

ScanKeyPad:
        CLR     P0.3            
        CALL    IDCode0         
        SETB    P0.3            
        JB      F0,Feito         

        CLR     P0.2            
        CALL    IDCode1         
        SETB    P0.2            
        JB      F0,Feito         

        CLR     P0.1            
        CALL    IDCode2         
        SETB    P0.1            
        JB      F0,Feito         

        CLR     P0.0            
        CALL    IDCode3         
        SETB    P0.0            
        JB      F0,Feito         
	CALL    Delay
        JMP     ScanKeyPad      

Feito:   CLR     F0              
        RET

IDCode0:        
        JNB P0.4,Tecla03     
        JNB P0.5,Tecla13     
        JNB P0.6,Tecla23     
        RET

IDCode1:        
        JNB P0.4,Tecla02     
        JNB P0.5,Tecla12     
        JNB P0.6,Tecla22     
        RET

IDCode2:        
        JNB P0.4,Tecla01    
        JNB P0.5,Tecla11     
        JNB P0.6,Tecla21
        RET

IDCode3:        
        JNB P0.4,Tecla00    
        JNB P0.5,Tecla10     
        JNB P0.6,Tecla20     
        RET

Tecla03:      SETB    F0      
                MOV     R7,#'3' 
                RET
Tecla13:      SETB    F0
                MOV     R7,#'2' 
                RET
Tecla23:      SETB    F0
                MOV     R7,#'1' 
                RET

Tecla02:      SETB    F0
                MOV     R7,#'6' 
                RET
Tecla12:      SETB    F0
                MOV     R7,#'5' 
                RET
Tecla22:      SETB    F0
                MOV     R7,#'4' 
                RET

Tecla01:      SETB    F0
                MOV     R7,#'9' 
                RET
Tecla11:      SETB    F0
                MOV     R7,#'8' 
                RET
Tecla21:      SETB    F0
                MOV     R7,#'7'
                RET

Tecla00:      SETB    F0
                MOV     R7,#'#' 
                RET
Tecla10:      SETB    F0
                MOV     R7,#'0' 
                RET
Tecla20:      SETB    F0
                MOV     R7,#'*' 
                RET
; --------------------------------- Dados (LINHA) --------------------------------
                              ORG     0200h          
LINHA1:       DB 'B','E','M',' ','V','I','N','D','O',0
LINHA2:       DB 'J','O','G','O',' ','A','D','I','V','I','N','H','A',0
       
END