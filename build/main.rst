                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 	.globl _uart_tx_byte_array
                                     13 	.globl _uart_tx_byte
                                     14 	.globl _uart_init
                                     15 	.globl _smart_decrement
                                     16 	.globl _smart_increment
                                     17 	.globl _write_color_to_registers
                                     18 	.globl _tim2_init
                                     19 	.globl _gpio_init
                                     20 	.globl _clk_init
                                     21 	.globl _rgb
                                     22 	.globl _button_hundler
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area DATA
      000001                         27 _rgb::
      000001                         28 	.ds 3
                                     29 ;--------------------------------------------------------
                                     30 ; ram data
                                     31 ;--------------------------------------------------------
                                     32 	.area INITIALIZED
                                     33 ;--------------------------------------------------------
                                     34 ; Stack segment in internal ram
                                     35 ;--------------------------------------------------------
                                     36 	.area	SSEG
      000007                         37 __start__stack:
      000007                         38 	.ds	1
                                     39 
                                     40 ;--------------------------------------------------------
                                     41 ; absolute external ram data
                                     42 ;--------------------------------------------------------
                                     43 	.area DABS (ABS)
                                     44 
                                     45 ; default segment ordering for linker
                                     46 	.area HOME
                                     47 	.area GSINIT
                                     48 	.area GSFINAL
                                     49 	.area CONST
                                     50 	.area INITIALIZER
                                     51 	.area CODE
                                     52 
                                     53 ;--------------------------------------------------------
                                     54 ; interrupt vector
                                     55 ;--------------------------------------------------------
                                     56 	.area HOME
      008000                         57 __interrupt_vect:
      008000 82 00 80 57             58 	int s_GSINIT ; reset
      008004 82 00 00 00             59 	int 0x000000 ; trap
      008008 82 00 00 00             60 	int 0x000000 ; int0
      00800C 82 00 00 00             61 	int 0x000000 ; int1
      008010 82 00 00 00             62 	int 0x000000 ; int2
      008014 82 00 00 00             63 	int 0x000000 ; int3
      008018 82 00 00 00             64 	int 0x000000 ; int4
      00801C 82 00 00 00             65 	int 0x000000 ; int5
      008020 82 00 00 00             66 	int 0x000000 ; int6
      008024 82 00 00 00             67 	int 0x000000 ; int7
      008028 82 00 00 00             68 	int 0x000000 ; int8
      00802C 82 00 00 00             69 	int 0x000000 ; int9
      008030 82 00 00 00             70 	int 0x000000 ; int10
      008034 82 00 00 00             71 	int 0x000000 ; int11
      008038 82 00 00 00             72 	int 0x000000 ; int12
      00803C 82 00 00 00             73 	int 0x000000 ; int13
      008040 82 00 00 00             74 	int 0x000000 ; int14
      008044 82 00 00 00             75 	int 0x000000 ; int15
      008048 82 00 00 00             76 	int 0x000000 ; int16
      00804C 82 00 00 00             77 	int 0x000000 ; int17
      008050 82 00 81 5F             78 	int _uart1_rx_handler ; int18
                                     79 ;--------------------------------------------------------
                                     80 ; global & static initialisations
                                     81 ;--------------------------------------------------------
                                     82 	.area HOME
                                     83 	.area GSINIT
                                     84 	.area GSFINAL
                                     85 	.area GSINIT
      008057                         86 __sdcc_init_data:
                                     87 ; stm8_genXINIT() start
      008057 AE 00 05         [ 2]   88 	ldw x, #l_DATA
      00805A 27 07            [ 1]   89 	jreq	00002$
      00805C                         90 00001$:
      00805C 72 4F 00 00      [ 1]   91 	clr (s_DATA - 1, x)
      008060 5A               [ 2]   92 	decw x
      008061 26 F9            [ 1]   93 	jrne	00001$
      008063                         94 00002$:
      008063 AE 00 01         [ 2]   95 	ldw	x, #l_INITIALIZER
      008066 27 09            [ 1]   96 	jreq	00004$
      008068                         97 00003$:
      008068 D6 80 73         [ 1]   98 	ld	a, (s_INITIALIZER - 1, x)
      00806B D7 00 05         [ 1]   99 	ld	(s_INITIALIZED - 1, x), a
      00806E 5A               [ 2]  100 	decw	x
      00806F 26 F7            [ 1]  101 	jrne	00003$
      008071                        102 00004$:
                                    103 ; stm8_genXINIT() end
                                    104 	.area GSFINAL
      008071 CC 80 54         [ 2]  105 	jp	__sdcc_program_startup
                                    106 ;--------------------------------------------------------
                                    107 ; Home
                                    108 ;--------------------------------------------------------
                                    109 	.area HOME
                                    110 	.area HOME
      008054                        111 __sdcc_program_startup:
      008054 CC 80 7D         [ 2]  112 	jp	_main
                                    113 ;	return from main will return to caller
                                    114 ;--------------------------------------------------------
                                    115 ; code
                                    116 ;--------------------------------------------------------
                                    117 	.area CODE
                                    118 ;	main.c: 19: static void delay(uint16_t t) {
                                    119 ;	-----------------------------------------
                                    120 ;	 function delay
                                    121 ;	-----------------------------------------
      008075                        122 _delay:
                                    123 ;	main.c: 20: while(t--) {};
      008075                        124 00101$:
      008075 90 93            [ 1]  125 	ldw	y, x
      008077 5A               [ 2]  126 	decw	x
      008078 90 5D            [ 2]  127 	tnzw	y
      00807A 26 F9            [ 1]  128 	jrne	00101$
                                    129 ;	main.c: 21: }
      00807C 81               [ 4]  130 	ret
                                    131 ;	main.c: 25: int main() {
                                    132 ;	-----------------------------------------
                                    133 ;	 function main
                                    134 ;	-----------------------------------------
      00807D                        135 _main:
      00807D 52 05            [ 2]  136 	sub	sp, #5
                                    137 ;	main.c: 26: __asm sim __endasm; // Disable interrupts
      00807F 9B               [ 1]  138 	sim	
                                    139 ;	main.c: 28: clk_init();
      008080 CD 83 1E         [ 4]  140 	call	_clk_init
                                    141 ;	main.c: 29: gpio_init();
      008083 CD 82 65         [ 4]  142 	call	_gpio_init
                                    143 ;	main.c: 30: tim2_init();
      008086 CD 81 FC         [ 4]  144 	call	_tim2_init
                                    145 ;	main.c: 31: uart_init();
      008089 CD 83 6C         [ 4]  146 	call	_uart_init
                                    147 ;	main.c: 33: char banner[5] = {'1', '2', '3', '4', '5'};
      00808C 96               [ 1]  148 	ldw	x, sp
      00808D 5C               [ 1]  149 	incw	x
      00808E A6 31            [ 1]  150 	ld	a, #0x31
      008090 F7               [ 1]  151 	ld	(x), a
      008091 A6 32            [ 1]  152 	ld	a, #0x32
      008093 6B 02            [ 1]  153 	ld	(0x02, sp), a
      008095 A6 33            [ 1]  154 	ld	a, #0x33
      008097 6B 03            [ 1]  155 	ld	(0x03, sp), a
      008099 A6 34            [ 1]  156 	ld	a, #0x34
      00809B 6B 04            [ 1]  157 	ld	(0x04, sp), a
      00809D A6 35            [ 1]  158 	ld	a, #0x35
      00809F 6B 05            [ 1]  159 	ld	(0x05, sp), a
                                    160 ;	main.c: 34: uart_tx_byte_array(banner, 5);
      0080A1 A6 05            [ 1]  161 	ld	a, #0x05
      0080A3 CD 83 DB         [ 4]  162 	call	_uart_tx_byte_array
                                    163 ;	main.c: 36: __asm rim __endasm; // Enable interrupts
      0080A6 9A               [ 1]  164 	rim	
                                    165 ;	main.c: 40: rgb.r = 0;
      0080A7 35 00 00 01      [ 1]  166 	mov	_rgb+0, #0x00
                                    167 ;	main.c: 41: rgb.g = 0;
      0080AB 35 00 00 02      [ 1]  168 	mov	_rgb+1, #0x00
                                    169 ;	main.c: 42: rgb.b = 0;
      0080AF 35 00 00 03      [ 1]  170 	mov	_rgb+2, #0x00
                                    171 ;	main.c: 44: while(1) {
      0080B3                        172 00102$:
                                    173 ;	main.c: 45: button_hundler(&rgb);
      0080B3 AE 00 01         [ 2]  174 	ldw	x, #(_rgb+0)
      0080B6 CD 80 C4         [ 4]  175 	call	_button_hundler
                                    176 ;	main.c: 46: write_color_to_registers(&rgb);
      0080B9 AE 00 01         [ 2]  177 	ldw	x, #(_rgb+0)
      0080BC CD 81 B5         [ 4]  178 	call	_write_color_to_registers
      0080BF 20 F2            [ 2]  179 	jra	00102$
                                    180 ;	main.c: 48: }
      0080C1 5B 05            [ 2]  181 	addw	sp, #5
      0080C3 81               [ 4]  182 	ret
                                    183 ;	main.c: 50: void button_hundler(struct Color *color) {
                                    184 ;	-----------------------------------------
                                    185 ;	 function button_hundler
                                    186 ;	-----------------------------------------
      0080C4                        187 _button_hundler:
      0080C4 52 04            [ 2]  188 	sub	sp, #4
      0080C6 1F 03            [ 2]  189 	ldw	(0x03, sp), x
                                    190 ;	main.c: 51: if((1 << 2) == (~PD_IDR & (1 << 2))) { // Btn_R+
      0080C8 C6 50 10         [ 1]  191 	ld	a, 0x5010
      0080CB 5F               [ 1]  192 	clrw	x
      0080CC 97               [ 1]  193 	ld	xl, a
      0080CD 53               [ 2]  194 	cplw	x
      0080CE 9F               [ 1]  195 	ld	a, xl
      0080CF A4 04            [ 1]  196 	and	a, #0x04
      0080D1 97               [ 1]  197 	ld	xl, a
      0080D2 4F               [ 1]  198 	clr	a
      0080D3 95               [ 1]  199 	ld	xh, a
      0080D4 A3 00 04         [ 2]  200 	cpw	x, #0x0004
      0080D7 26 05            [ 1]  201 	jrne	00102$
                                    202 ;	main.c: 52: smart_increment(&color->r);
      0080D9 1E 03            [ 2]  203 	ldw	x, (0x03, sp)
      0080DB CD 81 EC         [ 4]  204 	call	_smart_increment
      0080DE                        205 00102$:
                                    206 ;	main.c: 55: if((1 << 7) == (~PC_IDR & (1 << 7))) { // Btn_R-
      0080DE C6 50 0B         [ 1]  207 	ld	a, 0x500b
      0080E1 5F               [ 1]  208 	clrw	x
      0080E2 97               [ 1]  209 	ld	xl, a
      0080E3 53               [ 2]  210 	cplw	x
      0080E4 9F               [ 1]  211 	ld	a, xl
      0080E5 A4 80            [ 1]  212 	and	a, #0x80
      0080E7 97               [ 1]  213 	ld	xl, a
      0080E8 4F               [ 1]  214 	clr	a
      0080E9 95               [ 1]  215 	ld	xh, a
      0080EA A3 00 80         [ 2]  216 	cpw	x, #0x0080
      0080ED 26 05            [ 1]  217 	jrne	00104$
                                    218 ;	main.c: 56: smart_decrement(&color->r);
      0080EF 1E 03            [ 2]  219 	ldw	x, (0x03, sp)
      0080F1 CD 81 F5         [ 4]  220 	call	_smart_decrement
      0080F4                        221 00104$:
                                    222 ;	main.c: 59: if((1 << 6) == (~PC_IDR & (1 << 6))) { // Btn_G+
      0080F4 C6 50 0B         [ 1]  223 	ld	a, 0x500b
      0080F7 5F               [ 1]  224 	clrw	x
      0080F8 97               [ 1]  225 	ld	xl, a
      0080F9 53               [ 2]  226 	cplw	x
      0080FA 9F               [ 1]  227 	ld	a, xl
      0080FB A4 40            [ 1]  228 	and	a, #0x40
      0080FD 97               [ 1]  229 	ld	xl, a
      0080FE 4F               [ 1]  230 	clr	a
                                    231 ;	main.c: 60: smart_increment(&color->g);
      0080FF 16 03            [ 2]  232 	ldw	y, (0x03, sp)
      008101 90 5C            [ 1]  233 	incw	y
      008103 17 01            [ 2]  234 	ldw	(0x01, sp), y
                                    235 ;	main.c: 59: if((1 << 6) == (~PC_IDR & (1 << 6))) { // Btn_G+
      008105 95               [ 1]  236 	ld	xh, a
      008106 A3 00 40         [ 2]  237 	cpw	x, #0x0040
      008109 26 05            [ 1]  238 	jrne	00106$
                                    239 ;	main.c: 60: smart_increment(&color->g);
      00810B 1E 01            [ 2]  240 	ldw	x, (0x01, sp)
      00810D CD 81 EC         [ 4]  241 	call	_smart_increment
      008110                        242 00106$:
                                    243 ;	main.c: 63: if((1 << 5) == (~PC_IDR & (1 << 5))) { // Btn_G-
      008110 C6 50 0B         [ 1]  244 	ld	a, 0x500b
      008113 5F               [ 1]  245 	clrw	x
      008114 97               [ 1]  246 	ld	xl, a
      008115 53               [ 2]  247 	cplw	x
      008116 9F               [ 1]  248 	ld	a, xl
      008117 A4 20            [ 1]  249 	and	a, #0x20
      008119 97               [ 1]  250 	ld	xl, a
      00811A 4F               [ 1]  251 	clr	a
      00811B 95               [ 1]  252 	ld	xh, a
      00811C A3 00 20         [ 2]  253 	cpw	x, #0x0020
      00811F 26 05            [ 1]  254 	jrne	00108$
                                    255 ;	main.c: 64: smart_decrement(&color->g);
      008121 1E 01            [ 2]  256 	ldw	x, (0x01, sp)
      008123 CD 81 F5         [ 4]  257 	call	_smart_decrement
      008126                        258 00108$:
                                    259 ;	main.c: 67: if((1 << 4) == (~PC_IDR & (1 << 4))) { // Btn_B+
      008126 C6 50 0B         [ 1]  260 	ld	a, 0x500b
      008129 5F               [ 1]  261 	clrw	x
      00812A 97               [ 1]  262 	ld	xl, a
      00812B 53               [ 2]  263 	cplw	x
      00812C 90 5F            [ 1]  264 	clrw	y
      00812E 9F               [ 1]  265 	ld	a, xl
      00812F A4 10            [ 1]  266 	and	a, #0x10
      008131 90 97            [ 1]  267 	ld	yl, a
                                    268 ;	main.c: 68: smart_increment(&color->b);
      008133 1E 03            [ 2]  269 	ldw	x, (0x03, sp)
      008135 5C               [ 1]  270 	incw	x
      008136 5C               [ 1]  271 	incw	x
      008137 1F 01            [ 2]  272 	ldw	(0x01, sp), x
                                    273 ;	main.c: 67: if((1 << 4) == (~PC_IDR & (1 << 4))) { // Btn_B+
      008139 90 A3 00 10      [ 2]  274 	cpw	y, #0x0010
      00813D 26 05            [ 1]  275 	jrne	00110$
                                    276 ;	main.c: 68: smart_increment(&color->b);
      00813F 1E 01            [ 2]  277 	ldw	x, (0x01, sp)
      008141 CD 81 EC         [ 4]  278 	call	_smart_increment
      008144                        279 00110$:
                                    280 ;	main.c: 71: if((1 << 3) == (~PC_IDR & (1 << 3))) { // Btn_B-
      008144 C6 50 0B         [ 1]  281 	ld	a, 0x500b
      008147 5F               [ 1]  282 	clrw	x
      008148 97               [ 1]  283 	ld	xl, a
      008149 53               [ 2]  284 	cplw	x
      00814A 9F               [ 1]  285 	ld	a, xl
      00814B A4 08            [ 1]  286 	and	a, #0x08
      00814D 97               [ 1]  287 	ld	xl, a
      00814E 4F               [ 1]  288 	clr	a
      00814F 95               [ 1]  289 	ld	xh, a
      008150 A3 00 08         [ 2]  290 	cpw	x, #0x0008
      008153 26 07            [ 1]  291 	jrne	00113$
                                    292 ;	main.c: 72: smart_decrement(&color->b);
      008155 1E 01            [ 2]  293 	ldw	x, (0x01, sp)
      008157 5B 04            [ 2]  294 	addw	sp, #4
      008159 CC 81 F5         [ 2]  295 	jp	_smart_decrement
                                    296 ;	main.c: 78: if((1 << 5) == (~PB_IDR & (1 << 5))) { // Btn_LOAD
      00815C                        297 00113$:
                                    298 ;	main.c: 80: }
      00815C 5B 04            [ 2]  299 	addw	sp, #4
      00815E 81               [ 4]  300 	ret
                                    301 ;	main.c: 82: extern void uart1_rx_handler(void) __interrupt(18) {
                                    302 ;	-----------------------------------------
                                    303 ;	 function uart1_rx_handler
                                    304 ;	-----------------------------------------
      00815F                        305 _uart1_rx_handler:
      00815F 4F               [ 1]  306 	clr	a
      008160 62               [ 2]  307 	div	x, a
      008161 88               [ 1]  308 	push	a
                                    309 ;	main.c: 83: rgb.r = 0;
      008162 35 00 00 01      [ 1]  310 	mov	_rgb+0, #0x00
                                    311 ;	main.c: 84: rgb.g = 0;
      008166 35 00 00 02      [ 1]  312 	mov	_rgb+1, #0x00
                                    313 ;	main.c: 85: rgb.b = 0;
      00816A 35 00 00 03      [ 1]  314 	mov	_rgb+2, #0x00
                                    315 ;	main.c: 86: write_color_to_registers(&rgb);
      00816E AE 00 01         [ 2]  316 	ldw	x, #(_rgb+0)
      008171 CD 81 B5         [ 4]  317 	call	_write_color_to_registers
                                    318 ;	main.c: 88: UART1_SR &= ~(1 << 5); // Clear interrupt
      008174 72 1B 52 30      [ 1]  319 	bres	0x5230, #5
                                    320 ;	main.c: 89: char byte = UART1_DR;
      008178 C6 52 31         [ 1]  321 	ld	a, 0x5231
      00817B 6B 01            [ 1]  322 	ld	(0x01, sp), a
                                    323 ;	main.c: 90: uart_tx_byte(&byte);
      00817D 96               [ 1]  324 	ldw	x, sp
      00817E 5C               [ 1]  325 	incw	x
      00817F CD 83 C3         [ 4]  326 	call	_uart_tx_byte
                                    327 ;	main.c: 91: }
      008182 84               [ 1]  328 	pop	a
      008183 80               [11]  329 	iret
                                    330 	.area CODE
                                    331 	.area CONST
                                    332 	.area INITIALIZER
                                    333 	.area CABS (ABS)
