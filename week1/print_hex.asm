print_hex: ;dx is parameter
  pusha
  ;TODO: implement a function that takes in value of dx
  ;and modify the string located at HEX_OUT to be the hex
  ;value. Then print out HEX_OUT.
  popa
  ret
HEX_OUT: db '0x0000', 0