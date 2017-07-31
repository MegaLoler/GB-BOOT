; ROM LOADER
; this program is executed normally from a cartridge ROM
; its job is to load GBBOOT (gbboot.bin) into WRAM and branch execution to there

; tell wla-gb about the ROM slots that it is executed from
.memorymap
	defaultslot 1
	slotsize $4000
	slot 0 $0000
	slot 1 $4000
.endme

; no bank switching needed
.rombanksize $4000
.rombanks 2

; header info
.gbheader
	name "GBBOOT"
	cartridgetype 0
	ramsize 0
	nintendologo
	romdmg
.endgb

; includes
.include "cgb_hardware.i"

; first bank
.bank 0 slot 0

; the header
.org $100

; entry point
entry:
	nop
	jp	start

; after the header
.org $150

; start
start:
	; disable interrupts
	di				; interrupt vectors are in cart
					; and we need to be cart independant
					; so we can't use interrupts at all

	; prepare copy gbboot into wram
	ld	hl, wram_image		; source: here in rom
	ld	de, $c000		; destination: there in wram
	ld	bc, _sizeof_wram_image	; bytes to copy: size of the gbboot image

	; enter copy loop
-	ldi	a, (hl)			; grab a byte
	ld	(de), a			; and spit it out
	inc	de			; and get ready for the next byte
	dec	bc			; keep track of how many bytes are left
	ld	a, b			; check b...
	or	c			; ...and c to see if its 0 yet
	jr	nz, -			; and keep copying until done

	; and now branch to the freshly copied gbboot in wram!
	jp	$c000

; include the wram image of gbboot here:
wram_image:
.incbin "gbboot.bin"
wram_image_end:
