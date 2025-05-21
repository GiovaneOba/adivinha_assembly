🎮 Jogo de Adivinhação em Assembly (8051)

Projeto desenvolvido na disciplina de Arquitetura de Computadores no curso de Ciência da Computação da FEI. O objetivo foi implementar um jogo de adivinhação no simulador EdSim51, utilizando o microcontrolador 8051, display LCD e teclado matricial (keypad) como dispositivos de entrada e saída.

🧠 Descrição do Projeto

O sistema gera automaticamente um número aleatório de 0 a 9 e aguarda o usuário iniciar o jogo pressionando a tecla 1. A interação acontece por meio do keypad, onde o jogador tenta adivinhar o número sorteado. O LCD exibe mensagens como:

Boas-vindas

Indicação de erro e tentativa novamente

Mensagem de sucesso ("Você acertou!")

Mensagem de término ("Game Over")

A lógica do jogo foi construída de forma modular, com sub-rotinas responsáveis pelo envio de dados ao display, escaneamento das teclas e comparação dos valores.

📷 Funcionalidades em destaque

Exibição de mensagens dinâmicas no LCD.

Geração pseudoaleatória de número com base no tempo de espera.

Leitura eficiente do teclado matricial.

Feedback visual claro para acertos e erros.

Organização em sub-rotinas para facilitar manutenção e expansão.

🛠️ Tecnologias e Ferramentas

Assembly (8051)

Simulador EdSim51

Display LCD 16x2

Teclado matricial 4x3

📌 Objetivo Educacional

Este projeto teve como foco proporcionar uma aplicação prática de conceitos como controle de periféricos, programação em baixo nível e manipulação de bits, essenciais para o desenvolvimento de sistemas embarcados.

✅ Conclusão

A aplicação final demonstrou uma integração sólida entre software e hardware simulado, com fluxo de execução coerente e feedback eficaz para o usuário. O projeto serviu como base para o entendimento de sistemas interativos embarcados, podendo ser expandido com novas funcionalidades, como múltiplas rodadas, modos de dificuldade ou integração com comunicação serial.
