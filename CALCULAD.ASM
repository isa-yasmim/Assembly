include MACRO. asm

.MODEL SMALL

.STACK

.DATA

P db 135
S db 135
R db 135
b db 1,10,100
Rs db 3 dup (' '),'$'
Msg db " (+) para adicao (-) para subtracao (*) para multiplicacao (/) "
cont db 0
Operacao db ? 
invalido db " - Input invalido $"
digiteN db "Digite um numero 000 $"

.CODE

mov ax, @data
cls
mov ds, ax

;pegar operacao e confirmar
print Msg
call getChar 
mov Operacao, al
cls
printChar Operacao

;pega digitos
print digiteN
Pdig1:
    call getChar
    cmp al, 48
    jb Pdig1
    cmp al,57
    ja Pdigl
    sub al, 48
    mul b[2]
    mov P,al

Pdig2:
    call getChar
    cmp al, 48
    jb Pdig2
    cmp al,57
    ja Pdig2
    sub al, 48
    mul b[1]
    mov P,al

Pdig3:
    call getChar
    cmp al, 48
    jb Pdig3
    cmp al,57
    ja Pdig3
    sub al, 48
    mul b[0]
    mov P,al

print digiteN
Sdig1:
    call getChar
    cmp al, 48
    jb Sdig1
    cmp al,57
    ja Sdigl
    sub al, 48
    mul b[2]
    mov P,al

Sdig2:
    call getChar
    cmp al, 48
    jb Sdig2
    cmp al,57
    ja Sdig2
    sub al, 48
    mul b[1]
    mov P,al

Sdig3:
    call getChar
    cmp al, 48
    jb Sdig3
    cmp al,57
    ja Sdig3
    sub al, 48
    mul b[0]
    mov P,al

;jmp de opcao
cmp Operacão, '+'
je Addi 
cmp Operacao, '-'
je Subi
cmp Operacao, '*'
je Muli 
cmp Operacao, '/'
je Divi

print invalido 
jmp fim

Addi:
    mov al,p
    add al,S
    mov R,al 
    call resultado
    jmp fim

Subi:
    mov al,p
    sub al,S
    mov R,al 
    call resultado
    jmp fim

Muli:
    xor ax,ax
    mov al,p
    mul S
    mov R,al 
    call resultado
    jmp fim

Divi:
    xor ax,ax
    mov al,p
    div S
    mov R,al 
    call resultado
    jmp fim

fim:
    sai_dos

getChar proc
    mov ax,0
    mov ah,07
    int 21h
    ret
endp

resultado proc
    mov ax,@data
    mov ds,ax
    mov ax,0
    mov al,R
    div b[2]
    mov Rs[0],al
    add Rs[0],48
    mov bx,0
    mov bl,ah
    mov ax,0
    mov al,bl
    div b[1]
    mov Rs[1],al
    add Rs[1],48
    mov Rs[2],ah
    add Rs[2],48
    lea dx,Rs
    mov ah,09
    int 21h
    ret
endp

END

