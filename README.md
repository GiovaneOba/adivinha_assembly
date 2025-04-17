Relatório Parcial - Jogo de Adivinhação em Assembly (8051)
Descrição do Projeto
Este projeto tem como objetivo implementar um jogo de adivinhação utilizando o simulador EdSim51, baseado no microcontrolador 8051. O sistema faz uso de dois dispositivos principais para a interação com o usuário:

Display LCD: Responsável por exibir mensagens e feedback ao jogador.

Teclado Matricial (Keypad): Usado para entrada de dados, como iniciar o jogo e digitar os números.

Funcionamento Geral
O fluxo de funcionamento do jogo é o seguinte:

Mensagem de boas-vindas: Assim que o sistema é ligado, uma mensagem é exibida no display LCD para recepcionar o usuário.

Início do jogo: O usuário deve pressionar a tecla # no teclado para iniciar o jogo.

Geração do número aleatório: Após o início, o sistema irá gerar um número aleatório que o jogador deverá adivinhar.

Entrada do jogador: O jogador digita um número no teclado e confirma pressionando #.

Verificação e dicas: O sistema compara a tentativa com o número alvo:

Se for correto, uma mensagem de parabéns é exibida.

Se for incorreto, o sistema pode dar dicas como “maior” ou “menor”.

Status Atual
Até o momento, as seguintes funcionalidades já estão implementadas e testadas:

Exibição da mensagem de boas-vindas no display LCD.

Início do jogo com a tecla #.

Captura de entrada do usuário via teclado.

Exibição dos caracteres digitados no LCD.

Trecho do Código (Assembly)
Abaixo está parte do código Assembly desenvolvido até agora:

asm
Copiar
Editar
Org     0000h          
RS      Equ     P1.3           
E       Equ     P1.2           

Main:                                           
    Clr     RS                     
    Call    FuncSet         
    Call    DispCon         
    Call    EntryMode       
    SetB    RS              
    Mov     DPTR,#LUT1      
Print1:  
    Clr     A               
    Movc    A,@A+DPTR       
    JZ      NextLine        
    Call    SendChar        
    Inc     DPTR            
    Jmp     Print1          

NextLine:
    Call    CursorPos       
    SetB    RS              
    Mov     DPTR,#LUT2      
Print2:  
    Clr     A
    Movc    A,@A+DPTR       
    JZ      WaitStart       
    Call    SendChar        
    Inc     DPTR
    Jmp     Print2          

Próximos Passos
As próximas etapas do projeto incluem:

Implementar a lógica de geração do número aleatório.

Comparar a tentativa do jogador com o número gerado.

Exibir mensagens de feedback como "maior" ou "menor".

Adicionar controle de tentativas e possíveis limites de jogo.

Melhorar a usabilidade e apresentação no LCD.

Considerações Finais
Este relatório parcial documenta o progresso atual do projeto. Apesar de ainda não estar finalizado, a base do sistema já está construída e testada. As interações principais com o teclado e o display estão funcionando corretamente, o que permite continuar com as funcionalidades de comparação e dicas no jogo.
