; semicolons indicate comments
; Goal: Print a message stored at a memory location using a function

[org 0x7c00] ; tells assembler expected loading address of code

; Complete 16-bit string display
; Call switch function

%include "print_string.asm"
%include "print_string_pm.asm"
%include "gdt.asm"
%include "switch_to_pm.asm"

[bits 32] ; tells assembler to encode in 32-bit mode instructions from now on

; Complete 32-bit string display

; bootsector (BS) padding and magic number
times 510-($-$$) db 0 ;  BS (512 bytes) padding
dw 0xaa55 ; BS magic number (34 12) tells BIOS this is the BS