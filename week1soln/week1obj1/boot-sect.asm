; semicolons indicate comments
; Goal: BIOS routine for printing a character
; Desired BIOS function: INT 0x10, AH = 0xE (display char)

mov ah, 0x0e
mov al, 'x' ; arbitrarily choose char x to print
int 0x10 

jmp $ ; endless jump to current address
	
; bootsector (BS) padding and magic number
times 510-($-$$) db 0 ;  BS (512 bytes) padding
dw 0xaa55 ; BS magic number (34 12) tells BIOS this is the BS