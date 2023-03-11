; r 查看寄存器的状态?
; s 单步执行
; xor 异或
; xor r/m r/m/imm r寄存器 m内存 imm立即数 两个操作数的长度必须相同
; add 和 xor 要求一样

start:
	mov bx,0x7c00
	mov es,bx
	mov bx,0xB800
	mov ds,bx
	
	mov ax,65535
	mov dx,0 
	; xor dx,dx
	; 操作数都是寄存器，速度比较快
	mov cx,10
	div cx
	
	add dl,0x30
	mov byte[es:buffer],dl
	; 开辟五个字节的空间 --- 名义上的 得确定他的地址


	mov dx,0
	div cx
	add dl,0x30
	mov byte[es:buffer+1],dl
	
	
	mov dx,0
	div cx
	add dl,0x30
	mov byte[es:buffer+2],dl
	
	mov dx,0
	div cx
	add dl,0x30
	mov byte[es:buffer+3],dl
	
	mov dx,0
	div cx
	add dl,0x30
	mov byte[es:buffer+4],dl
	
	
	
	; 设置写入显存的地方

	
	mov dl,[es:buffer+4]
	mov byte[ds:0x00],dl
	mov byte[ds:0x01],0x04
	
	mov dl,[es:buffer+3]
	mov byte[ds:0x02],dl
	mov byte[ds:0x03],0x04
	
	mov dl,[es:buffer+2]
	mov byte[ds:0x04],dl
	mov byte[ds:0x05],0x04
	
	mov dl,[es:buffer+1]
	mov byte[ds:0x06],dl
	mov byte[ds:0x07],0x04
	
	mov dl,[es:buffer]
	mov byte[ds:0x08],dl
	mov byte[ds:0x09],0x04
	
	
again:	jmp again
buffer: db 0,0,0,0,0
current:
	times 510-(current-start) db 0
	dw 0xAA55