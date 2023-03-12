; 判断一段数据中正数和负数的个数
; 可以出现在[]内的寄存器有 bx si bp di
; nasm ../LiZhongCmp.asm -o ../LiZhongCmp.bin -l ../LiZhongCmp.list

;0x7c00 07c0:0000
jmp start
date1: db 0x05,0xff,0x80,0xf0,0x97,0x30 ; + - + - +
date2: dw 0x90,0xfff0,0xa0,0x1235,0x2f,0xc0,0xc5bc ;2 5
start: 
	; al 中存放正数的个数
	; dl 中存放负数的个数
	mov ax,0x07c0
	mov ds,ax
	
	xor al,al
	xor dl,dl

	mov cx,date2-date1
	mov si,date1
CountDate1:
	cmp byte[si],0x80 ;1000 0000
	ja  Fcount
	jnae Zcount ; jmp not great
Zcount:	
	inc al
	jmp En
Fcount:
	inc dl
En:
	inc si
	loop CountDate1 
	
	add al,0x30
	add dl,0x30
	mov ah,0x04
	mov dh,0x04
	
	mov cx,0xB800
	mov	es,cx
	mov [es:0x00],ax
	mov byte[es:0x02],' '
	mov byte[es:0x03],0x04
	mov [es:0x04],dx
	mov byte[es:0x06],' '
	mov byte[es:0x07],0x04
	
	
	xor al,al
	xor dl,dl
	mov cx,(start-date2)/2
	mov si,date2
CountDate2:
	cmp word[si],0x8000 ;1000 0000 
	ja  Fcount1
	jnae Zcount1 ; jmp not great
Zcount1:	
	inc al
	jmp En1
Fcount1:
	inc dl
En1:
	add si,2
	loop CountDate2 
	
	add al,0x30
	add dl,0x30
	mov ah,0x04
	mov dh,0x04
	
	mov cx,0xB800
	mov	es,cx
	mov [es:0x08],ax
	mov byte[es:0x0A],' '
	mov byte[es:0x0B],0x04
	mov [es:0x0C],dx
	mov byte[es:0x0E],' '
	mov byte[es:0x0F],0x04
	

	jmp $
	times 510-($-$$) db 0
	dw 0xAA55