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
                                     19 	.globl _btn_load_is_pressed
                                     20 	.globl _btn_flash_is_pressed
                                     21 	.globl _btn_b_minus_is_pressed
                                     22 	.globl _btn_g_minus_is_pressed
                                     23 	.globl _btn_r_minus_is_pressed
                                     24 	.globl _btn_b_plus_is_pressed
                                     25 	.globl _btn_g_plus_is_pressed
                                     26 	.globl _btn_r_plus_is_pressed
                                     27 	.globl _gpio_init
                                     28 	.globl _clk_init
                                     29 	.globl _rgb
                                     30 	.globl _button_hundler
                                     31 ;--------------------------------------------------------
                                     32 ; ram data
                                     33 ;--------------------------------------------------------
                                     34 	.area DATA
      000001                         35 _rgb::
      000001                         36 	.ds 3
                                     37 ;--------------------------------------------------------
                                     38 ; ram data
                                     39 ;--------------------------------------------------------
                                     40 	.area INITIALIZED
                                     41 ;--------------------------------------------------------
                                     42 ; Stack segment in internal ram
                                     43 ;--------------------------------------------------------
                                     44 	.area	SSEG
      000007                         45 __start__stack:
      000007                         46 	.ds	1
                                     47 
                                     48 ;--------------------------------------------------------
                                     49 ; absolute external ram data
                                     50 ;--------------------------------------------------------
                                     51 	.area DABS (ABS)
                                     52 
                                     53 ; default segment ordering for linker
                                     54 	.area HOME
                                     55 	.area GSINIT
                                     56 	.area GSFINAL
                                     57 	.area CONST
                                     58 	.area INITIALIZER
                                     59 	.area CODE
                                     60 
                                     61 ;--------------------------------------------------------
                                     62 ; interrupt vector
                                     63 ;--------------------------------------------------------
                                     64 	.area HOME
      008000                         65 __interrupt_vect:
      008000 82 00 80 57             66 	int s_GSINIT ; reset
      008004 82 00 00 00             67 	int 0x000000 ; trap
      008008 82 00 00 00             68 	int 0x000000 ; int0
      00800C 82 00 00 00             69 	int 0x000000 ; int1
      008010 82 00 00 00             70 	int 0x000000 ; int2
      008014 82 00 00 00             71 	int 0x000000 ; int3
      008018 82 00 00 00             72 	int 0x000000 ; int4
      00801C 82 00 00 00             73 	int 0x000000 ; int5
      008020 82 00 00 00             74 	int 0x000000 ; int6
      008024 82 00 00 00             75 	int 0x000000 ; int7
      008028 82 00 00 00             76 	int 0x000000 ; int8
      00802C 82 00 00 00             77 	int 0x000000 ; int9
      008030 82 00 00 00             78 	int 0x000000 ; int10
      008034 82 00 00 00             79 	int 0x000000 ; int11
      008038 82 00 00 00             80 	int 0x000000 ; int12
      00803C 82 00 00 00             81 	int 0x000000 ; int13
      008040 82 00 00 00             82 	int 0x000000 ; int14
      008044 82 00 00 00             83 	int 0x000000 ; int15
      008048 82 00 00 00             84 	int 0x000000 ; int16
      00804C 82 00 00 00             85 	int 0x000000 ; int17
      008050 82 00 81 19             86 	int _uart1_rx_handler ; int18
                                     87 ;--------------------------------------------------------
                                     88 ; global & static initialisations
                                     89 ;--------------------------------------------------------
                                     90 	.area HOME
                                     91 	.area GSINIT
                                     92 	.area GSFINAL
                                     93 	.area GSINIT
      008057                         94 __sdcc_init_data:
                                     95 ; stm8_genXINIT() start
      008057 AE 00 05         [ 2]   96 	ldw x, #l_DATA
      00805A 27 07            [ 1]   97 	jreq	00002$
      00805C                         98 00001$:
      00805C 72 4F 00 00      [ 1]   99 	clr (s_DATA - 1, x)
      008060 5A               [ 2]  100 	decw x
      008061 26 F9            [ 1]  101 	jrne	00001$
      008063                        102 00002$:
      008063 AE 00 01         [ 2]  103 	ldw	x, #l_INITIALIZER
      008066 27 09            [ 1]  104 	jreq	00004$
      008068                        105 00003$:
      008068 D6 80 73         [ 1]  106 	ld	a, (s_INITIALIZER - 1, x)
      00806B D7 00 05         [ 1]  107 	ld	(s_INITIALIZED - 1, x), a
      00806E 5A               [ 2]  108 	decw	x
      00806F 26 F7            [ 1]  109 	jrne	00003$
      008071                        110 00004$:
                                    111 ; stm8_genXINIT() end
                                    112 	.area GSFINAL
      008071 CC 80 54         [ 2]  113 	jp	__sdcc_program_startup
                                    114 ;--------------------------------------------------------
                                    115 ; Home
                                    116 ;--------------------------------------------------------
                                    117 	.area HOME
                                    118 	.area HOME
      008054                        119 __sdcc_program_startup:
      008054 CC 80 7D         [ 2]  120 	jp	_main
                                    121 ;	return from main will return to caller
                                    122 ;--------------------------------------------------------
                                    123 ; code
                                    124 ;--------------------------------------------------------
                                    125 	.area CODE
                                    126 ;	main.c: 19: static void delay(uint16_t t) {
                                    127 ;	-----------------------------------------
                                    128 ;	 function delay
                                    129 ;	-----------------------------------------
      008075                        130 _delay:
                                    131 ;	main.c: 20: while(t--) {};
      008075                        132 00101$:
      008075 90 93            [ 1]  133 	ldw	y, x
      008077 5A               [ 2]  134 	decw	x
      008078 90 5D            [ 2]  135 	tnzw	y
      00807A 26 F9            [ 1]  136 	jrne	00101$
                                    137 ;	main.c: 21: }
      00807C 81               [ 4]  138 	ret
                                    139 ;	main.c: 25: int main() {
                                    140 ;	-----------------------------------------
                                    141 ;	 function main
                                    142 ;	-----------------------------------------
      00807D                        143 _main:
      00807D 52 05            [ 2]  144 	sub	sp, #5
                                    145 ;	main.c: 26: __asm sim __endasm; // Disable interrupts
      00807F 9B               [ 1]  146 	sim	
                                    147 ;	main.c: 28: clk_init();
      008080 CD 83 88         [ 4]  148 	call	_clk_init
                                    149 ;	main.c: 29: gpio_init();
      008083 CD 82 1F         [ 4]  150 	call	_gpio_init
                                    151 ;	main.c: 30: tim2_init();
      008086 CD 81 B6         [ 4]  152 	call	_tim2_init
                                    153 ;	main.c: 31: uart_init();
      008089 CD 83 D6         [ 4]  154 	call	_uart_init
                                    155 ;	main.c: 33: char banner[5] = {'1', '2', '3', '4', '5'};
      00808C 96               [ 1]  156 	ldw	x, sp
      00808D 5C               [ 1]  157 	incw	x
      00808E A6 31            [ 1]  158 	ld	a, #0x31
      008090 F7               [ 1]  159 	ld	(x), a
      008091 A6 32            [ 1]  160 	ld	a, #0x32
      008093 6B 02            [ 1]  161 	ld	(0x02, sp), a
      008095 A6 33            [ 1]  162 	ld	a, #0x33
      008097 6B 03            [ 1]  163 	ld	(0x03, sp), a
      008099 A6 34            [ 1]  164 	ld	a, #0x34
      00809B 6B 04            [ 1]  165 	ld	(0x04, sp), a
      00809D A6 35            [ 1]  166 	ld	a, #0x35
      00809F 6B 05            [ 1]  167 	ld	(0x05, sp), a
                                    168 ;	main.c: 34: uart_tx_byte_array(banner, 5);
      0080A1 A6 05            [ 1]  169 	ld	a, #0x05
      0080A3 CD 84 45         [ 4]  170 	call	_uart_tx_byte_array
                                    171 ;	main.c: 36: __asm rim __endasm; // Enable interrupts
      0080A6 9A               [ 1]  172 	rim	
                                    173 ;	main.c: 40: rgb.r = 0;
      0080A7 35 00 00 01      [ 1]  174 	mov	_rgb+0, #0x00
                                    175 ;	main.c: 41: rgb.g = 0;
      0080AB 35 00 00 02      [ 1]  176 	mov	_rgb+1, #0x00
                                    177 ;	main.c: 42: rgb.b = 0;
      0080AF 35 00 00 03      [ 1]  178 	mov	_rgb+2, #0x00
                                    179 ;	main.c: 44: while(1) {
      0080B3                        180 00102$:
                                    181 ;	main.c: 45: button_hundler(&rgb);
      0080B3 AE 00 01         [ 2]  182 	ldw	x, #(_rgb+0)
      0080B6 CD 80 C4         [ 4]  183 	call	_button_hundler
                                    184 ;	main.c: 46: write_color_to_registers(&rgb);
      0080B9 AE 00 01         [ 2]  185 	ldw	x, #(_rgb+0)
      0080BC CD 81 6F         [ 4]  186 	call	_write_color_to_registers
      0080BF 20 F2            [ 2]  187 	jra	00102$
                                    188 ;	main.c: 48: }
      0080C1 5B 05            [ 2]  189 	addw	sp, #5
      0080C3 81               [ 4]  190 	ret
                                    191 ;	main.c: 50: void button_hundler(struct Color *color) {
                                    192 ;	-----------------------------------------
                                    193 ;	 function button_hundler
                                    194 ;	-----------------------------------------
      0080C4                        195 _button_hundler:
      0080C4 52 02            [ 2]  196 	sub	sp, #2
      0080C6 1F 01            [ 2]  197 	ldw	(0x01, sp), x
                                    198 ;	main.c: 51: if(btn_r_plus_is_pressed()) {
      0080C8 CD 82 D8         [ 4]  199 	call	_btn_r_plus_is_pressed
      0080CB 4D               [ 1]  200 	tnz	a
      0080CC 27 05            [ 1]  201 	jreq	00102$
                                    202 ;	main.c: 52: smart_increment(&color->r);
      0080CE 1E 01            [ 2]  203 	ldw	x, (0x01, sp)
      0080D0 CD 81 A6         [ 4]  204 	call	_smart_increment
      0080D3                        205 00102$:
                                    206 ;	main.c: 55: if(btn_r_minus_is_pressed()) {
      0080D3 CD 83 1A         [ 4]  207 	call	_btn_r_minus_is_pressed
      0080D6 4D               [ 1]  208 	tnz	a
      0080D7 27 05            [ 1]  209 	jreq	00104$
                                    210 ;	main.c: 56: smart_decrement(&color->r);
      0080D9 1E 01            [ 2]  211 	ldw	x, (0x01, sp)
      0080DB CD 81 AF         [ 4]  212 	call	_smart_decrement
      0080DE                        213 00104$:
                                    214 ;	main.c: 59: if(btn_g_plus_is_pressed()) {
      0080DE CD 82 EE         [ 4]  215 	call	_btn_g_plus_is_pressed
                                    216 ;	main.c: 60: smart_increment(&color->g);
      0080E1 1E 01            [ 2]  217 	ldw	x, (0x01, sp)
      0080E3 5C               [ 1]  218 	incw	x
                                    219 ;	main.c: 59: if(btn_g_plus_is_pressed()) {
      0080E4 4D               [ 1]  220 	tnz	a
      0080E5 27 05            [ 1]  221 	jreq	00106$
                                    222 ;	main.c: 60: smart_increment(&color->g);
      0080E7 89               [ 2]  223 	pushw	x
      0080E8 CD 81 A6         [ 4]  224 	call	_smart_increment
      0080EB 85               [ 2]  225 	popw	x
      0080EC                        226 00106$:
                                    227 ;	main.c: 63: if(btn_g_minus_is_pressed()) {
      0080EC 89               [ 2]  228 	pushw	x
      0080ED CD 83 30         [ 4]  229 	call	_btn_g_minus_is_pressed
      0080F0 85               [ 2]  230 	popw	x
      0080F1 4D               [ 1]  231 	tnz	a
      0080F2 27 03            [ 1]  232 	jreq	00108$
                                    233 ;	main.c: 64: smart_decrement(&color->g);
      0080F4 CD 81 AF         [ 4]  234 	call	_smart_decrement
      0080F7                        235 00108$:
                                    236 ;	main.c: 67: if(btn_b_plus_is_pressed()) {
      0080F7 CD 83 04         [ 4]  237 	call	_btn_b_plus_is_pressed
                                    238 ;	main.c: 68: smart_increment(&color->b);
      0080FA 1E 01            [ 2]  239 	ldw	x, (0x01, sp)
      0080FC 5C               [ 1]  240 	incw	x
      0080FD 5C               [ 1]  241 	incw	x
                                    242 ;	main.c: 67: if(btn_b_plus_is_pressed()) {
      0080FE 4D               [ 1]  243 	tnz	a
      0080FF 27 05            [ 1]  244 	jreq	00110$
                                    245 ;	main.c: 68: smart_increment(&color->b);
      008101 89               [ 2]  246 	pushw	x
      008102 CD 81 A6         [ 4]  247 	call	_smart_increment
      008105 85               [ 2]  248 	popw	x
      008106                        249 00110$:
                                    250 ;	main.c: 71: if(btn_b_minus_is_pressed()) {
      008106 89               [ 2]  251 	pushw	x
      008107 CD 83 46         [ 4]  252 	call	_btn_b_minus_is_pressed
      00810A 85               [ 2]  253 	popw	x
      00810B 4D               [ 1]  254 	tnz	a
      00810C 27 03            [ 1]  255 	jreq	00112$
                                    256 ;	main.c: 72: smart_decrement(&color->b);
      00810E CD 81 AF         [ 4]  257 	call	_smart_decrement
      008111                        258 00112$:
                                    259 ;	main.c: 75: if(btn_flash_is_pressed()) {
      008111 CD 83 5C         [ 4]  260 	call	_btn_flash_is_pressed
                                    261 ;	main.c: 78: if(btn_load_is_pressed()) {
      008114 5B 02            [ 2]  262 	addw	sp, #2
                                    263 ;	main.c: 80: }
      008116 CC 83 72         [ 2]  264 	jp	_btn_load_is_pressed
                                    265 ;	main.c: 82: extern void uart1_rx_handler(void) __interrupt(18) {
                                    266 ;	-----------------------------------------
                                    267 ;	 function uart1_rx_handler
                                    268 ;	-----------------------------------------
      008119                        269 _uart1_rx_handler:
      008119 4F               [ 1]  270 	clr	a
      00811A 62               [ 2]  271 	div	x, a
      00811B 88               [ 1]  272 	push	a
                                    273 ;	main.c: 83: rgb.r = 0;
      00811C 35 00 00 01      [ 1]  274 	mov	_rgb+0, #0x00
                                    275 ;	main.c: 84: rgb.g = 0;
      008120 35 00 00 02      [ 1]  276 	mov	_rgb+1, #0x00
                                    277 ;	main.c: 85: rgb.b = 0;
      008124 35 00 00 03      [ 1]  278 	mov	_rgb+2, #0x00
                                    279 ;	main.c: 86: write_color_to_registers(&rgb);
      008128 AE 00 01         [ 2]  280 	ldw	x, #(_rgb+0)
      00812B CD 81 6F         [ 4]  281 	call	_write_color_to_registers
                                    282 ;	main.c: 88: UART1_SR &= ~(1 << 5); // Clear interrupt
      00812E 72 1B 52 30      [ 1]  283 	bres	0x5230, #5
                                    284 ;	main.c: 89: char byte = UART1_DR;
      008132 C6 52 31         [ 1]  285 	ld	a, 0x5231
      008135 6B 01            [ 1]  286 	ld	(0x01, sp), a
                                    287 ;	main.c: 90: uart_tx_byte(&byte);
      008137 96               [ 1]  288 	ldw	x, sp
      008138 5C               [ 1]  289 	incw	x
      008139 CD 84 2D         [ 4]  290 	call	_uart_tx_byte
                                    291 ;	main.c: 91: }
      00813C 84               [ 1]  292 	pop	a
      00813D 80               [11]  293 	iret
                                    294 	.area CODE
                                    295 	.area CONST
                                    296 	.area INITIALIZER
                                    297 	.area CABS (ABS)
