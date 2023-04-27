; semicolons indicate comments
; Goal: Print a message stored at a memory location using a function

[org 0x7c00] ; tells assembler expected loading address of code
KERNEL_OFFSET equ 0x1000 ; memory offset to which we will load kernel
mov [BOOT_DRIVE], dl

; Todo: print MSG_REAL_MODE
; Todo: load kernel (load_kernel) and switch to PM

jmp $ ; endless jump to current address

%include "print_string.asm"
%include "print_string_pm.asm"
%include "disk_load.asm"
%include "gdt.asm"
%include "switch_to_pm.asm"

[bits 16]
load_kernel:

	; Todo: print MSG_LOAD_KERNEL
	; Todo: load kernel

[bits 32] ; tells assembler to encode in 32-bit mode instructions from now on
BEGIN_PM:

	; Todo: print MSG_PROT_MODE

	call KERNEL_OFFSET
	jmp $ ; endless jump to current address, aka hang

; Global Variables
BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Successfully landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

; bootsector (BS) padding and magic number
times 510-($-$$) db 0 ;  BS (512 bytes) padding
dw 0xaa55 ; BS magic number (34 12) tells BIOS this is the BS