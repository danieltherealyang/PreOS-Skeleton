print_string:
;bx is the input parameter with the address to the string
    pusha
    ;TODO: using the BIOS teletype routine, print out the string
    ;located at the address stored in bx stopping at the null
    ;terminating byte
    popa
    ret