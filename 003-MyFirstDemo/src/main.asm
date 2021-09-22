	*=$0801
	!byte $0c, $08, $0a, $00, $9e, $20
	!byte $32, $33, $30, $34, $00, $00
	!byte $00    

	!source "inc/common.asm"
	!source "inc/memory.asm"

	*=$0900
main
	ldx #BLACK
	stx BORDER_ADR
	stx BACKGRD_ADR

	; init music
	jsr $0ffc

	ldx #00

load_img
	lda logo + 8000,x
	sta SCREEN_RAM,x
	lda logo + 8000 + 250,x
	sta SCREEN_RAM + 250,x
	lda logo + 8000 + 500,x
	sta SCREEN_RAM + 500,x
	lda logo + 8000 + 750,x
	sta SCREEN_RAM + 750,x
	
	lda logo + 9000,x
	sta COLOR_RAM,x
	lda logo + 9000 + 250,x
	sta COLOR_RAM + 250,x
	lda logo + 9000 + 500,x
	sta COLOR_RAM + 500,x
	lda logo + 9000 + 750,x
	sta COLOR_RAM + 750,x

	inx
	cpx #250

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

	sei				    ; pause all interrupts
  	
	lda #%01111111      ; disable timer interrupt
	sta $dc0d

	lda #%00000001	    ; enable raster interrupt $f1
	sta $d01a

	lda #%01111111      ; High bit of raster line cleared
	and $d011
	sta $d011
	
	ldx #0 		        ; set raster interrupt at line 0
	stx $d012
	ldx #<irq		    ; set interrupt routine at label irq
	stx $0314
	ldx #>irq
	stx $0315
	cli				    ; resume all interrupts

	jmp *

irq
	lda #01             ; acknowledge IRQ / clear register for next interrupt
	sta $d019
	jsr $1100

+	jmp $ea81	



	*=$0ffc
music
	!binary "../assets/sid/TMK_Noter.sid",,$7c+2 ; skip 126 first bytes (124 -> header, 2 -> load addr)


	*=$2000
logo	
	!binary "../assets/img/logo-full.koa",,2 ; skip 2 first bytes (load addr)



