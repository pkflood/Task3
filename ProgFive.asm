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

;;;;

stateA
JSR CHAR_CHECK
LD R3, U
NOT R3, R3
ADD R3, R3, #1
ADD R4, R3, R0
BRZ stateAU
LD R3, A
NOT R3, R3
ADD R3, R3, #1
ADD R4, R3, R0
BRZ stateA
BRNP Init

stateAU
JSR CHAR_CHECK
LD R3, G
NOT R3, R3
ADD R3, R3, #1
ADD R4, R3, R0
BRZ start
LD R3, A
NOT R3, R3
ADD R3, R3, #1
ADD R4, R3, R0
BRZ stateA
BRNP Init

start 
LD R0, bar
TRAP x21

lookU ;checks for U
JSR CHAR_CHECK; R0 has value of valid character
LD R3, U
NOT R3, R3
ADD R3, R3, #1
ADD R4, R0, R3
BRZ stateU
BRNP lookU

stateU ;checks for A or G
JSR CHAR_CHECK; R0 has value of valid character
LD R3, G
NOT R3, R3
ADD R3, R3, #1
ADD R4, R0, R3
BRZ stateUG
LD R3, A 
NOT R3, R3
ADD R3, R3, #1
ADD R4, R0, R3
BRZ stateUA
LD R3, U 
NOT R3, R3
ADD R3, R3, #1
ADD R4, R0, R3
BRZ stateU
BRNP lookU

stateUG ; checks for A
JSR CHAR_CHECK
LD R3, A
NOT R3, R3
ADD R3, R3, #1
ADD R4, R0, R3
BRZ stop
LD R3, U
NOT R3, R3
ADD R3, R3, #1
ADD R4, R0, R3
BRZ stateU
BRNP lookU

stateUA ;checks for A or G
JSR CHAR_CHECK
LD R3, A
NOT R3, R3
ADD R3, R3, #1
ADD R4, R0, R3
BRZ stop

LD R3, G
NOT R3, R3
ADD R3, R3, #1
ADD R4, R0, R3
BRZ stop
LD R3, C
NOT R3, R3
ADD R3, R3, #1
ADD R4, R0, R3
BRZ lookU
LD R3, U
NOT R3, R3
ADD R3, R3, #1
ADD R4, R0, R3
BRZ stateU

stop TRAP x25

Stack .FILL x4000
KBIEN .FILL x4000
KBSR .FILL xFE00
KBIVE .FILL x0180
check .FILL x2600
Buffer .FILL x4600
bar .FILL x7C

A .FILL x41
U .FILL x55
G .FILL x47
C .FILL x43
save .blkw 1


.END