
.model small

Imprime_s MACRO STR

    MOV AH,09        ;Faz a impressão simples das matrizes.
    LEA DX,STR
    INT 21H

ENDM

pula_l MACRO

    mov ah,02
    mov dl,10       ;Utilizado para pular linhas.
    int 21h
    XOR AH,AH

endm

ESPACO MACRO

    mov ah,02
    mov dl,' '     ;Espaçamento para o design da matriz.
    int 21h
    XOR AH,AH

ENDM

DIG_NUM MACRO
    AND AL,0FH     ;Transforma digito em numero.
    XOR AH,AH
ENDM

LE_VALOR MACRO

mov ah,01h       ;Le o valor digitado pelo usuario.
int 21h

endm

corzinha macro

    mov ah,00
    MOV Al,03
    INT 10H
    mov Ah,09h       ;Instrucoes para que mude a cor do termianl ao rodar o codigo.
    mov bh,00
    mov al,20H
    mov cx,800h
    mov bl,3fh
    int 10h

    endm


.stack 200h
.data
        bemv db 10,13,'                 BEM VINDO ao jogo SUDOKU','$',10,13
        MATC DB 10,13,'  A matriz correta eh:','$',10,13
        MATnp DB 10,13,'  A matriz que voce tem que preencher eh:','$',10,13
        Linha DB 10,13,'  Escolha a linha: ','$',10,13
        coluna DB 10,13,'  Escolha a coluna: ','$',10,13
        VALOR DB 10,13,'  QUAL VALOR DESEJA INSERIR: ','$',10,13
        VALOR_E DB 10,13,'  ERRADO! Tente novamente ','$',10,13
        VALOR_C DB 10,13,'  CERTO! Parabens !!','$',10,13
        GANHOU DB 10,13,'!! PARABENS VOCE SOLUCIONOU O JOGO !!','$',10,13
        escolha db 10,13,'  ESCOLHA SE VOCE QUER JOGAR O JOGO FACIL(1) OU DIFICIL(2): ','$',10,13
        NOVAMENTE DB 10,13,'   Deseja jogar novamente? (s/n): ','$',10

        MC  DB 35H,33H,34H,36H,37H,38H,39H,31H,32H
            DB 36H,37H,32H,31H,39H,35H,33H,34H,38H
            DB 31H,39H,38H,33H,34H,32H,35H,36H,37H
            DB 38H,35H,39H,37H,36H,31H,34H,32H,33H
            DB 34H,32H,36H,38H,35H,33H,37H,39H,31H
            DB 37H,31H,33H,39H,32H,34H,38H,35H,36H
            DB 39H,36H,31H,35H,33H,37H,32H,38H,34H
            DB 32H,38H,37H,34H,31H,39H,36H,33H,35H
            DB 33H,34H,35H,32H,38H,36H,31H,37H,39H
 

    MNP DB 35H,33H,2 DUP ('_'),37H,4 DUP ('_')
        DB 36H,2 DUP ('_'),31H,39H,35H, 3 DUP ('_')
        DB '_',39H,38H,4 DUP ('_'),36H,'_'
        DB 38H,3 DUP ('_'),36H,3 DUP ('_'),33H
        DB 34H,2 DUP ('_'),38H,'_',33H,2 DUP ('_')
        DB 37H,3 DUP ('_'), 32H ,3 DUP ('_'),36H
        DB '_',36H,4 DUP ('_'),32H,38H,'_'
        DB 3 DUP ('_'),34H,31H,39H,2 DUP ('_'),35H
        DB 4 DUP ('_'),38H,3 DUP ('_'),37H,39H
 
       MC2  DB 36H,34H,33H,35H,39H,37H,38H,32H,31H
            DB 31H,32H,38H,36H,34H,33H,35H,37H,39H
            DB 37H,35H,39H,32H,31H,38H,34H,36H,33H
            DB 34H,36H,32H,37H,35H,31H,33H,39H,38H
            DB 39H,33H,31h,38H,36H,34H,32H,35H,37H
            DB 35H,38H,37H,33H,32H,39H,31H,34H,36H
            DB 33H,37H,35H,34H,38H,36H,39H,31H,32H
            DB 38H,39H,34H,31H,37H,32H,36H,33H,35H
            DB 32H,31H,36H,39H,33H,35H,37H,38H,34H
 

       MNP2 DB 4 DUP ('_'),39H,'_',38h,32h,'_'
            DB 31H,32H,4 DUP ('_'),35H,'_',39H
            DB 37H,'_',39H,'_',31h,4 DUP ('_')
            DB '_',36H,32h, 37H,'_',31H,'_',39h,38H
            DB 4 DUP ('_'),36H,4 DUP ('_')
            DB '_', 38H ,'_',33H,'_',39h,31h,34h,'_'
            DB 4 DUP ('_'),38H,'_',39H,'_',32h
            DB 38h,'_',34H,4 DUP ('_'),33H,'_'
            DB '_',31h,36H,'_',33h,4 DUP ('_')


       RAS  DB 9 DUP (9 DUP(?))   ;Matriz rascunho para que seja alterada sem subescrever a original,

        

    trofeu DB 10,'              ___________     ',13
           DB 10,'             "._==_==_=_."     ',13
           DB 10,'            .-\\:      /-.    ',13
           DB 10,'            | (|:.     |) |    ',13
           DB 10,'             "-|:.     |-"     ',13
           DB 10,'               \\::.    /      ',13    ;Recompensa final.
           DB 10,'                "::. ."        ',13
           DB 10,'                  ) (          ',13
           DB 10,'                _." "._        ',13
           DB 10,'               "-------"       ',13,'$'
 

