include MACRO.asm

.MODEL SMALL

.STACK 200

.DATA

   ;palavra digitada
   P1 db ?
   P2 db ?
   P3 db ?
   P5 db ?
   P4 db ?

   ;mensagens
   inicio db 'Insira a palavra $'
   tentativas db 'Tentativas restantes: $'
   acerto db 'Palavra correta! $'
   over db 'Game over $'

   ;linhas e colunas
   linha db  5
   coluna db  15

   ;cont do jogo
   tentativasr db 6
   tentativasdisplay db 54

   ;cont de palavra correta
   correta db 0


.CODE

      mov ax, @data
      ;limpa tela
      cls
      mov ds,ax

   Main:

      ;pos_cursor
      pos_cursor 3,5
      ;mensagem de inicio
      print inicio
      
      ;tentativas faltam
      pos_cursor 18,5
      print Tentativas

      pos_cursor 18,28
      printch tentativasdisplay

      ;PEGA A PALAVRA

      pos_cursor linha,coluna
      ;pega char 1
      call getChar
      mov P1, al

      ;pega char 2
      call getChar
      mov P2, al

      ;pega char 3
      call getChar
      mov P3, al

      ;pega char 4
      call getChar
      mov P4, al

      ;pega char 5
      call getChar
      mov P5, al

      ;IMPRIME RESULTADO DA PALAVRA INSERIDA
      add linha,1

      Letra1:

      ;compara char W1 - P1
      cmp P1, 'c'
      ;se char igual jmp imprime verde
      je printv1

      ;se amarelo
      cmp P1, 'a'
      je printa1
      cmp P1, 'n'
      je printa1
      cmp P1, 'd'
      je printa1
      cmp P1, 'y'
      je printa1

      ;else imprime sem cor
      printch P1
      jmp Letra2
      
         printv1:
         printverde P1
         add correta, 1
         jmp Letra2

         printa1:
         printamarelo P1

      Letra2:

      ;compara char W2 - P2
      cmp P2, 'a'
      ;se char igual jmp imprime verde
      je printv2

      ;se amarelo
      cmp P2, 'c'
      je printa2
      cmp P2, 'n'
      je printa2
      cmp P2, 'd'
      je printa2
      cmp P2, 'y'
      je printa2

      ;else imprime sem cor
      printch P2
      jmp Letra3

         printv2:
         printverde P2
         add correta, 1
         jmp Letra3

         printa2:
         printamarelo P2

      Letra3:

      ;compara char W3 - P3
      cmp P3, 'n'
      ;se char igual jmp imprime verde
      je printv3

      ;se amarelo
      cmp P3, 'c'
      je printa3
      cmp P3, 'a'
      je printa3
      cmp P3, 'd'
      je printa2
      cmp P3, 'y'
      je printa3

      ;else imprime sem cor
      printch P3
      jmp Letra4

         printv3:
         printverde P3
         add correta, 1
         jmp Letra4

         printa3:
         printamarelo P3

      Letra4:

      ;compara char W4 - P4
      cmp P4, 'd'
      ;se char igual jmp imprime verde
      je printv4

      ;se amarelo
      cmp P4, 'c'
      je printa4
      cmp P4, 'a'
      je printa4
      cmp P4, 'n'
      je printa4
      cmp P4, 'y'
      je printa4

      ;else imprime sem cor
      printch P4
      jmp Letra5

         printv4:
         printverde P4
         add correta, 1
         jmp Letra5

         printa4:
         printamarelo P4

      Letra5:

      ;compara char W5 - P5
      cmp P5, 'y'
      ;se char igual jmp imprime verde
      je printv5

      ;se amarelo
      cmp P5, 'c'
      je printa5
      cmp P5, 'a'
      je printa5
      cmp P5, 'n'
      je printa5
      cmp P5, 'd'
      je printa5

      ;else imprime sem cor
      printch P5
      jmp denovo

         printv5:
         printverde P5
         add correta, 1
         jmp denovo

         printa5:
         printamarelo P5

      denovo:

      ;se correta = 5 ir pro final com sucesso
      cmp correta, 5
      je Fim_suc

      ;decescenta uma tentativa
      sub tentativasr, 1
      sub tentativasdisplay, 1
      ;se tentativas = 0 jmp Fim_err
      cmp tentativasr, 0
      je Fim_err

      ;linhas pra pos_cursor
      add linha,1
      mov correta, 0

      ;volta no loop main
      jmp Main

   Fim:

      pos_cursor 20,5
      sai_dos

   Fim_suc:

      ;print msg de jogo ganho
      pos_cursor 15,10
      print acerto
      pos_cursor 20,5
      sai_dos

   Fim_err:

      cls
      ;print msg de game over
      pos_cursor 15,10
      print over

      pos_cursor 20,5
      sai_dos

   getChar proc
      mov ax,0
      mov ah,07
      int 21h
      ret
   endp

END
