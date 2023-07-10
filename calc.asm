include 'emu8086.inc'

pila segment 
    db 64 dup(0)
pila ends

datos segment 
    signo1 db ?
    signo2 db ?
    operador db ? 
    signos db ? 
    u1 db ?
    d1 db ?
    ud1 db ?
    dd1 db ?
    u2 db ?  
    d2 db ?
    ud2 db ?
    dd2 db ?
    x db 2
    y db 2 
    aux dw ?
    num1 dw ?
    num2 dw ?
    n1 db ?
    n2 db ?
    n3 db ?
    n4 db ?
    n5 db ?
    n6 db ?
    n7 db ?
    n8 db ? 
    repeticion db ?
datos ends

codigo segment
    main proc far
        assume ss:pila,ds:datos,cs:codigo
        
        push ds
        mov ax,0
        push ax
        
        mov ax,datos
        mov ds,ax
        mov es,ax
    
   ;-----------------------------------      
               
    mov signo1,2Bh
    mov signo2,2Bh           
               
    gotoxy x,y   
    call pthis
    db 'Calculadora',0 
    mov y,4
    gotoxy x,y 
    
    call pthis
    db 'Introduzca el primer numero: ',0
    
    
    
    mov ah,01h 
    int 21h
    cmp al,2Dh
    jne primerdigito 
    mov signo1,al
    mov ah,01h
    int 21h
    primerdigito:
    sub al,30h
    mov bl,al
    mov ax,0
    
    entrada:
    mov ah,01h
    int 21h
    cmp al,0Dh
    je intoperador
    cmp al,2Eh
    je coma
    
    sub al,30h
    mov bh,al
    mov al,bl
    mov bl,10
    mul bl
    add al,bh 
    mov bl,al
    mov ax,0
    jmp entrada
    
    coma:
    mov ah,01h
    int 21h
    sub al,30h
    mov cl,al
    mov ax,0
    
    mov ah,01h
    int 21h
    cmp al,0Dh
    je intoperador
    sub al,30h
    mov ch,al
    mov al,cl
    mov cl,10
    mul cl
    add al,ch
    mov cl,al
    mov bh,bl
    mov bl,cl
    mov ax,0
    mov cx,0
    
    intoperador:
    
    mov al,bl
    aam
    mov ud1,al
    mov dd1,ah
    mov ax,0
    mov al,bh
    aam
    mov u1,al
    mov d1,ah
    
    mov y,6
    gotoxy x,y
    
    call pthis
    db 'Introduzca uno de los operadores + , - , * , /  : ' ,0 
    
    
    
    
    mov ah,01h
    int 21h 
    mov operador,al
    
    mov y,8
    gotoxy x,y
     
     
    cmp operador,2Bh
    je suma
    cmp operador,2Dh
    je resta
    cmp operador,2Ah
    je multiplicacion
    cmp operador,2Fh
    je division
    
    suma:
    
    call pthis
    db 'Introduzca el segundo numero: ',0 
    
    mov cx,0
    mov dx,0 
    
    
    
    mov ah,01h 
    int 21h 
    cmp al,2Dh
    jne primerdigito1
    mov signo2,al
    mov ah,01h 
    int 21h 
    primerdigito1:
    sub al,30h
    mov dl,al
    
    entrada3:
    mov ah,01h
    int 21h
    cmp al,0Dh
    je resultado
    cmp al,2Eh
    je coma1
    
    sub al,30h
    mov dh,al
    mov al,dl
    mov dl,10
    mul dl
    add al,dh 
    mov dl,al
    mov ax,0
    jmp entrada3
    
    coma1:
    mov ah,01h
    int 21h
    sub al,30h
    mov cl,al
    mov ax,0
    
    mov ah,01h
    int 21h
    cmp al,0Dh
    je resultado
    sub al,30h
    mov ch,al
    mov al,cl
    mov cl,10
    mul cl
    add al,ch
    mov cl,al
    mov dh,dl
    mov dl,cl
    mov cx,0
    mov al,signo1
    cmp al,signo2
    jne sigcomp
    mov signos,al
    jmp comienzasuma
    sigcomp:
    cmp signo1,'-'
    jne iniciaresta
    mov signos,'-'
    cmp bx,dx
    jg iniciaresta
    mov ax,bx
    mov bx,dx
    mov dx,ax
    mov signos,'+'
    jmp iniciaresta
    
    
    comienzasuma:
    add bh,dh
    add bl,dl
    cmp bl,100d
    jl movon
    
    sub bl,100
    add bh,1
    
    
    
    movon:
    
    mov y,10
    gotoxy x,y
  
    call pthis
    db 'El resultado de la operacion es: ',0  
    
    mov x,35
    gotoxy x,y
    
    cmp signos,'-'
    jne salto
    mov ah,02h
    mov dl,'-'
    int 21h
    xor ax,ax
    mov al,bl
    aam
    mov dd1,ah
    mov ud1,al
    xor ax,ax
    jmp resultado
    
    salto:
    
    
    mov al,bl
    aam
    mov dd1,ah
    mov ud1,al
    xor ax,ax
    
    
    jmp resultado
   
    resta:
          
    call pthis
    db 'Introduzca el segundo numero: ',0 
    
    mov cx,0
    mov dx,0 
    
    
    
    mov ah,01h 
    int 21h 
    cmp al,2Dh
    jne primerdigito2
    mov signo2,al
    mov ah,01h 
    int 21h 
    primerdigito2:
    sub al,30h
    mov dl,al
    
    entrada1:
    mov ah,01h
    int 21h
    cmp al,0Dh
    je resultado
    cmp al,2Eh
    je coma3
    
    sub al,30h
    mov dh,al
    mov al,dl
    mov dl,10
    mul dl
    add al,dh 
    mov dl,al
    mov ax,0
    jmp entrada1
    
    coma3:
    mov ah,01h
    int 21h
    sub al,30h
    mov cl,al
    mov ax,0
    
    mov ah,01h
    int 21h
    cmp al,0Dh
    je resultado
    sub al,30h
    mov ch,al
    mov al,cl
    mov cl,10
    mul cl
    add al,ch
    mov cl,al
    mov dh,dl
    mov dl,cl
    mov cx,0
    
    mov al,signo1
    cmp al,signo2
    je qsigno
    cmp signo1,'-'
    jne comienzasuma
    mov signos,'-'
    jmp comienzasuma
    
    qsigno:
    cmp signo1,'-'
    jne iniciaresta
    mov ax,bx
    mov bx,dx
    mov dx,ax
    mov ax,0 
   
    
    iniciaresta:
    
    
    mov al,bl
    aam
    mov ud1,al
    mov dd1,ah
    mov al,dl
    aam
    mov ud2,al
    mov dd2,ah
    mov ax,0 
    
    cmp bh,dh
    jg restav1
    cmp bh,dh
    je restav2
    mov al,bh
    mov bh,dh
    mov dh,al
    mov al,bl
    mov bl,dl
    mov dl,al
    mov al,ud1
    mov ah,ud2
    mov ud1,ah
    mov ud2,al
    mov al,dd1
    mov ah,dd2
    mov dd1,ah
    mov dd2,al
    mov signos,2Dh 
    mov ax,0
    
    
    restav1:
    mov ax,0 
    sub bh,dh
    mov al,ud2
    cmp ud1,al
    jge avanza
    mov al,ud1
    add al,10
    mov ud1,al
    mov al,ud2
    sub ud1,al
    mov al,dd2
    add al,1
    mov dd2,al
    jmp comparacion
    
    
    avanza:
    mov ax,0 
    mov ah,ud1
    mov al,ud2
    sub ah,al
    mov ud1,ah
    comparacion:
    mov ax,0
    mov al,dd2
    cmp dd1,al
    jge avanza1
    mov al,dd1
    add al,10
    mov dd1,al
    mov ah,dd1
    mov al,dd2
    sub ah,al
    mov dd1,ah
    sub bh,1
    cmp signos,2Dh
    je resultadoimprimiendomenos
    jmp resultadosinmenos
    
    
    avanza1:
    mov al,dd2
    sub dd1,al
    cmp signos,2Dh
    je resultadoimprimiendomenos
    jmp resultadosinmenos    
    
     
    restav2:
    cmp bl,dl
    jge avanza2
    sub dl,bl
    mov bl,dl
    mov al,bl
    aam
    mov ud1,al
    mov dd1,ah
    sub bh,dh
    jmp resultadoimprimiendomenos
    avanza2:
    sub bl,dl
    mov al,bl
    aam
    mov ud1,al
    mov dd1,ah
    sub bh,dh
    cmp signos,2Dh
    je resultadoimprimiendomenos 
    jmp resultadosinmenos
    
    
    resultadoimprimiendomenos:
    mov y,10
    gotoxy x,y
  
    call pthis
    db 'El resultado de la operacion es: ',0  
    
    mov x,35
    gotoxy x,y
    
    mov ah,02h
    mov dl,'-'
    int 21h
    
    jmp resultado
    
     
    
    resultadosinmenos:
    mov y,10
    gotoxy x,y
    
    call pthis
    db 'El resultado de la operacion es: ',0  
    
    mov x,35
    gotoxy x,y
    
    
    jmp resultado      
          
    multiplicacion: 
    
    mov al,bl
    aam
    mov dl,al
    mov dh,ah
    xor ax,ax
    mov al,bh
    aam
    mov ch,ah
    mov cl,al
    xor ax,ax
    
    mov al,ch
    xor bx,bx
    mov bx,10
    mov aux,dx
    mul bx
    mov dx,aux
    xor bx,bx
    mov ch,0
    mov bx,cx
    xor bx,bx
    mov bx,10
    add ax,cx
    mul bx
    mov dx,aux
    xor bx,bx
    mov bl,dh
    add ax,bx
    xor bx,bx
    mov bx,10
    mul bx
    mov dx,aux
    xor bx,bx
    mov dh,0
    mov bx,dx
    add ax,bx
    mov num1,ax
    
    
    call pthis
    db 'Introduzca el segundo numero: ',0 
    
    mov cx,0
    mov dx,0 
    
    
    
    mov ah,01h 
    int 21h 
    cmp al,2Dh
    jne primerdigito4
    mov signo2,al
    mov ah,01h 
    int 21h 
    primerdigito4:
    sub al,30h
    mov dl,al
    
    entrada4:
    mov ah,01h
    int 21h
    cmp al,0Dh
    je resultado
    cmp al,2Eh
    je coma4
    
    sub al,30h
    mov dh,al
    mov al,dl
    mov dl,10
    mul dl
    add al,dh 
    mov dl,al
    mov ax,0
    jmp entrada4
    
    coma4:
    mov ah,01h
    int 21h
    sub al,30h
    mov cl,al
    mov ax,0
    
    mov ah,01h
    int 21h
    cmp al,0Dh
    je resultado
    sub al,30h
    mov ch,al
    mov al,cl
    mov cl,10
    mul cl
    add al,ch
    mov cl,al
    mov dh,dl
    mov dl,cl
    
    mov bx,dx
    mov dx,0
    mov cx,0
    mov ax,0
    
    mov al,bl
    aam
    mov dl,al
    mov dh,ah
    xor ax,ax
    mov al,bh
    aam
    mov ch,ah
    mov cl,al
    xor ax,ax
    
    mov al,ch
    xor bx,bx
    mov bx,10
    mov aux,dx
    mul bx
    mov dx,aux
    xor bx,bx
    mov ch,0
    mov bx,cx
    xor bx,bx
    mov bx,10
    add ax,cx
    mul bx
    mov dx,aux
    xor bx,bx
    mov bl,dh
    add ax,bx
    xor bx,bx
    mov bx,10
    mul bx
    mov dx,aux
    xor bx,bx
    mov dh,0
    mov bx,dx
    add ax,bx
    mov num2,ax 
    
    
    mov ax,num1
    mov bx,num2
    mul bx 
    
    xor bx,bx
    xor cx,cx
    
    mov bx,10000
    div bx 
    
    mov aux,ax
    mov ax,dx
    
    xor dx,dx
    xor bx,bx
    
    mov bx,10
    div bx
    add dl,30h
    mov n8,dl
   
    xor dx,dx 
    div bx
    add dl,30h
    mov n7,dl
    
    xor dx,dx 
    div bx
    add dl,30h
    mov n6,dl
    
    xor dx,dx 
    div bx
    add dl,30h
    mov n5,dl
    
    xor dx,dx
    xor bx,bx
    xor ax,ax
    
    mov ax,aux 
    
    mov bx,10
    div bx
    add dl,30h
    mov n4,dl
   
    xor dx,dx 
    div bx
    add dl,30h
    mov n3,dl
    
    xor dx,dx 
    div bx
    add dl,30h
    mov n2,dl
    
    xor dx,dx 
    div bx
    add dl,30h
    mov n1,dl
    
    
    
    
    mov y,10
    gotoxy x,y
  
    call pthis
    db 'El resultado de la operacion es: ',0  
    
    mov x,35
    gotoxy x,y
    
    
    
       
    
    mov al,signo1
    cmp al,signo2
    je nomenos
    
    mov ah,02h
    mov dl,'-'
    int 21h
    
    nomenos: 
    
    mov x,36
    gotoxy x,y
    
    mov ah,02h
    mov dl,n1
    int 21h
    
    mov x,37
    gotoxy x,y
    
    mov ah,02h
    mov dl,n2
    int 21h
    
    mov x,38
    gotoxy x,y
    
    mov ah,02h
    mov dl,n3
    int 21h
    
    mov x,39
    gotoxy x,y
    
    mov ah,02h
    mov dl,n4
    int 21h
    
    mov x,40
    gotoxy x,y
    
    mov ah,02h
    mov dl,'.'
    int 21h
    
    mov x,41
    gotoxy x,y
    
    mov ah,02h
    mov dl,n5
    int 21h
    
    mov x,42
    gotoxy x,y
    
    mov ah,02h
    mov dl,n6
    int 21h
    
    mov x,43
    gotoxy x,y
    
    mov ah,02h
    mov dl,n7
    int 21h
    
    mov x,44
    gotoxy x,y
    
    mov ah,02h
    mov dl,n8
    int 21h
    
    
    
     
            
    
    jmp terminarprograma
    
    division: 
    
    
    mov al,bl
    aam
    mov dl,al
    mov dh,ah
    xor ax,ax
    mov al,bh
    aam
    mov ch,ah
    mov cl,al
    xor ax,ax
    
    mov al,ch
    xor bx,bx
    mov bx,10
    mov aux,dx
    mul bx
    mov dx,aux
    xor bx,bx
    mov ch,0
    mov bx,cx
    xor bx,bx
    mov bx,10
    add ax,cx
    mul bx
    mov dx,aux
    xor bx,bx
    mov bl,dh
    add ax,bx
    xor bx,bx
    mov bx,10
    mul bx
    mov dx,aux
    xor bx,bx
    mov dh,0
    mov bx,dx
    add ax,bx
    mov num1,ax
    
