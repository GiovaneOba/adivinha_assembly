ORG 0000h          
RS EQU P1.3           
E EQU P1.2           
       
; ---------------------------------- Main -------------------------------------
Main:                                           
        CLR RS                     
		CLR 0h

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
        CALL    ScanKeyPad      
        CJNE    R7,#1,AguardaComecar 
        CLR     RS
		SETB    0h              
        MOV     A,#01h          
        CALL    SendChar        
       
; ----------------------------- Escaneia as teclas -------------------------------
Proximo: CALL    ScanKeyPad      
         SetB    RS              
         CLR     A
         CALL    teste12
		                    
    ;     CJNE    R7,#'#',Proximo    
              
       
              
EndHere:
        JMP     $   
;------------------------------ *Fim da Main* -----------------------------------


;--------------------------------- Sub-rotinas ----------------------------------
teste12:
	MOV A, R6     ; A = valor1
	SUBB A, R7    ; A = A - R7 (com carry)
	JNZ erro      ; Se o resultado não é zero -> são diferentes
	; Se cair aqui, é porque são iguais
	LCALL correto
	

erro:
       SetB RS              
        MOV     DPTR,#LINHA3      
EscreveLinha12: CLR     A               
        MOVC    A,@A+DPTR       
        JZ      ProximaLinha2        
        CALL    SendChar        
        INC     DPTR            
        JMP     EscreveLinha12          
       
ProximaLinha2:
        CALL    CursorPos       
        SetB    RS              
        MOV     DPTR,#LINHA5      
EscreveLinha22: CLR     A
        MOVC    A,@A+DPTR       
        JZ      Proximo       
        CALL    SendChar        
        INC     DPTR
      	JMP     EscreveLinha22

correto:
SetB RS              
        MOV     DPTR,#LINHA3      
EscreveLinha13: CLR     A               
        MOVC    A,@A+DPTR       
        JZ      ProximaLinha3        
        CALL    SendChar        
        INC     DPTR            
        JMP     EscreveLinha13          
       
ProximaLinha3:
        CALL    CursorPos       
        SetB    RS              
        MOV     DPTR,#LINHA4      
EscreveLinha23: CLR     A
        MOVC    A,@A+DPTR       
        JZ      Main       
        CALL    SendChar        
        INC     DPTR
      	JMP     EscreveLinha23

        

escreveErro:
        CLR A
        MOVC A, @A + DPTR
		JZ      ProximaLinha        
        CALL    SendChar        
        INC     DPTR            
        JMP     escreveErro
       ; Carrega o primeiro caractere da string em A
;EscreveTexto:
 ;       JZ FimTexto               ; Se A == 0 (fim da string), sai do loop
  ;      CALL SendChar             ; Envia o caractere para o LCD
   ;     INC DPTR                  ; Avança o ponteiro para o próximo caractere
    ;    MOVC A, @A + DPTR         ; Carrega o próximo caractere de DPTR
     ;   JMP EscreveTexto          ; Continua o loop
;FimTexto:
;        RET

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
		JB      0,VerificaTecla
        MOV     A, R6
        CJNE    A, #9, Continua
        MOV     R6, #0
        JMP     Continua

Continua:
        INC     R6
        CLR     F0        
        CJNE    R7, #1, VerificaTecla
        ; Quando R7 for igual a '1', executa normalmente

VerificaTecla:
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
        JMP     ScanKeyPad        ; Loop novamente

Feito:   
        CLR     F0        
        CJNE    R7, #1, Retorna
        MOV     A, R6           
        CJNE    A, #9, Retorna
        MOV     R6, #0       

Retorna:
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

Tecla03:        SETB    F0      
                MOV     R7,#3
JNB P0.4,$ 
                RET
Tecla13:        SETB    F0
                MOV     R7,#2
JNB P0.5,$ 
                RET
Tecla23:        SETB    F0
                MOV     R7,#1
JNB P0.6,$ 
                RET

Tecla02:        SETB    F0
                MOV     R7,#6 
JNB P0.4,$
                RET
Tecla12:        SETB    F0
                MOV     R7,#5 
JNB P0.5,$
                RET
Tecla22:        SETB    F0
                MOV     R7,#4 
JNB P0.6,$
                RET

Tecla01:        SETB    F0
                MOV     R7,#9
JNB P0.4,$
                RET
Tecla11:        SETB    F0
                MOV     R7,#8 
JNB P0.5,$
                RET
Tecla21:        SETB    F0
                MOV     R7,#7
JNB P0.6,$
                RET

Tecla00:        SETB    F0
                MOV     R7,#'#' 
JNB P0.4,$
                RET
Tecla10:        SETB    F0
                MOV     R7,#0
JNB P0.5,$  
                RET
Tecla20:        SETB    F0
                MOV     R7,#'*' 
JNB P0.6,$
				
                RET


; --------------------------------- Dados (LINHA) --------------------------------

                              ORG     0200h          
LINHA1:       DB 'B','E','M',' ','V','I','N','D','O',0
LINHA2:       DB 'J','O','G','O',' ','A','D','I','V','I','N','H','A',0
LINHA4: DB 'A','C','E','R','T','O','U',0
LINHA5: DB 'I','N','C','O','R','R','E','T','O',0
LINHA3: DB 'V','O','C','E',0
       
END
