Descrição do Projeto 

Este projeto implementa um jogo de adivinhação utilizando o simulador EdSim51, baseado no microcontrolador 8051. A interface é composta por um display LCD e um teclado matricial (keypad), permitindo a interação direta do usuário com o sistema.

O funcionamento segue o seguinte fluxo:

Mensagem de boas-vindas: Ao iniciar o sistema, uma mensagem de boas-vindas é exibida no display LCD.

Início do jogo: O jogo é iniciado quando o usuário pressiona a tecla # no teclado.

Geração do número aleatório: Assim que iniciado, o sistema gera um número aleatório que será o alvo da adivinhação.

Entrada do usuário: O usuário digita um número através do teclado e confirma a tentativa pressionando #.

Verificação e feedback: O sistema compara o valor inserido com o número aleatório:

Se o número estiver correto, o LCD exibe uma mensagem de parabéns.

Se estiver incorreto, o sistema pode dar dicas como “maior” ou “menor” para orientar o jogador.

