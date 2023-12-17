;----------------------------------------------
;  macro limpa a tela
;----------------------------------------------
 cls macro  
    push ax
    mov ax,0       ; zera o conteudo de AX
    mov ah,0fh     ; coloca a funcao do dos para limpar a tela
    int 10h        ; chama a interrupcao do dos
    mov ah,0       ; Zera o AH
    int 10h        ; Chama a interrupcao do dos
    pop ax
 endm
;----------------------------------------------
;  macro Posiciona cursor em mR,mC
;----------------------------------------------
pos_cursor macro mL,mC
    push ax
    push bx
    push dx
    mov bh,0       ; determina pagina de video
    mov dh,mL      ; determino a linha para posicionar o cursor
    mov dl,mC      ; determino a coluna para posicionar o cursor
    mov ah,2       ; funcao 02 - da bios
    int 10h        ; chama interrucao
    pop dx
    pop bx
    pop ax
endm
;----------------------------------------------
;  macro print string
;----------------------------------------------
print macro str
    push ax             ; salvo o contexto
    push ds
    push dx
    mov ax,@data        ; segmento de dados definido no programa principal
    mov ds,ax           ; Carrega em ds o segmento de dados
    lea dx, str         ; Carrega o end efetivo da variavel de texto em DX
    mov ah,09           ; carrega a funcao 09 do DOS
    int 21h             ; promove a interrupcao 21h  imprime a string 
    pop dx              ; rstauro o contexto
    pop ds
    pop ax
endm
;----------------------------------------------
;  macro print caractere
;----------------------------------------------
printch macro mch
    push ax
    push dx
    mov dl,mch     ; imprime digito
    mov ah,02      ; syscall function 02
    int 21h        ; dos interrupt
    pop dx
    pop ax
endm

;-------------------------------------------
;  macro print caractere verde
;-------------------------------------------
printverde macro mchv 
    push ax
    push dx
    mov cx, 1
    mov bl, 02      ; cor verde
    mov ah, 09      ; char com atributo
    int 10h         ; dos interrupt
    mov al, mchv
    printch mchv
    pop dx
    pop ax
endm


;-------------------------------------------
;  macro print caractere amarelo
;-------------------------------------------
printamarelo macro mcha
    push ax
    push dx
    mov cx, 1
    mov ah, 09      ; char com atributo
    mov bl, 14      ; cor amarelo
    int 10h         ; dos interrupt
    mov al, mcha
    printch mcha
    pop dx
    pop ax
endm

;----------------------------------------------
;  macro devolve o controle ao dos
;----------------------------------------------
sai_dos macro
   mov ax,0     ; zera o ax
   mov ah,4Ch   ; coloca a funcaode retorno ao  DOS
   int 21h      ; chama a interrrupcao 21h para retorno ao DOS
endm
;-------------------------------------------
;  Macro pausa
;-------------------------------------------
pausa macro
    push ax
    mov ax,0
    mov ah,7
    int 21h
    pop ax
endm
