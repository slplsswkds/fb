;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.2.0 #13081 (Linux)
;--------------------------------------------------------
	.module uart
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _NEWLINE
	.globl _uart_init
	.globl _uart_tx_byte
	.globl _uart_tx_byte_array
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_NEWLINE::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	./src/uart.c: 5: void uart_init() {
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
;	./src/uart.c: 10: UART1_BRR1 = brr & 0x000F;
	ld	a, #0xd0
	and	a, #0x0f
	ld	0x5232, a
;	./src/uart.c: 11: UART1_BRR2 |= brr >> 12;
;	./src/uart.c: 12: UART1_BRR1 = (brr >> 4) & 0x00FF;
	ld	a, #0x0d
	ld	0x5232, a
;	./src/uart.c: 14: UART1_CR1 &= ~PIEN; // Parity interrupt disabled
	ld	a, 0x5234
	and	a, #0xfe
;	./src/uart.c: 15: UART1_CR1 &= ~PCEN; // Parity control disabled
	ld	0x5234, a
	and	a, #0xfb
;	./src/uart.c: 16: UART1_CR1 &= ~M; // 8-bit mode
	ld	0x5234, a
	and	a, #0xef
;	./src/uart.c: 17: UART1_CR1 &= UARTD; // UART1 enable
	ld	0x5234, a
	and	a, #0x20
	ld	0x5234, a
;	./src/uart.c: 20: UART1_CR2 &= ~TIEN; 
	ld	a, 0x5235
	and	a, #0x7f
;	./src/uart.c: 22: UART1_CR2 &= ~TCIEN;
	ld	0x5235, a
	and	a, #0xbf
;	./src/uart.c: 24: UART1_CR2 |= RIEN;
	ld	0x5235, a
	or	a, #0x20
;	./src/uart.c: 26: UART1_CR2 &= ~ILIEN;
	ld	0x5235, a
	and	a, #0xef
;	./src/uart.c: 28: UART1_CR2 |= TEN;
	ld	0x5235, a
	or	a, #0x08
;	./src/uart.c: 30: UART1_CR2 |= REN;
	ld	0x5235, a
	or	a, #0x04
;	./src/uart.c: 32: UART1_CR2 &= ~SBK;
	ld	0x5235, a
	and	a, #0xfe
	ld	0x5235, a
;	./src/uart.c: 35: UART1_CR3 &= ~(1 << 5);
	ld	a, 0x5236
	and	a, #0xdf
;	./src/uart.c: 36: UART1_CR3 &= ~(1 << 4);
	ld	0x5236, a
	and	a, #0xef
	ld	0x5236, a
;	./src/uart.c: 37: }
	ret
;	./src/uart.c: 39: void uart_tx_byte(char *byte) {
;	-----------------------------------------
;	 function uart_tx_byte
;	-----------------------------------------
_uart_tx_byte:
	exgw	x, y
;	./src/uart.c: 41: while(TXE == (~UART1_SR & TXE)) {};
00101$:
	ld	a, 0x5230
	clrw	x
	ld	xl, a
	cplw	x
	ld	a, xl
	and	a, #0x80
	ld	xl, a
	clr	a
	ld	xh, a
	cpw	x, #0x0080
	jreq	00101$
;	./src/uart.c: 42: UART1_DR = *byte;
	ld	a, (y)
	ld	0x5231, a
;	./src/uart.c: 43: }
	ret
;	./src/uart.c: 45: void uart_tx_byte_array(char data[], uint8_t size) {
;	-----------------------------------------
;	 function uart_tx_byte_array
;	-----------------------------------------
_uart_tx_byte_array:
	sub	sp, #3
	ldw	(0x02, sp), x
	ld	(0x01, sp), a
;	./src/uart.c: 46: for(uint8_t cb = 0; cb < size; cb ++) {
	clr	a
00103$:
	cp	a, (0x01, sp)
	jrnc	00105$
;	./src/uart.c: 47: uart_tx_byte(&data[cb]);
	clrw	x
	ld	xl, a
	addw	x, (0x02, sp)
	push	a
	call	_uart_tx_byte
	pop	a
;	./src/uart.c: 46: for(uint8_t cb = 0; cb < size; cb ++) {
	inc	a
	jra	00103$
00105$:
;	./src/uart.c: 49: }
	addw	sp, #3
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__NEWLINE:
	.db #0x0a	; 10
	.area CABS (ABS)
