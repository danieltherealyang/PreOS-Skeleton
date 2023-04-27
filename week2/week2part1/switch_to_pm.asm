[bits 16]
switch_to_pm:
    ; BIOS routines run 16 bit code so GDT entries would make 
    ; no sense to the BIOS routines
    
    cli ; disable interrupts to prevent CPU from crashing
    
    lgdt [gdt_descriptor] ; tell CPU where GDT is
    
    mov eax, cr0 ; set first bit of ctrl register cr0
    or eax, 0x1
    mov cr0, eax
    
    jmp CODE_SEG:init_pm ; <segment>:<address offset>
    ; issue a far jump to our 32-bit code
    ; forces CPU to flush its cache 

[bits 32]
    ; in PM now. Now we need to point the segment registers to the GDT
    init_pm:
        mov ax, DATA_SEG ; point our segment registers
        mov ds, ax       ; to the date selector we defined in our GDT
        mov ss, ax
        mov es, ax
        mov fs, ax
        mov gs, ax

        mov ebp, 0x90000
        mov esp, ebp

        call BEGIN_PM