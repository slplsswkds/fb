                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module uart
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _NEWLINE
                                     12 	.globl _uart_init
                                     13 	.globl _uart_tx_byte
                                     14 	.globl _uart_tx_byte_array
                                     15 ;--------------------------------------------------------
                                     16 ; ram data
                                     17 ;--------------------------------------------------------
                                     18 	.area DATA
                                     19 ;--------------------------------------------------------
                                     20 ; ram data
                                     21 ;--------------------------------------------------------
                                     22 	.area INITIALIZED
      000006                         23 _NEWLINE::
      000006                         24 	.ds 1
                                     25 ;--------------------------------------------------------
                                     26 ; absolute external ram data
                                     27 ;--------------------------------------------------------
                                     28 	.area DABS (ABS)
                                     29 
                                     30 ; default segment ordering for linker
                                     31 	.area HOME
                                     32 	.area GSINIT
                                     33 	.area GSFINAL
                                     34 	.area CONST
                                     35 	.area INITIALIZER
                                     36 	.area CODE
                                     37 
                                     38 ;--------------------------------------------------------
                                     39 ; global & static initialisations
                                     40 ;--------------------------------------------------------
                                     41 	.area HOME
                                     42 	.area GSINIT
                                     43 	.area GSFINAL
                                     44 	.area GSINIT
                                     45 ;--------------------------------------------------------
                                     46 ; Home
                                     47 ;--------------------------------------------------------
                                     48 	.area HOME
                                     49 	.area HOME
                                     50 ;--------------------------------------------------------
                                     51 ; code
                                     52 ;--------------------------------------------------------
                                     53 	.area CODE
                                     54 ;	./src/uart.c: 5: void uart_init() {
                                     55 ;	-----------------------------------------
                                     56 ;	 function uart_init
                                     57 ;	-----------------------------------------
      00836C                         58 _uart_init:
                                     59 ;	./src/uart.c: 10: UART1_BRR1 = brr & 0x000F;
      00836C A6 D0            [ 1]   60 	ld	a, #0xd0
      00836E A4 0F            [ 1]   61 	and	a, #0x0f
      008370 C7 52 32         [ 1]   62 	ld	0x5232, a
                                     63 ;	./src/uart.c: 11: UART1_BRR2 |= brr >> 12;
                                     64 ;	./src/uart.c: 12: UART1_BRR1 = (brr >> 4) & 0x00FF;
      008373 A6 0D            [ 1]   65 	ld	a, #0x0d
      008375 C7 52 32         [ 1]   66 	ld	0x5232, a
                                     67 ;	./src/uart.c: 14: UART1_CR1 &= ~PIEN; // Parity interrupt disabled
      008378 C6 52 34         [ 1]   68 	ld	a, 0x5234
      00837B A4 FE            [ 1]   69 	and	a, #0xfe
                                     70 ;	./src/uart.c: 15: UART1_CR1 &= ~PCEN; // Parity control disabled
      00837D C7 52 34         [ 1]   71 	ld	0x5234, a
      008380 A4 FB            [ 1]   72 	and	a, #0xfb
                                     73 ;	./src/uart.c: 16: UART1_CR1 &= ~M; // 8-bit mode
      008382 C7 52 34         [ 1]   74 	ld	0x5234, a
      008385 A4 EF            [ 1]   75 	and	a, #0xef
                                     76 ;	./src/uart.c: 17: UART1_CR1 &= UARTD; // UART1 enable
      008387 C7 52 34         [ 1]   77 	ld	0x5234, a
      00838A A4 20            [ 1]   78 	and	a, #0x20
      00838C C7 52 34         [ 1]   79 	ld	0x5234, a
                                     80 ;	./src/uart.c: 20: UART1_CR2 &= ~TIEN; 
      00838F C6 52 35         [ 1]   81 	ld	a, 0x5235
      008392 A4 7F            [ 1]   82 	and	a, #0x7f
                                     83 ;	./src/uart.c: 22: UART1_CR2 &= ~TCIEN;
      008394 C7 52 35         [ 1]   84 	ld	0x5235, a
      008397 A4 BF            [ 1]   85 	and	a, #0xbf
                                     86 ;	./src/uart.c: 24: UART1_CR2 |= RIEN;
      008399 C7 52 35         [ 1]   87 	ld	0x5235, a
      00839C AA 20            [ 1]   88 	or	a, #0x20
                                     89 ;	./src/uart.c: 26: UART1_CR2 &= ~ILIEN;
      00839E C7 52 35         [ 1]   90 	ld	0x5235, a
      0083A1 A4 EF            [ 1]   91 	and	a, #0xef
                                     92 ;	./src/uart.c: 28: UART1_CR2 |= TEN;
      0083A3 C7 52 35         [ 1]   93 	ld	0x5235, a
      0083A6 AA 08            [ 1]   94 	or	a, #0x08
                                     95 ;	./src/uart.c: 30: UART1_CR2 |= REN;
      0083A8 C7 52 35         [ 1]   96 	ld	0x5235, a
      0083AB AA 04            [ 1]   97 	or	a, #0x04
                                     98 ;	./src/uart.c: 32: UART1_CR2 &= ~SBK;
      0083AD C7 52 35         [ 1]   99 	ld	0x5235, a
      0083B0 A4 FE            [ 1]  100 	and	a, #0xfe
      0083B2 C7 52 35         [ 1]  101 	ld	0x5235, a
                                    102 ;	./src/uart.c: 35: UART1_CR3 &= ~(1 << 5);
      0083B5 C6 52 36         [ 1]  103 	ld	a, 0x5236
      0083B8 A4 DF            [ 1]  104 	and	a, #0xdf
                                    105 ;	./src/uart.c: 36: UART1_CR3 &= ~(1 << 4);
      0083BA C7 52 36         [ 1]  106 	ld	0x5236, a
      0083BD A4 EF            [ 1]  107 	and	a, #0xef
      0083BF C7 52 36         [ 1]  108 	ld	0x5236, a
                                    109 ;	./src/uart.c: 37: }
      0083C2 81               [ 4]  110 	ret
                                    111 ;	./src/uart.c: 39: void uart_tx_byte(char *byte) {
                                    112 ;	-----------------------------------------
                                    113 ;	 function uart_tx_byte
                                    114 ;	-----------------------------------------
      0083C3                        115 _uart_tx_byte:
      0083C3 51               [ 1]  116 	exgw	x, y
                                    117 ;	./src/uart.c: 41: while(TXE == (~UART1_SR & TXE)) {};
      0083C4                        118 00101$:
      0083C4 C6 52 30         [ 1]  119 	ld	a, 0x5230
      0083C7 5F               [ 1]  120 	clrw	x
      0083C8 97               [ 1]  121 	ld	xl, a
      0083C9 53               [ 2]  122 	cplw	x
      0083CA 9F               [ 1]  123 	ld	a, xl
      0083CB A4 80            [ 1]  124 	and	a, #0x80
      0083CD 97               [ 1]  125 	ld	xl, a
      0083CE 4F               [ 1]  126 	clr	a
      0083CF 95               [ 1]  127 	ld	xh, a
      0083D0 A3 00 80         [ 2]  128 	cpw	x, #0x0080
      0083D3 27 EF            [ 1]  129 	jreq	00101$
                                    130 ;	./src/uart.c: 42: UART1_DR = *byte;
      0083D5 90 F6            [ 1]  131 	ld	a, (y)
      0083D7 C7 52 31         [ 1]  132 	ld	0x5231, a
                                    133 ;	./src/uart.c: 43: }
      0083DA 81               [ 4]  134 	ret
                                    135 ;	./src/uart.c: 45: void uart_tx_byte_array(char data[], uint8_t size) {
                                    136 ;	-----------------------------------------
                                    137 ;	 function uart_tx_byte_array
                                    138 ;	-----------------------------------------
      0083DB                        139 _uart_tx_byte_array:
      0083DB 52 03            [ 2]  140 	sub	sp, #3
      0083DD 1F 02            [ 2]  141 	ldw	(0x02, sp), x
      0083DF 6B 01            [ 1]  142 	ld	(0x01, sp), a
                                    143 ;	./src/uart.c: 46: for(uint8_t cb = 0; cb < size; cb ++) {
      0083E1 4F               [ 1]  144 	clr	a
      0083E2                        145 00103$:
      0083E2 11 01            [ 1]  146 	cp	a, (0x01, sp)
      0083E4 24 0D            [ 1]  147 	jrnc	00105$
                                    148 ;	./src/uart.c: 47: uart_tx_byte(&data[cb]);
      0083E6 5F               [ 1]  149 	clrw	x
      0083E7 97               [ 1]  150 	ld	xl, a
      0083E8 72 FB 02         [ 2]  151 	addw	x, (0x02, sp)
      0083EB 88               [ 1]  152 	push	a
      0083EC CD 83 C3         [ 4]  153 	call	_uart_tx_byte
      0083EF 84               [ 1]  154 	pop	a
                                    155 ;	./src/uart.c: 46: for(uint8_t cb = 0; cb < size; cb ++) {
      0083F0 4C               [ 1]  156 	inc	a
      0083F1 20 EF            [ 2]  157 	jra	00103$
      0083F3                        158 00105$:
                                    159 ;	./src/uart.c: 49: }
      0083F3 5B 03            [ 2]  160 	addw	sp, #3
      0083F5 81               [ 4]  161 	ret
                                    162 	.area CODE
                                    163 	.area CONST
                                    164 	.area INITIALIZER
      008074                        165 __xinit__NEWLINE:
      008074 0A                     166 	.db #0x0a	; 10
                                    167 	.area CABS (ABS)
