; semicolons indicate comments
; Goal: Function that prints a string message stored at an address

print_string: 
; bx: input parameter, has address to the string (see boot-sect.asm)
    pusha ; 16 bit

    mov ah, 0x0e ; INT 0x10, AH = 0xE - BIOS display char
    print_string_loop:
        mov al, [bx]
        cmp al, 0 ; null-terminate?
        je print_string_end ; end if null-terminate
        
        ; if not null-terminate
        int 0x10 ; print
        add bx, 1 ; increment
        jmp print_string_loop ; loop

    print_string_end:
        popa
        ret