call pthis
    db 'Introduzca el segundo numero: ',0 
    
    mov cx,0
    mov dx,0 
    
    
    
    mov ah,01h 
    int 21h 
    cmp al,2Dh
    jne primerdigito5
    mov signo2,al
    mov ah,01h 
    int 21h 
    primerdigito5:
    sub al,30h
    mov dl,al
    
    entrada5:
    mov ah,01h
    int 21h
    cmp al,0Dh
    je resultado
    cmp al,2Eh
    je coma5
    
    sub al,30h
    mov dh,al
    mov al,dl
    mov dl,10
    mul dl
    add al,dh 
    mov dl,al
    mov ax,0
    jmp entrada5
    
    coma5:
    mov ah,01h
    int 21h
    sub al,30h
    mov cl,al
    mov ax,0
    
    mov ah,01h
    int 21h
    cmp al,0Dh
    je resultado
    sub al,30h
    mov ch,al
    mov al,cl
    mov cl,10
    mul cl
    add al,ch
    mov cl,al
    mov dh,dl
    mov dl,cl
    mov bx,dx
    mov dx,0
    mov cx,0
    mov ax,0 
    
    mov al,bl
    aam
    mov dl,al
    mov dh,ah
    xor ax,ax
    mov al,bh
    aam
    mov ch,ah
    mov cl,al
    xor ax,ax
    
    mov al,ch
    xor bx,bx
    mov bx,10
    mov aux,dx
    mul bx
    mov dx,aux
    xor bx,bx
    mov ch,0
    mov bx,cx
    xor bx,bx
    mov bx,10
    add ax,cx
    mul bx
    mov dx,aux
    xor bx,bx
    mov bl,dh
    add ax,bx
    xor bx,bx
    mov bx,10
    mul bx
    mov dx,aux
    xor bx,bx
    mov dh,0
    mov bx,dx
    mov dx,0
    add ax,bx
    mov num2,ax
    
    mov ax,num1
    mov bx,num2
    div bx
    
    mov aux,ax
    
    cmp dx,0
    je impresion
    mov ax,dx
    xor dx,dx
    xor bx,bx
    mov bx,10
    mul bx
    cmp ax,num2
    jl repetir1
    mov repeticion,'-'
    mov bx,num2
    div bx
    mov n5,al
    mov ax,dx
    xor dx,dx
    xor bx,bx
    mov bx,10
    repetir1:
    mov cl,repeticion
    cmp cl,'-'
    je jump
    mov n5,00h
    jump:
    mov repeticion,00h
    mul bx
    cmp ax,num2
    jl repetir2
    mov repeticion,'-'
    mov bx,num2
    div bx
    mov n6,al
    mov ax,dx
    xor dx,dx
    xor bx,bx
    mov bx,10
    repetir2:
    mov cl,repeticion
    cmp cl,'-'
    je jump1
    mov n6,00h
    jump1:
    mul bx
    cmp ax,num2
    jl finitto
    mov bx,num2
    div bx
    mov n7,al
    jmp aqui
    finitto:
    mov n7,00h
    aqui:
    xor ax,ax
    xor bx,ax
    xor cx,ax
    xor dx,ax
             
    cmp n7,5
    jl impresion
    mov al,n6
    add al,1
    mov n6,al
    cmp al,10
    jl impresion
    sub al,10
    mov n6,al
    mov al,n5
    add al,1
    mov n5,al
    cmp al,10
    jl impresion
    sub al,10
    mov n5,al
    mov ax,aux
    add ax,1
    mov aux,ax 
             
    
    impresion:
              
    xor dx,dx
    xor bx,bx
    xor ax,ax
    
    mov ax,aux 
    
    mov bx,10
    div bx
    add dl,30h
    mov n4,dl
   
    xor dx,dx 
    div bx
    add dl,30h
    mov n3,dl
    
    xor dx,dx 
    div bx
    add dl,30h
    mov n2,dl
    
    xor dx,dx 
    div bx
    add dl,30h
    mov n1,dl 
    
    mov y,10
    gotoxy x,y
  
    call pthis
    db 'El resultado de la operacion es: ',0  
    
    mov x,35
    gotoxy x,y
    
    
    
       
    
    mov al,signo1
    cmp al,signo2
    je nomenos1
    
    mov ah,02h
    mov dl,'-'
    int 21h
    
    nomenos1: 
    
    mov x,36
    gotoxy x,y
    mov cl,n1
    cmp cl,00h
    je brinca
    mov ah,02h
    mov dl,n1
    int 21h
    
    brinca:
    
    mov x,37
    gotoxy x,y
    mov cl,n1
    cmp cl,00h  
    je brinca1
    mov ah,02h
    mov dl,n2
    int 21h
    
    brinca1:
    mov cl,n2
    cmp cl,00h
    je brinca2
    mov ah,02h
    mov dl,n2
    int 21h
    
    brinca2:
    
    mov x,38
    gotoxy x,y
    
    mov ah,02h
    mov dl,n3
    int 21h
    
    mov x,39
    gotoxy x,y
    
    mov ah,02h
    mov dl,n4
    int 21h
    
    mov x,40
    gotoxy x,y
    
    mov ah,02h
    mov dl,'.'
    int 21h
    
    mov x,41
    gotoxy x,y
    
    mov al,n5
    add al,30h
    mov n5,al
    
    mov ah,02h
    mov dl,n5
    int 21h
    
    mov x,42
    gotoxy x,y 
    
    mov al,n6
    add al,30h
    mov n6,al
    
    mov ah,02h
    mov dl,n6
    int 21h
    
    
    
    jmp terminarprograma
    
    
    
    resultado:
    
    mov x,36
    gotoxy x,y
    
    mov al,bh
    aam
    mov cx,ax
    add ch,30h
    add cl,30h
    mov ah,02h
    mov dl,ch 
    int 21h
    
    mov x,37 
    gotoxy x,y
    
    mov ah,02h
    mov dl,cl
    int 21h
    
    mov x,38
    gotoxy x,y
    
    mov ah,02h
    mov dl,'.'
    int 21h
    
    mov x,39
    gotoxy x,y
    
    mov al,dd1
    add al,30h
    mov dd1,al
    mov ah,02h
    mov dl,dd1 
    int 21h
    
    mov x,40 
    gotoxy x,y
    
    mov al,ud1
    add al,30h
    mov ud1,al
    mov ah,02h
    mov dl,ud1
    int 21h 
    
    terminarprograma:
    
    
      

   ;-----------------------------------
   
ret
  main endp
  codigo ends

define_pthis
       
       
end main