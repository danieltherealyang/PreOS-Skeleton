[bits 32]
[extern main] 
; when linking, main does not exist as a label
; need to indicate it's expected to exist in one of the other object files
	call main
	jmp $
