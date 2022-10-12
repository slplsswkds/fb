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
                                     19 	.globl _get_number_from_buttons
                                     20 	.globl _btn_load_is_pressed
                                     21 	.globl _btn_flash_is_pressed
                                     22 	.globl _btn_b_minus_is_pressed
                                     23 	.globl _btn_g_minus_is_pressed
                                     24 	.globl _btn_r_minus_is_pressed
                                     25 	.globl _btn_b_plus_is_pressed
                                     26 	.globl _btn_g_plus_is_pressed
                                     27 	.globl _btn_r_plus_is_pressed
                                     28 	.globl _gpio_init
                                     29 	.globl _clk_init
                                     30 	.globl _rgb
                                     31 	.globl _button_hundler
                                     32 ;--------------------------------------------------------
                                     33 ; ram data
                                     34 ;--------------------------------------------------------
                                     35 	.area DATA
      000001                         36 _rgb::
      000001                         37 	.ds 3
                                     38 ;--------------------------------------------------------
                                     39 ; ram data
                                     40 ;--------------------------------------------------------
                                     41 	.area INITIALIZED
                                     42 ;--------------------------------------------------------
                                     43 ; Stack segment in internal ram
                                     44 ;--------------------------------------------------------
                                     45 	.area	SSEG
      000008                         46 __start__stack:
      000008                         47 	.ds	1
                                     48 
                                     49 ;--------------------------------------------------------
                                     50 ; absolute external ram data
                                     51 ;--------------------------------------------------------
                                     52 	.area DABS (ABS)
                                     53 
                                     54 ; default segment ordering for linker
                                     55 	.area HOME
                                     56 	.area GSINIT
                                     57 	.area GSFINAL
                                     58 	.area CONST
                                     59 	.area INITIALIZER
                                     60 	.area CODE
                                     61 
                                     62 ;--------------------------------------------------------
                                     63 ; interrupt vector
                                     64 ;--------------------------------------------------------
                                     65 	.area HOME
      008000                         66 __interrupt_vect:
      008000 82 00 80 57             67 	int s_GSINIT ; reset
      008004 82 00 00 00             68 	int 0x000000 ; trap
      008008 82 00 00 00             69 	int 0x000000 ; int0
      00800C 82 00 00 00             70 	int 0x000000 ; int1
      008010 82 00 00 00             71 	int 0x000000 ; int2
      008014 82 00 00 00             72 	int 0x000000 ; int3
      008018 82 00 00 00             73 	int 0x000000 ; int4
      00801C 82 00 00 00             74 	int 0x000000 ; int5
      008020 82 00 00 00             75 	int 0x000000 ; int6
      008024 82 00 00 00             76 	int 0x000000 ; int7
      008028 82 00 00 00             77 	int 0x000000 ; int8
      00802C 82 00 00 00             78 	int 0x000000 ; int9
      008030 82 00 00 00             79 	int 0x000000 ; int10
      008034 82 00 00 00             80 	int 0x000000 ; int11
      008038 82 00 00 00             81 	int 0x000000 ; int12
      00803C 82 00 00 00             82 	int 0x000000 ; int13
      008040 82 00 00 00             83 	int 0x000000 ; int14
      008044 82 00 00 00             84 	int 0x000000 ; int15
      008048 82 00 00 00             85 	int 0x000000 ; int16
      00804C 82 00 00 00             86 	int 0x000000 ; int17
      008050 82 00 81 33             87 	int _uart1_rx_handler ; int18
                                     88 ;--------------------------------------------------------
                                     89 ; global & static initialisations
                                     90 ;--------------------------------------------------------
                                     91 	.area HOME
                                     92 	.area GSINIT
                                     93 	.area GSFINAL
                                     94 	.area GSINIT
      008057                         95 __sdcc_init_data:
                                     96 ; stm8_genXINIT() start
      008057 AE 00 05         [ 2]   97 	ldw x, #l_DATA
      00805A 27 07            [ 1]   98 	jreq	00002$
      00805C                         99 00001$:
      00805C 72 4F 00 00      [ 1]  100 	clr (s_DATA - 1, x)
      008060 5A               [ 2]  101 	decw x
      008061 26 F9            [ 1]  102 	jrne	00001$
      008063                        103 00002$:
      008063 AE 00 02         [ 2]  104 	ldw	x, #l_INITIALIZER
      008066 27 09            [ 1]  105 	jreq	00004$
      008068                        106 00003$:
      008068 D6 80 73         [ 1]  107 	ld	a, (s_INITIALIZER - 1, x)
      00806B D7 00 05         [ 1]  108 	ld	(s_INITIALIZED - 1, x), a
      00806E 5A               [ 2]  109 	decw	x
      00806F 26 F7            [ 1]  110 	jrne	00003$
      008071                        111 00004$:
                                    112 ; stm8_genXINIT() end
                                    113 	.area GSFINAL
      008071 CC 80 54         [ 2]  114 	jp	__sdcc_program_startup
                                    115 ;--------------------------------------------------------
                                    116 ; Home
                                    117 ;--------------------------------------------------------
                                    118 	.area HOME
                                    119 	.area HOME
      008054                        120 __sdcc_program_startup:
      008054 CC 80 7E         [ 2]  121 	jp	_main
                                    122 ;	return from main will return to caller
                                    123 ;--------------------------------------------------------
                                    124 ; code
                                    125 ;--------------------------------------------------------
                                    126 	.area CODE
                                    127 ;	main.c: 19: static void delay(uint16_t t) {
                                    128 ;	-----------------------------------------
                                    129 ;	 function delay
                                    130 ;	-----------------------------------------
      008076                        131 _delay:
                                    132 ;	main.c: 20: while(t--) {};
      008076                        133 00101$:
      008076 90 93            [ 1]  134 	ldw	y, x
      008078 5A               [ 2]  135 	decw	x
      008079 90 5D            [ 2]  136 	tnzw	y
      00807B 26 F9            [ 1]  137 	jrne	00101$
                                    138 ;	main.c: 21: }
      00807D 81               [ 4]  139 	ret
                                    140 ;	main.c: 25: int main() {
                                    141 ;	-----------------------------------------
                                    142 ;	 function main
                                    143 ;	-----------------------------------------
      00807E                        144 _main:
      00807E 52 05            [ 2]  145 	sub	sp, #5
                                    146 ;	main.c: 26: __asm sim __endasm; // Disable interrupts
      008080 9B               [ 1]  147 	sim	
                                    148 ;	main.c: 28: clk_init();
      008081 CD 84 04         [ 4]  149 	call	_clk_init
                                    150 ;	main.c: 29: gpio_init();
      008084 CD 82 39         [ 4]  151 	call	_gpio_init
                                    152 ;	main.c: 30: tim2_init();
      008087 CD 81 D0         [ 4]  153 	call	_tim2_init
                                    154 ;	main.c: 31: uart_init();
      00808A CD 84 52         [ 4]  155 	call	_uart_init
                                    156 ;	main.c: 33: char banner[5] = {'1', '2', '3', '4', '5'};
      00808D 96               [ 1]  157 	ldw	x, sp
      00808E 5C               [ 1]  158 	incw	x
      00808F A6 31            [ 1]  159 	ld	a, #0x31
      008091 F7               [ 1]  160 	ld	(x), a
      008092 A6 32            [ 1]  161 	ld	a, #0x32
      008094 6B 02            [ 1]  162 	ld	(0x02, sp), a
      008096 A6 33            [ 1]  163 	ld	a, #0x33
      008098 6B 03            [ 1]  164 	ld	(0x03, sp), a
      00809A A6 34            [ 1]  165 	ld	a, #0x34
      00809C 6B 04            [ 1]  166 	ld	(0x04, sp), a
      00809E A6 35            [ 1]  167 	ld	a, #0x35
      0080A0 6B 05            [ 1]  168 	ld	(0x05, sp), a
                                    169 ;	main.c: 34: uart_tx_byte_array(banner, 5);
      0080A2 A6 05            [ 1]  170 	ld	a, #0x05
      0080A4 CD 84 C1         [ 4]  171 	call	_uart_tx_byte_array
                                    172 ;	main.c: 36: __asm rim __endasm; // Enable interrupts
      0080A7 9A               [ 1]  173 	rim	
                                    174 ;	main.c: 40: rgb.r = 0;
      0080A8 35 00 00 01      [ 1]  175 	mov	_rgb+0, #0x00
                                    176 ;	main.c: 41: rgb.g = 0;
      0080AC 35 00 00 02      [ 1]  177 	mov	_rgb+1, #0x00
                                    178 ;	main.c: 42: rgb.b = 0;
      0080B0 35 00 00 03      [ 1]  179 	mov	_rgb+2, #0x00
                                    180 ;	main.c: 44: while(1) {
      0080B4                        181 00102$:
                                    182 ;	main.c: 45: button_hundler(&rgb);
      0080B4 AE 00 01         [ 2]  183 	ldw	x, #(_rgb+0)
      0080B7 CD 80 C5         [ 4]  184 	call	_button_hundler
                                    185 ;	main.c: 46: write_color_to_registers(&rgb);
      0080BA AE 00 01         [ 2]  186 	ldw	x, #(_rgb+0)
      0080BD CD 81 89         [ 4]  187 	call	_write_color_to_registers
      0080C0 20 F2            [ 2]  188 	jra	00102$
                                    189 ;	main.c: 48: }
      0080C2 5B 05            [ 2]  190 	addw	sp, #5
      0080C4 81               [ 4]  191 	ret
                                    192 ;	main.c: 50: void button_hundler(struct Color *color) {
                                    193 ;	-----------------------------------------
                                    194 ;	 function button_hundler
                                    195 ;	-----------------------------------------
      0080C5                        196 _button_hundler:
      0080C5 52 03            [ 2]  197 	sub	sp, #3
      0080C7 1F 02            [ 2]  198 	ldw	(0x02, sp), x
                                    199 ;	main.c: 51: if(btn_r_plus_is_pressed()) {
      0080C9 CD 82 F2         [ 4]  200 	call	_btn_r_plus_is_pressed
      0080CC 4D               [ 1]  201 	tnz	a
      0080CD 27 05            [ 1]  202 	jreq	00102$
                                    203 ;	main.c: 52: smart_increment(&color->r);
      0080CF 1E 02            [ 2]  204 	ldw	x, (0x02, sp)
      0080D1 CD 81 C0         [ 4]  205 	call	_smart_increment
      0080D4                        206 00102$:
                                    207 ;	main.c: 55: if(btn_r_minus_is_pressed()) {
      0080D4 CD 83 34         [ 4]  208 	call	_btn_r_minus_is_pressed
      0080D7 4D               [ 1]  209 	tnz	a
      0080D8 27 05            [ 1]  210 	jreq	00104$
                                    211 ;	main.c: 56: smart_decrement(&color->r);
      0080DA 1E 02            [ 2]  212 	ldw	x, (0x02, sp)
      0080DC CD 81 C9         [ 4]  213 	call	_smart_decrement
      0080DF                        214 00104$:
                                    215 ;	main.c: 59: if(btn_g_plus_is_pressed()) {
      0080DF CD 83 08         [ 4]  216 	call	_btn_g_plus_is_pressed
                                    217 ;	main.c: 60: smart_increment(&color->g);
      0080E2 1E 02            [ 2]  218 	ldw	x, (0x02, sp)
      0080E4 5C               [ 1]  219 	incw	x
                                    220 ;	main.c: 59: if(btn_g_plus_is_pressed()) {
      0080E5 4D               [ 1]  221 	tnz	a
      0080E6 27 05            [ 1]  222 	jreq	00106$
                                    223 ;	main.c: 60: smart_increment(&color->g);
      0080E8 89               [ 2]  224 	pushw	x
      0080E9 CD 81 C0         [ 4]  225 	call	_smart_increment
      0080EC 85               [ 2]  226 	popw	x
      0080ED                        227 00106$:
                                    228 ;	main.c: 63: if(btn_g_minus_is_pressed()) {
      0080ED 89               [ 2]  229 	pushw	x
      0080EE CD 83 4A         [ 4]  230 	call	_btn_g_minus_is_pressed
      0080F1 85               [ 2]  231 	popw	x
      0080F2 4D               [ 1]  232 	tnz	a
      0080F3 27 03            [ 1]  233 	jreq	00108$
                                    234 ;	main.c: 64: smart_decrement(&color->g);
      0080F5 CD 81 C9         [ 4]  235 	call	_smart_decrement
      0080F8                        236 00108$:
                                    237 ;	main.c: 67: if(btn_b_plus_is_pressed()) {
      0080F8 CD 83 1E         [ 4]  238 	call	_btn_b_plus_is_pressed
                                    239 ;	main.c: 68: smart_increment(&color->b);
      0080FB 1E 02            [ 2]  240 	ldw	x, (0x02, sp)
      0080FD 5C               [ 1]  241 	incw	x
      0080FE 5C               [ 1]  242 	incw	x
                                    243 ;	main.c: 67: if(btn_b_plus_is_pressed()) {
      0080FF 4D               [ 1]  244 	tnz	a
      008100 27 05            [ 1]  245 	jreq	00110$
                                    246 ;	main.c: 68: smart_increment(&color->b);
      008102 89               [ 2]  247 	pushw	x
      008103 CD 81 C0         [ 4]  248 	call	_smart_increment
      008106 85               [ 2]  249 	popw	x
      008107                        250 00110$:
                                    251 ;	main.c: 71: if(btn_b_minus_is_pressed()) {
      008107 89               [ 2]  252 	pushw	x
      008108 CD 83 60         [ 4]  253 	call	_btn_b_minus_is_pressed
      00810B 85               [ 2]  254 	popw	x
      00810C 4D               [ 1]  255 	tnz	a
      00810D 27 03            [ 1]  256 	jreq	00112$
                                    257 ;	main.c: 72: smart_decrement(&color->b);
      00810F CD 81 C9         [ 4]  258 	call	_smart_decrement
      008112                        259 00112$:
                                    260 ;	main.c: 75: if(btn_flash_is_pressed()) {
      008112 CD 83 76         [ 4]  261 	call	_btn_flash_is_pressed
                                    262 ;	main.c: 78: if(btn_load_is_pressed()) {
      008115 CD 83 8C         [ 4]  263 	call	_btn_load_is_pressed
      008118 4D               [ 1]  264 	tnz	a
      008119 27 15            [ 1]  265 	jreq	00119$
                                    266 ;	main.c: 82: char num = '1';
      00811B A6 31            [ 1]  267 	ld	a, #0x31
      00811D 6B 01            [ 1]  268 	ld	(0x01, sp), a
                                    269 ;	main.c: 83: uint8_t number = get_number_from_buttons();
      00811F CD 83 AA         [ 4]  270 	call	_get_number_from_buttons
                                    271 ;	main.c: 84: if(number == 0) {
      008122 4D               [ 1]  272 	tnz	a
      008123 26 04            [ 1]  273 	jrne	00116$
                                    274 ;	main.c: 85: num = '0';
      008125 A6 30            [ 1]  275 	ld	a, #0x30
      008127 6B 01            [ 1]  276 	ld	(0x01, sp), a
      008129                        277 00116$:
                                    278 ;	main.c: 88: uart_tx_byte_array(&num, 1);
      008129 96               [ 1]  279 	ldw	x, sp
      00812A 5C               [ 1]  280 	incw	x
      00812B A6 01            [ 1]  281 	ld	a, #0x01
      00812D CD 84 C1         [ 4]  282 	call	_uart_tx_byte_array
      008130                        283 00119$:
                                    284 ;	main.c: 90: }
      008130 5B 03            [ 2]  285 	addw	sp, #3
      008132 81               [ 4]  286 	ret
                                    287 ;	main.c: 92: extern void uart1_rx_handler(void) __interrupt(18) {
                                    288 ;	-----------------------------------------
                                    289 ;	 function uart1_rx_handler
                                    290 ;	-----------------------------------------
      008133                        291 _uart1_rx_handler:
      008133 4F               [ 1]  292 	clr	a
      008134 62               [ 2]  293 	div	x, a
      008135 88               [ 1]  294 	push	a
                                    295 ;	main.c: 93: rgb.r = 0;
      008136 35 00 00 01      [ 1]  296 	mov	_rgb+0, #0x00
                                    297 ;	main.c: 94: rgb.g = 0;
      00813A 35 00 00 02      [ 1]  298 	mov	_rgb+1, #0x00
                                    299 ;	main.c: 95: rgb.b = 0;
      00813E 35 00 00 03      [ 1]  300 	mov	_rgb+2, #0x00
                                    301 ;	main.c: 96: write_color_to_registers(&rgb);
      008142 AE 00 01         [ 2]  302 	ldw	x, #(_rgb+0)
      008145 CD 81 89         [ 4]  303 	call	_write_color_to_registers
                                    304 ;	main.c: 98: UART1_SR &= ~(1 << 5); // Clear interrupt
      008148 72 1B 52 30      [ 1]  305 	bres	0x5230, #5
                                    306 ;	main.c: 99: char byte = UART1_DR;
      00814C C6 52 31         [ 1]  307 	ld	a, 0x5231
      00814F 6B 01            [ 1]  308 	ld	(0x01, sp), a
                                    309 ;	main.c: 100: uart_tx_byte(&byte);
      008151 96               [ 1]  310 	ldw	x, sp
      008152 5C               [ 1]  311 	incw	x
      008153 CD 84 A9         [ 4]  312 	call	_uart_tx_byte
                                    313 ;	main.c: 101: }
      008156 84               [ 1]  314 	pop	a
      008157 80               [11]  315 	iret
                                    316 	.area CODE
                                    317 	.area CONST
                                    318 	.area INITIALIZER
                                    319 	.area CABS (ABS)
