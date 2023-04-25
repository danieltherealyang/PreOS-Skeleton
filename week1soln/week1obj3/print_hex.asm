; semicolons indicate comments
; Goal: Function that prints a hex message stored at an address

print_hex: ; dx: parameter
  pusha ; 16 bit

  mov cx, 4 ; counter (4 chars, reading chars from right to left)
  hex_loop:
    cmp cx, 0 ; if all 4 characters read
    je hex_end ; return if so

    dec cx ; decrement

    mov bx, HEX_OUT ; set bx to the memory address of string
    add bx, 2 ; skip the '0x'
    add bx, cx ; move to address of current char's target location
    
    mov ax, 0xf ; bit mask 0x1111 to get current hex character
    and ax, dx ; perform mask
    shr dx, 4 ; shift dx 4 bits right

    cmp ax, 9 ; check if letter or number
    jle set_char ; if number
    add ax, 7 ; 'A' in ASCII is 7 more than '9'
    jle set_char ; if letter

    set_char:
	    mov byte [bx], '0' ; reset HEX_OUT to original value (below)
        add [bx], ax ; "shift" '0' to correct char
        jmp hex_loop
  
  hex_end:
    mov bx, HEX_OUT
    call print_string

    popa
    ret

; global variables
HEX_OUT: db '0x0000', 0
