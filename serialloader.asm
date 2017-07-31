; SERIAL LOADER
; this program is executed from VRAM
; it's job is to load a program into WRAM over the serial port and then branch execution to it

; tell wla-gb about the VRAM slot that it is executed from
.memorymap
	defaultslot 0
	slot 0 start $8000 size $2000
.endme

; there is really only 1 `bank` but wla-gb thinks that's not supported, so we lie :P
.rombanksize $2000
.rombanks 2

; and in that bank
.bank 0

; at the beginning
.org 0

; start
start:
	; do nothing forever (for now)
-	halt
	jr	-
