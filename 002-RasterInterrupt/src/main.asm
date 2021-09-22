	*=$0801
	!byte $0c, $08, $0a, $00, $9e, $20
	!byte $34, $30, $39, $36, $00, $00
	!byte $00    

	!source "inc/common.asm"

!macro setRasterIrq .line, .subr {
	sei
	ldx #01     		; enable raster interrupt
	stx $d01a
	ldx #.line    		; set interrupt to line xxx
	stx $d012

  	lda #%01111111      ; High bit of raster line cleared, we're only working within single byte ranges
	and $d011
  	sta $d011

	ldx #<.subr			; set sub routine called by irq
	stx $0314
	ldx #>.subr
	stx $0315
	cli
}

disable_timer_interrupts
  	lda #%01111111      ; disable timer interrupt
	sta $dc0d
	rts

	*=$1000

main
	jsr disable_timer_interrupts
	+setRasterIrq 100 ,border_100
	jmp *

border_100
	ldx #01				; Acknowledge raster interrupt
	stx $d019
	ldx #BLACK			; change border color to black
	stx $d020
	+setRasterIrq 102 ,border_102

	jmp $ea31


border_102
	ldx #01				; Acknowledge raster interrupt
	stx $d019
	ldx #RED			; change border color to red
	stx $d020
	+setRasterIrq 112 ,border_112

	jmp $ea31

border_112
	ldx #01				; Acknowledge raster interrupt
	stx $d019
	ldx #BLACK			; change border color to black
	stx $d020
	+setRasterIrq 114 ,border_114

	jmp $ea31

border_114
	ldx #01				; Acknowledge raster interrupt
	stx $d019
	ldx #GREEN			; change border color to green
	stx $d020
	+setRasterIrq 124 ,border_124

	jmp $ea31

border_124
	ldx #01				; Acknowledge raster interrupt
	stx $d019
	ldx #BLACK			; change border color to black
	stx $d020
	+setRasterIrq 126 ,border_126

	jmp $ea31

border_126
	ldx #01				; Acknowledge raster interrupt
	stx $d019
	ldx #YELLOW			; change border color to yellow
	stx $d020
	+setRasterIrq 136 ,border_136

	jmp $ea31

border_136
	ldx #01				; Acknowledge raster interrupt
	stx $d019
	ldx #BLACK			; change border color to black
	stx $d020
	+setRasterIrq 138 ,border_138

	jmp $ea31

border_138
	ldx #01				; Acknowledge raster interrupt
	stx $d019
	ldx #BROWN			; change border color to brown
	stx $d020
	+setRasterIrq 148 ,border_148

	jmp $ea31

border_148
	ldx #01				; Acknowledge raster interrupt
	stx $d019
	ldx #BLACK			; change border color to black
	stx $d020	
	+setRasterIrq 150 ,border_end

	jmp $ea31

border_end
	ldx #01				; Acknowledge raster interrupt
	stx $d019
	ldx #L_BLUE			; change border color to light blue
	stx $d020
	+setRasterIrq 100 ,border_100

	jmp $ea31