.code

main proc

corzinha


    MOV AX,@DATA
    MOV DS,AX



Imprime_s bemv
pula_l


volta_tudo: ;caso queria jogar de novo


;CALL VALOR_O1

Imprime_s escolha   ;ESCOLHE DIFICULDADE DO JOGO
LE_VALOR

CMP AL,32H
JNZ CONTI_F         ;PARA AUMENATR TAMANHO DO SALTO CONDICIONAL
JMP DIFICIL
CONTI_F:

CALL VALOR_O1

Imprime_s MATnp
pula_l
pula_l
LEA BX,RAS
CALL IMPRESSAO ;IMPRIME MATRIZ

VOLTA3:
XOR BX,BX
Imprime_s linha
LE_VALOR

CMP AL,13
JnE CONTINUA     ;Recebe a posição da linha que deseja inserir a resposta.
JMP SAI
CONTINUA:

DIG_NUM
MOV BX,AX   ; LINHA3
 
Imprime_s coluna
LE_VALOR

CMP AL,13
JnE CONTINUA1      ;Recebe a posição da coluna que deseja inserir a resposta.
JMP SAI
CONTINUA1:

DIG_NUM
MOV SI,AX   ; COLUNA

pula_l

Imprime_s VALOR
LE_VALOR
XOR AH,AH
MOV DI,AX

pula_l
 
call compara1   ;COMPARA E CASO CORRETO INSERE O VALOR NA POSICAO ALMEJADA
PUSH CX

pula_l
LEA BX,RAS      ;Rascunho recebe a matriz facil para ser jogada.
CALL IMPRESSAO

POP CX

CMP CL,50     ;Verifica se todas as respostas do sudoku facil foram preenchidas.
JNZ VOLTA3

JMP FIM

DIFICIL:

CALL VALOR_O

Imprime_s MATnp
pula_l
pula_l

LEA BX,RAS    ;Rascunho recebe a matriz dificil para ser jogada.
CALL IMPRESSAO 

VOLTA2:

XOR BX,BX
Imprime_s linha
LE_VALOR

CMP AL,13
JE SAI     ;Recebe a posição da linha que deseja inserir a resposta.
DIG_NUM

MOV BX,AX   ; LINHA3

Imprime_s coluna
LE_VALOR

CMP AL,13
JE SAI     ;Recebe a posição da coluna que deseja inserir a resposta.
DIG_NUM
MOV SI,AX   ; COLUNA

pula_l

Imprime_s VALOR
LE_VALOR
XOR AH,AH
MOV DI,AX

pula_l

call compara     ;Faz a comparação com a matriz gabarito.
PUSH CX

pula_l
LEA BX,RAS
CALL IMPRESSAO

POP CX

CMP CL,52    ;Verifica se todas as respostas do sudoku dificil foram preenchidas.
JNZ VOLTA2

