; GDT
gdt_start: ; start address marker

gdt_null: ; required null descriptor
    dd 0x00 ; 'dd' = define double word (i.e. 4 bytes)
    dd 0x00

gdt_code: ; code segment descriptor
    ; base = 0x0, limit = 0xffff
    ; 1st flags: (present)1 (privilege)00 (descriptor type)1 -> 1001b
    ; type flags: (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
    ; 2nd flags: (granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0 
    ;     -> 1100b

    dw 0xffff       ; Limit (bits 0-15)
    dw 0x0          ; Base (bits 0-15)
    db 0x0          ; Base (bits 16-23)
    db 10011010b    ; 1st flags, type flags
    db 11001111b    ; 2nd flags, Limit (bits 16-19)
    db 0x0          ; Base (bits 24-31)
; In memory, this section would look like (lowest addr -> highest addr):
; 11111111 11111111 00000000 00000000 00000000 10011010 11001111 00000000

gdt_data: ; data segment descriptor
    ; Same as code segment except for type flags. 
    ; type flags: (code)0 (expand down)0 (writable)1 (accessed)0 -> 0010b
    dw 0xffff
    dw 0x0
    db 0x0 
    db 10010010b    ; 1st flags, type flags
    db 11001111b
    db 0x0

gdt_end: ; mark the end of the GDT 
; now assembler can calculate size of GDT for GDT descriptor

; GDT descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; GDT size, always less one of the true size
    dd gdt_start ; GDT start address

; define GDT offsets for each of the segment descriptors
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
