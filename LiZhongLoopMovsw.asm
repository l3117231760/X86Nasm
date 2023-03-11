; loop  cx控制循环次数

; movsw  movsb 串传送指令(world byte)
; DS:SI 原始数据串的地址
; ES:DI 目的数据串的地址
; 在传送的时候SI和DI会自动变化
; FAGS  DF 位控制传送方向 大写表示1 小写表示0 
; 0低地址向高地址  1高地址向低地址
;cld 将标志位置0 std将标志位置 1

; rep movsw
; 重复的次数保存在cx中

; 标号的地址目前都是以0000为段的


;nasm ../LiZhongLoopMovsw.asm -o ../LiZhongLoopMovsw.bin -l ../LiZhongLoopMovsw.list

jmp start
data: db 'L',0x04,'a',0x04,'b',0x04,'l',0x04,'e',0x04,' ',0x04
	  db 'o',0x04,'f',0x04,'f',0x04,'s',0x04,'e',0x04,'t',0x04,':',0x04
start:
	; 原始数据串
	mov ax,0x07c0
	mov ds,ax
	mov si,data
	
	;目的数据串
	mov ax,0xB800
	mov es,ax
	mov di,0
	; 传送次数
	cld
	mov cx,(start-data)/2
	rep movsw
	
	mov bp,sig
	mov ax,sig
	mov bx,10
	mov cx,5
Math:
	xor dx,dx
	div bx
	add dl,0x30
	mov [ds:bp],dl
	; ++
	inc bp
	Loop Math
	
	mov bp,sig
	add bp,4
	mov cl,4
show:
	; 可以用一个ax寄存器的 al 和 ah 传送到显存进行解决
	mov al,[ds:bp]
	mov [es:di],al
	inc di
	mov byte[es:di],0x04
	inc di
	dec bp
	
	dec cl
	jns show
	
	jmp $
;偏移地址最多4位16进制数最大5位数
sig: db 0,0,0,0,0
ED:
	times 510-($-$$) db 0
	dw 0xAA55
