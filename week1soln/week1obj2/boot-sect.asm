; semicolons indicate comments
; Goal: Print a message stored at a memory location using a function

[org 0x7c00] ; tells assembler expected loading address of code

mov bx, HELLO_MSG ; bx as parameter to function print_string
call print_string

mov dx, 0x1fb6 ; dx as parameter to function print_hex
call print_hex

jmp $ ; endless jump to current address

%include "print_string.asm"
%include "print_hex.asm"

; Data
HELLO_MSG:
	db 'Hello, World!', 0 ; strings are null-terminating (hence the 0)

; bootsector (BS) padding and magic number
times 510-($-$$) db 0 ;  BS (512 bytes) padding
dw 0xaa55 ; BS magic number (34 12) tells BIOS this is the BS
