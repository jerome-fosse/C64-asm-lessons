	*=$0801
	!byte $0c, $08, $0a, $00, $9e, $20
	!byte $34, $30, $39, $36, $00, $00
	!byte $00    

	!source "inc/common.asm"
	!source "inc/memory.asm"
	
	*=$2000 - 2
	!binary "../assets/img/logo-full.koa"

	*=$1000

main
	ldx #BLACK
	stx BORDER_ADR
	stx BACKGRD_ADR

	ldx #00

load_img
	lda $3f40,x
	sta SCREEN_RAM,x
	lda $3f40 + 250,x
	sta SCREEN_RAM + 250,x
	lda $3f40 + 500,x
	sta SCREEN_RAM + 500,x
	lda $3f40 + 750,x
	sta SCREEN_RAM + 750,x
	
	lda $4328,x
	sta COLOR_RAM,x
	lda $4328 + 250,x
	sta COLOR_RAM + 250,x
	lda $4328 + 500,x
	sta COLOR_RAM + 500,x
	lda $4328 + 750,x
	sta COLOR_RAM + 750,x

	inx
	cpx #251

	bne load_img

	; go to bitmap mode. set bit 5 to 1 at addr $d011
	ldx #%00111011
	stx $d011
	; go to multi colored mode. set bit 4 to 1 at addr $d016
	ldx #%00011000
	stx $d016

	; set bitmap memory to $2000-$3FFF -> bit 3 = 1
	; set screen memory to $0400-$07FF -> bits 7-4 = 0001
	ldx #%00011000
	stx $d018

	jmp *
