;TODO: add your boot sector code here.

; Bootsector padding
times 510 -( $ - $$ ) db 0 ; $ is the current memory address and $$ is the start of the file
dw 0xaa55 ; boot sector signature