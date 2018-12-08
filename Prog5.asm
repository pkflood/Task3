              .ORIG x4000
; initialize the stack pointer
LD R6, Stack



; set up the keyboard interrupt vector table entry
LD R0, KBIEN
STI R0, KBSR


; enable keyboard interrupts
LD R0, check
STI R0, KBIVE



; start of actual program


Init ;checks for A
JSR CHAR_CHECK; R0 has value of valid character
LD R3, A
NOT R3, R3
ADD R3, R3, #1
ADD R4, R0, R3
BRZ stateA
BRNP Init
