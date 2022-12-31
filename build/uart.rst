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
                                     11 	.globl _RETURN_CURSOR
                                     12 	.globl _NEWLINE
                                     13 	.globl _uart_init
                                     14 	.globl _uart_tx_byte
                                     15 	.globl _uart_tx_byte_array
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area DATA
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area INITIALIZED
      000006                         24 _NEWLINE::
      000006                         25 	.ds 1
      000007                         26 _RETURN_CURSOR::
      000007                         27 	.ds 1
                                     28 ;--------------------------------------------------------
                                     29 ; absolute external ram data
                                     30 ;--------------------------------------------------------
                                     31 	.area DABS (ABS)
                                     32 
                                     33 ; default segment ordering for linker
                                     34 	.area HOME
                                     35 	.area GSINIT
                                     36 	.area GSFINAL
                                     37 	.area CONST
                                     38 	.area INITIALIZER
                                     39 	.area CODE
                                     40 
                                     41 ;--------------------------------------------------------
                                     42 ; global & static initialisations
                                     43 ;--------------------------------------------------------
                                     44 	.area HOME
                                     45 	.area GSINIT
                                     46 	.area GSFINAL
                                     47 	.area GSINIT
                                     48 ;--------------------------------------------------------
                                     49 ; Home
                                     50 ;--------------------------------------------------------
                                     51 	.area HOME
                                     52 	.area HOME
                                     53 ;--------------------------------------------------------
                                     54 ; code
                                     55 ;--------------------------------------------------------
                                     56 	.area CODE
                                     57 ;	./src/uart.c: 6: void uart_init() {
                                     58 ;	-----------------------------------------
                                     59 ;	 function uart_init
                                     60 ;	-----------------------------------------
      008561                         61 _uart_init:
                                     62 ;	./src/uart.c: 11: UART1_BRR1 = brr & 0x000F;
      008561 A6 D0            [ 1]   63 	ld	a, #0xd0
      008563 A4 0F            [ 1]   64 	and	a, #0x0f
      008565 C7 52 32         [ 1]   65 	ld	0x5232, a
                                     66 ;	./src/uart.c: 12: UART1_BRR2 |= brr >> 12;
                                     67 ;	./src/uart.c: 13: UART1_BRR1 = (brr >> 4) & 0x00FF;
      008568 A6 0D            [ 1]   68 	ld	a, #0x0d
      00856A C7 52 32         [ 1]   69 	ld	0x5232, a
                                     70 ;	./src/uart.c: 15: UART1_CR1 &= ~PIEN; // Parity interrupt disabled
      00856D C6 52 34         [ 1]   71 	ld	a, 0x5234
      008570 A4 FE            [ 1]   72 	and	a, #0xfe
                                     73 ;	./src/uart.c: 16: UART1_CR1 &= ~PCEN; // Parity control disabled
      008572 C7 52 34         [ 1]   74 	ld	0x5234, a
      008575 A4 FB            [ 1]   75 	and	a, #0xfb
                                     76 ;	./src/uart.c: 17: UART1_CR1 &= ~M; // 8-bit mode
      008577 C7 52 34         [ 1]   77 	ld	0x5234, a
      00857A A4 EF            [ 1]   78 	and	a, #0xef
                                     79 ;	./src/uart.c: 18: UART1_CR1 &= UARTD; // UART1 enable
      00857C C7 52 34         [ 1]   80 	ld	0x5234, a
      00857F A4 20            [ 1]   81 	and	a, #0x20
      008581 C7 52 34         [ 1]   82 	ld	0x5234, a
                                     83 ;	./src/uart.c: 21: UART1_CR2 &= ~TIEN; 
      008584 C6 52 35         [ 1]   84 	ld	a, 0x5235
      008587 A4 7F            [ 1]   85 	and	a, #0x7f
                                     86 ;	./src/uart.c: 23: UART1_CR2 &= ~TCIEN;
      008589 C7 52 35         [ 1]   87 	ld	0x5235, a
      00858C A4 BF            [ 1]   88 	and	a, #0xbf
                                     89 ;	./src/uart.c: 25: UART1_CR2 |= RIEN;
      00858E C7 52 35         [ 1]   90 	ld	0x5235, a
      008591 AA 20            [ 1]   91 	or	a, #0x20
                                     92 ;	./src/uart.c: 27: UART1_CR2 &= ~ILIEN;
      008593 C7 52 35         [ 1]   93 	ld	0x5235, a
      008596 A4 EF            [ 1]   94 	and	a, #0xef
                                     95 ;	./src/uart.c: 29: UART1_CR2 |= TEN;
      008598 C7 52 35         [ 1]   96 	ld	0x5235, a
      00859B AA 08            [ 1]   97 	or	a, #0x08
                                     98 ;	./src/uart.c: 31: UART1_CR2 |= REN;
      00859D C7 52 35         [ 1]   99 	ld	0x5235, a
      0085A0 AA 04            [ 1]  100 	or	a, #0x04
                                    101 ;	./src/uart.c: 33: UART1_CR2 &= ~SBK;
      0085A2 C7 52 35         [ 1]  102 	ld	0x5235, a
      0085A5 A4 FE            [ 1]  103 	and	a, #0xfe
      0085A7 C7 52 35         [ 1]  104 	ld	0x5235, a
                                    105 ;	./src/uart.c: 36: UART1_CR3 &= ~(1 << 5);
      0085AA C6 52 36         [ 1]  106 	ld	a, 0x5236
      0085AD A4 DF            [ 1]  107 	and	a, #0xdf
                                    108 ;	./src/uart.c: 37: UART1_CR3 &= ~(1 << 4);
      0085AF C7 52 36         [ 1]  109 	ld	0x5236, a
      0085B2 A4 EF            [ 1]  110 	and	a, #0xef
      0085B4 C7 52 36         [ 1]  111 	ld	0x5236, a
                                    112 ;	./src/uart.c: 38: }
      0085B7 81               [ 4]  113 	ret
                                    114 ;	./src/uart.c: 40: void uart_tx_byte(char *byte) {
                                    115 ;	-----------------------------------------
                                    116 ;	 function uart_tx_byte
                                    117 ;	-----------------------------------------
      0085B8                        118 _uart_tx_byte:
      0085B8 51               [ 1]  119 	exgw	x, y
                                    120 ;	./src/uart.c: 42: while(TXE == (~UART1_SR & TXE)) {};
      0085B9                        121 00101$:
      0085B9 C6 52 30         [ 1]  122 	ld	a, 0x5230
      0085BC 5F               [ 1]  123 	clrw	x
      0085BD 97               [ 1]  124 	ld	xl, a
      0085BE 53               [ 2]  125 	cplw	x
      0085BF 9F               [ 1]  126 	ld	a, xl
      0085C0 A4 80            [ 1]  127 	and	a, #0x80
      0085C2 97               [ 1]  128 	ld	xl, a
      0085C3 4F               [ 1]  129 	clr	a
      0085C4 95               [ 1]  130 	ld	xh, a
      0085C5 A3 00 80         [ 2]  131 	cpw	x, #0x0080
      0085C8 27 EF            [ 1]  132 	jreq	00101$
                                    133 ;	./src/uart.c: 43: UART1_DR = *byte;
      0085CA 90 F6            [ 1]  134 	ld	a, (y)
      0085CC C7 52 31         [ 1]  135 	ld	0x5231, a
                                    136 ;	./src/uart.c: 44: }
      0085CF 81               [ 4]  137 	ret
                                    138 ;	./src/uart.c: 46: void uart_tx_byte_array(char data[], uint8_t size) {
                                    139 ;	-----------------------------------------
                                    140 ;	 function uart_tx_byte_array
                                    141 ;	-----------------------------------------
      0085D0                        142 _uart_tx_byte_array:
      0085D0 52 03            [ 2]  143 	sub	sp, #3
      0085D2 1F 02            [ 2]  144 	ldw	(0x02, sp), x
      0085D4 6B 01            [ 1]  145 	ld	(0x01, sp), a
                                    146 ;	./src/uart.c: 47: for(uint8_t cb = 0; cb < size; cb ++) {
      0085D6 4F               [ 1]  147 	clr	a
      0085D7                        148 00103$:
      0085D7 11 01            [ 1]  149 	cp	a, (0x01, sp)
      0085D9 24 0D            [ 1]  150 	jrnc	00105$
                                    151 ;	./src/uart.c: 48: uart_tx_byte(&data[cb]);
      0085DB 5F               [ 1]  152 	clrw	x
      0085DC 97               [ 1]  153 	ld	xl, a
      0085DD 72 FB 02         [ 2]  154 	addw	x, (0x02, sp)
      0085E0 88               [ 1]  155 	push	a
      0085E1 CD 85 B8         [ 4]  156 	call	_uart_tx_byte
      0085E4 84               [ 1]  157 	pop	a
                                    158 ;	./src/uart.c: 47: for(uint8_t cb = 0; cb < size; cb ++) {
      0085E5 4C               [ 1]  159 	inc	a
      0085E6 20 EF            [ 2]  160 	jra	00103$
      0085E8                        161 00105$:
                                    162 ;	./src/uart.c: 50: }
      0085E8 5B 03            [ 2]  163 	addw	sp, #3
      0085EA 81               [ 4]  164 	ret
                                    165 	.area CODE
                                    166 	.area CONST
                                    167 	.area INITIALIZER
      008024                        168 __xinit__NEWLINE:
      008024 0A                     169 	.db #0x0a	; 10
      008025                        170 __xinit__RETURN_CURSOR:
      008025 0D                     171 	.db #0x0d	; 13
                                    172 	.area CABS (ABS)