FIM:
Imprime_s GANHOU
Imprime_s trofeu

SAI:

Imprime_s NOVAMENTE
LE_VALOR
pula_l
cmp al,'s'      ;Pergunta se deseja jogar novamente. Se 's', retorna desde o inicio.
jne acaba

jmp volta_tudo
pula_l

acaba:
MOV AH,4CH
INT 21H

MAIN endp 

IMPRESSAO proc

pula_l

    XOR AX,AX
    mov ch,9
laco2i:

    mov cl,9      ;Faz a impressao padrao da matriz no terminal.
    xor si,si

    ESPACO
    ESPACO

 laco1i:  
    mov dl,[bx][si]
    inc si
    mov ah,02
    int 21h
    ESPACO
    dec cl

    PUSH CX ;ESPACO ENTRA AS MATRIZES
    xchg CL,AL
    MOV DL,3
    DIV DL
    CMP AH,00H    ;Ao contar tres posicoes insere um espaco dentre elas.
    JNE SEM_SEP
    ESPACO
SEM_SEP:
    POP CX

    CMP CL,00H
    jnz laco1i
    pula_l
    add bx,9
    dec ch

    PUSH CX     ;PULA LINHA ENTRA AS MATRIZES
    xchg CH,AL
    MOV DL,3
    DIV DL
    CMP AH,00H
    JNE SEM_PUL
    pula_l
SEM_PUL:
    POP CX

    CMP CH,00H
    jnz laco2i
    ret

IMPRESSAO ENDP

 

compara proc

    mov ch,9
    dec SI   ; COLUNA
    dec bX   ; LINHA

    XOR AH,AH
    xchg AX,BX
    mul ch      ;MULTIPLICA 9 PARA A PROX LINHA (LOCALIZACAO CERTA)
    xchg AX,BX

    MOV AX,DI
    MOV DL,MC[BX][SI]
    CMP DL,AL     ;Verifica se o digito inserido eh o correto na matriz gabarito.
    JZ CERTO        

    Imprime_s VALOR_E
    pula_l

    JMP SAI1 

CERTO:

    PUSH AX
    Imprime_s VALOR_C    ;Se sim, ele imprime correto e substitui a resposta na matriz rascunho.
    POP AX

    mov RAS[BX][SI],AL
    XOR CH,CH
    INC cl

SAI1:

    RET

compara endp

compara1 proc

    mov ch,9
    dec SI   ; COLUNA
    dec bX   ; LINHA

    XOR AH,AH
    xchg AX,BX
    mul ch      ;MULTIPLICA 9 PARA A PROX LINHA
    xchg AX,BX

    MOV AX,DI
    MOV DL,MC2[BX][SI]
    CMP DL,AL  ;Verifica se o digito inserido eh o correto na matriz gabarito.
    JZ CERTO2

    Imprime_s VALOR_E
    pula_l

    JMP SAI2

CERTO2:

    PUSH AX
    Imprime_s VALOR_C   ;Se sim, ele imprime correto e substitui a resposta na matriz rascunho.
    POP AX

    mov RAS[BX][SI],AL
    XOR CH,CH
    INC cl

SAI2:
   RET

compara1 endp
 

 VALOR_O proc
    
    XOR BX,BX
    mov ch,9
lacoiN:

    mov cl,9
    xor si,si

 lacoEX:  
    mov dl,MNP[bx][si]
    MOV RAS[BX][SI],DL       ;Insere a matriz dificuldade facil na matriz rascunho para que possa jogar.
    inc si                      ;Sem que modifique a matriz original.
    dec cl
    JNZ lacoEX

    add bx,9
    dec ch
    jnz lacoiN
    ret

 VALOR_O ENDP

  VALOR_O1 proc
    XOR AX,AX
    mov ch,9
lacoiN1:

    mov cl,9
    xor si,si

 lacoEX1:  
    mov dl,MNP2[bx][si]    ;Insere a matriz dificuldade dificil na matriz rascunho para que possa jogar.
    MOV RAS[BX][SI],DL      ;Sem que modifique a matriz original.
    inc si
    dec cl
    jnz lacoEX1
    add bx,9
    dec ch
    jnz lacoiN1
    ret

 VALOR_O1 ENDP
END MAIN