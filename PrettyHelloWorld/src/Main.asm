	*=$0801
	!byte $0c, $08, $0a, $00, $9e, $20
	!byte $34, $30, $39, $36, $00, $00
	!byte $00    

colors
	!byte WHITE,YELLOW,L_GREY,L_RED,GREY,PURPLE,D_GREY,BLUE,PURPLE,GREY,L_RED,L_GREY,YELLOW

colorIndex
	!byte $00

mystring
	!scr "hello world!!!"

	!source "./inc/common.asm"
	!source "./inc/memory.asm"

disable_timer_interrupts
  	lda #%01111111      ; disable timer interrupt
	sta $dc0d
	rts

	*=$1000

main
	ldx #BLACK

	stx ADR_BACKGROUND  ; set background to black
	stx ADR_BORDER		; set border to black
	jsr disable_timer_interrupts
	jsr clearscreen
	jsr helloworld

	sei					; disable all interrupts

  	lda #%01111111      ; High bit of raster line cleared, we're only working within single byte ranges
	and $d011
  	sta $d011

	lda #100            ; set raster interrupt at line 100
	sta $d012

	ldx #<irq           ; interrupt execute routine at label irq
	ldy #>irq
	stx $0314
	sty $0315

	lda #%00000001      ; enable raster interrupt
	sta $d01a

	cli                 ; enable all interrupts

	jmp *

;wait			         ; wait until Esc key is pressed
;	lda $00cb
;	cmp #63
;	bne wait
;	rts

clearscreen             ; write space char all over the screen
	ldx #250
	lda #32             ; space code

- 	dex
	sta ADR_SCREEN,x
	sta ADR_SCREEN + 250,x
	sta ADR_SCREEN + 500,x
	sta ADR_SCREEN + 750,x
	bne -
	
	rts

helloworld
	ldx #00

-	lda mystring,x
	sta ADR_SCREEN + 12 * 40 + 13,x
	inx
	cpx #14
	bne -
	
	rts	

irq
	jsr change_colors
	jsr check_keyboard

	lda #%00000001       ; acknowledge IRQ / clear register for next interrupt
	sta $d019

	jmp $ea31

change_colors
	ldx colorIndex
	ldy #00

-	inx
	cpx #13
	bne +
	ldx #0
+	lda colors,x
	sta ADR_COLOR + 12 * 40 + 13,y
	iny
	cpy #14
	bne -
	stx colorIndex
	
	rts

check_keyboard			; wait until Esc key is pressed
	lda #%11111111      ; CIA#1 Port A set to output 
	sta $dc02             
	lda #%00000000      ; CIA#1 Port B set to inputt
	sta $dc03             
            
check_esc             
	lda #%01111111      ; select row 8
	sta $dc00 
	lda $dc01           ; load column information
	and #%10000000      ; test 'esc' key to exit
	beq exit_to_basic
	rts

exit_to_basic           
	jmp $ea81           ; jmp to regular interrupt routine
	rts
