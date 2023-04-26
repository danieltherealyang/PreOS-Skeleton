; semicolons indicate comments
; Goal: Print a message stored at a memory location using a function

[org 0x7c00] ; tells assembler expected loading address of code

mov bp, 0x9000 ; set the stack
mov sp, bp
	
mov bx, MSG_REAL_MODE 
call print_string
	
call switch_to_pm ; NOTE: we never return from here

jmp $ ; endless jump to current address

%include "print_string.asm"
%include "print_string_pm.asm"
%include "gdt.asm"
%include "swtich_to_pm.asm"

[bits 32] ; tells assembler to encode in 32-bit mode instructions from now on
	mov ebx, MSG_PROT_MODE
	call print_string_pm ; 32-bit print routine

	jmp $ ; endless jump to current address, aka hang

; Global Variables
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Successfully landed in 32-bit Protected Mode"

; bootsector (BS) padding and magic number
times 510-($-$$) db 0 ;  BS (512 bytes) padding
dw 0xaa55 ; BS magic number (34 12) tells BIOS this is the BS