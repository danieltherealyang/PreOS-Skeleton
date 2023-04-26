; semicolons indicate comments
; Goal: Read from disk, load memory, and print data in loaded memory sectors. 


[org 0x7c00] ; tells assembler expected loading address of code

mov [BOOT_DRIVE], dl ; BIOS stores boot drive in dl

mov bp, 0x8000 ; store stack safely out of the way (higher than 7c00)
mov sp, bp
	
mov bx, 0x9000 ; Load 5 sectors to 0x000(ES):0x9000(BX) from boot disk
mov dh, 2
mov dl, [BOOT_DRIVE] 
call disk_load
	
mov dx, [0x9000] ; print first loaded word, 
call print_hex ; expected to be 0xdada at address 0x9000
mov dx, [0x9000 + 512] ; print first loaded word from second sector, 
call print_hex ; expected to be 0xface

jmp $ ; endless jump to current address

%include "print_string.asm"
%include "print_hex.asm"
%include "disk_load.asm"

; Data
BOOT_DRIVE: db 0

; bootsector (BS) padding and magic number
times 510-($-$$) db 0 ;  BS (512 bytes) padding
dw 0xaa55 ; BS magic number (34 12) tells BIOS this is the BS

; BIOS only loads first 512-byte sector from disk, 
; so any more sectors added will not be loaded into memory 
; and stay on persistent storage.
times 256 dw 0xdada
times 256 dw 0xface
