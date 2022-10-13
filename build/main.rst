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
                                     15 	.globl _eeprom_write
                                     16 	.globl _load_color_from_eeprom
                                     17 	.globl _smart_decrement
                                     18 	.globl _smart_increment
                                     19 	.globl _write_color_to_registers
                                     20 	.globl _tim2_init
                                     21 	.globl _get_number_from_buttons
                                     22 	.globl _btn_load_is_pressed
                                     23 	.globl _btn_b_minus_is_pressed
                                     24 	.globl _btn_g_minus_is_pressed
                                     25 	.globl _btn_r_minus_is_pressed
                                     26 	.globl _btn_b_plus_is_pressed
                                     27 	.globl _btn_g_plus_is_pressed
                                     28 	.globl _btn_r_plus_is_pressed
                                     29 	.globl _gpio_init
                                     30 	.globl _clk_init
                                     31 	.globl _rgb
                                     32 	.globl _button_hundler
                                     33 ;--------------------------------------------------------
                                     34 ; ram data
                                     35 ;--------------------------------------------------------
                                     36 	.area DATA
      000001                         37 _rgb::
      000001                         38 	.ds 3
                                     39 ;--------------------------------------------------------
                                     40 ; ram data
                                     41 ;--------------------------------------------------------
                                     42 	.area INITIALIZED
                                     43 ;--------------------------------------------------------
                                     44 ; Stack segment in internal ram
                                     45 ;--------------------------------------------------------
                                     46 	.area	SSEG
      000008                         47 __start__stack:
      000008                         48 	.ds	1
                                     49 
                                     50 ;--------------------------------------------------------
                                     51 ; absolute external ram data
                                     52 ;--------------------------------------------------------
                                     53 	.area DABS (ABS)
                                     54 
                                     55 ; default segment ordering for linker
                                     56 	.area HOME
                                     57 	.area GSINIT
                                     58 	.area GSFINAL
                                     59 	.area CONST
                                     60 	.area INITIALIZER
                                     61 	.area CODE
                                     62 
                                     63 ;--------------------------------------------------------
                                     64 ; interrupt vector
                                     65 ;--------------------------------------------------------
                                     66 	.area HOME
      008000                         67 __interrupt_vect:
      008000 82 00 80 57             68 	int s_GSINIT ; reset
      008004 82 00 00 00             69 	int 0x000000 ; trap
      008008 82 00 00 00             70 	int 0x000000 ; int0
      00800C 82 00 00 00             71 	int 0x000000 ; int1
      008010 82 00 00 00             72 	int 0x000000 ; int2
      008014 82 00 00 00             73 	int 0x000000 ; int3
      008018 82 00 00 00             74 	int 0x000000 ; int4
      00801C 82 00 00 00             75 	int 0x000000 ; int5
      008020 82 00 00 00             76 	int 0x000000 ; int6
      008024 82 00 00 00             77 	int 0x000000 ; int7
      008028 82 00 00 00             78 	int 0x000000 ; int8
      00802C 82 00 00 00             79 	int 0x000000 ; int9
      008030 82 00 00 00             80 	int 0x000000 ; int10
      008034 82 00 00 00             81 	int 0x000000 ; int11
      008038 82 00 00 00             82 	int 0x000000 ; int12
      00803C 82 00 00 00             83 	int 0x000000 ; int13
      008040 82 00 00 00             84 	int 0x000000 ; int14
      008044 82 00 00 00             85 	int 0x000000 ; int15
      008048 82 00 00 00             86 	int 0x000000 ; int16
      00804C 82 00 00 00             87 	int 0x000000 ; int17
      008050 82 00 81 3B             88 	int _uart1_rx_handler ; int18
                                     89 ;--------------------------------------------------------
                                     90 ; global & static initialisations
                                     91 ;--------------------------------------------------------
                                     92 	.area HOME
                                     93 	.area GSINIT
                                     94 	.area GSFINAL
                                     95 	.area GSINIT
      008057                         96 __sdcc_init_data:
                                     97 ; stm8_genXINIT() start
      008057 AE 00 05         [ 2]   98 	ldw x, #l_DATA
      00805A 27 07            [ 1]   99 	jreq	00002$
      00805C                        100 00001$:
      00805C 72 4F 00 00      [ 1]  101 	clr (s_DATA - 1, x)
      008060 5A               [ 2]  102 	decw x
      008061 26 F9            [ 1]  103 	jrne	00001$
      008063                        104 00002$:
      008063 AE 00 02         [ 2]  105 	ldw	x, #l_INITIALIZER
      008066 27 09            [ 1]  106 	jreq	00004$
      008068                        107 00003$:
      008068 D6 80 73         [ 1]  108 	ld	a, (s_INITIALIZER - 1, x)
      00806B D7 00 05         [ 1]  109 	ld	(s_INITIALIZED - 1, x), a
      00806E 5A               [ 2]  110 	decw	x
      00806F 26 F7            [ 1]  111 	jrne	00003$
      008071                        112 00004$:
                                    113 ; stm8_genXINIT() end
                                    114 	.area GSFINAL
      008071 CC 80 54         [ 2]  115 	jp	__sdcc_program_startup
                                    116 ;--------------------------------------------------------
                                    117 ; Home
                                    118 ;--------------------------------------------------------
                                    119 	.area HOME
                                    120 	.area HOME
      008054                        121 __sdcc_program_startup:
      008054 CC 80 7E         [ 2]  122 	jp	_main
                                    123 ;	return from main will return to caller
                                    124 ;--------------------------------------------------------
                                    125 ; code
                                    126 ;--------------------------------------------------------
                                    127 	.area CODE
                                    128 ;	main.c: 19: static void delay(uint16_t t) {
                                    129 ;	-----------------------------------------
                                    130 ;	 function delay
                                    131 ;	-----------------------------------------
      008076                        132 _delay:
                                    133 ;	main.c: 20: while(t--) {};
      008076                        134 00101$:
      008076 90 93            [ 1]  135 	ldw	y, x
      008078 5A               [ 2]  136 	decw	x
      008079 90 5D            [ 2]  137 	tnzw	y
      00807B 26 F9            [ 1]  138 	jrne	00101$
                                    139 ;	main.c: 21: }
      00807D 81               [ 4]  140 	ret
                                    141 ;	main.c: 25: int main() {
                                    142 ;	-----------------------------------------
                                    143 ;	 function main
                                    144 ;	-----------------------------------------
      00807E                        145 _main:
      00807E 52 05            [ 2]  146 	sub	sp, #5
                                    147 ;	main.c: 26: __asm sim __endasm; // Disable interrupts
      008080 9B               [ 1]  148 	sim	
                                    149 ;	main.c: 28: clk_init();
      008081 CD 84 54         [ 4]  150 	call	_clk_init
                                    151 ;	main.c: 29: gpio_init();
      008084 CD 82 89         [ 4]  152 	call	_gpio_init
                                    153 ;	main.c: 30: tim2_init();
      008087 CD 82 20         [ 4]  154 	call	_tim2_init
                                    155 ;	main.c: 31: uart_init();
      00808A CD 84 DA         [ 4]  156 	call	_uart_init
                                    157 ;	main.c: 33: char banner[5] = {'1', '2', '3', '4', '5'};
      00808D 96               [ 1]  158 	ldw	x, sp
      00808E 5C               [ 1]  159 	incw	x
      00808F A6 31            [ 1]  160 	ld	a, #0x31
      008091 F7               [ 1]  161 	ld	(x), a
      008092 A6 32            [ 1]  162 	ld	a, #0x32
      008094 6B 02            [ 1]  163 	ld	(0x02, sp), a
      008096 A6 33            [ 1]  164 	ld	a, #0x33
      008098 6B 03            [ 1]  165 	ld	(0x03, sp), a
      00809A A6 34            [ 1]  166 	ld	a, #0x34
      00809C 6B 04            [ 1]  167 	ld	(0x04, sp), a
      00809E A6 35            [ 1]  168 	ld	a, #0x35
      0080A0 6B 05            [ 1]  169 	ld	(0x05, sp), a
                                    170 ;	main.c: 34: uart_tx_byte_array(banner, 5);
      0080A2 A6 05            [ 1]  171 	ld	a, #0x05
      0080A4 CD 85 49         [ 4]  172 	call	_uart_tx_byte_array
                                    173 ;	main.c: 36: __asm rim __endasm; // Enable interrupts
      0080A7 9A               [ 1]  174 	rim	
                                    175 ;	main.c: 40: rgb.r = 0;
      0080A8 35 00 00 01      [ 1]  176 	mov	_rgb+0, #0x00
                                    177 ;	main.c: 41: rgb.g = 0;
      0080AC 35 00 00 02      [ 1]  178 	mov	_rgb+1, #0x00
                                    179 ;	main.c: 42: rgb.b = 0;
      0080B0 35 00 00 03      [ 1]  180 	mov	_rgb+2, #0x00
                                    181 ;	main.c: 44: eeprom_write(0, 0x0F);
      0080B4 A6 0F            [ 1]  182 	ld	a, #0x0f
      0080B6 5F               [ 1]  183 	clrw	x
      0080B7 CD 84 8C         [ 4]  184 	call	_eeprom_write
                                    185 ;	main.c: 45: eeprom_write(1, 0x00);
      0080BA 4F               [ 1]  186 	clr	a
      0080BB 5F               [ 1]  187 	clrw	x
      0080BC 5C               [ 1]  188 	incw	x
      0080BD CD 84 8C         [ 4]  189 	call	_eeprom_write
                                    190 ;	main.c: 46: eeprom_write(2, 0xFF);
      0080C0 A6 FF            [ 1]  191 	ld	a, #0xff
      0080C2 AE 00 02         [ 2]  192 	ldw	x, #0x0002
      0080C5 CD 84 8C         [ 4]  193 	call	_eeprom_write
                                    194 ;	main.c: 48: load_color_from_eeprom(&rgb, 0);
      0080C8 4F               [ 1]  195 	clr	a
      0080C9 AE 00 01         [ 2]  196 	ldw	x, #(_rgb+0)
      0080CC CD 81 D8         [ 4]  197 	call	_load_color_from_eeprom
                                    198 ;	main.c: 50: while(1) {
      0080CF                        199 00102$:
                                    200 ;	main.c: 51: button_hundler(&rgb);
      0080CF AE 00 01         [ 2]  201 	ldw	x, #(_rgb+0)
      0080D2 CD 80 E0         [ 4]  202 	call	_button_hundler
                                    203 ;	main.c: 52: write_color_to_registers(&rgb);
      0080D5 AE 00 01         [ 2]  204 	ldw	x, #(_rgb+0)
      0080D8 CD 81 91         [ 4]  205 	call	_write_color_to_registers
      0080DB 20 F2            [ 2]  206 	jra	00102$
                                    207 ;	main.c: 54: }
      0080DD 5B 05            [ 2]  208 	addw	sp, #5
      0080DF 81               [ 4]  209 	ret
                                    210 ;	main.c: 56: void button_hundler(struct Color *color) {
                                    211 ;	-----------------------------------------
                                    212 ;	 function button_hundler
                                    213 ;	-----------------------------------------
      0080E0                        214 _button_hundler:
      0080E0 52 02            [ 2]  215 	sub	sp, #2
      0080E2 1F 01            [ 2]  216 	ldw	(0x01, sp), x
                                    217 ;	main.c: 57: if(btn_r_plus_is_pressed()) {
      0080E4 CD 83 42         [ 4]  218 	call	_btn_r_plus_is_pressed
      0080E7 4D               [ 1]  219 	tnz	a
      0080E8 27 05            [ 1]  220 	jreq	00102$
                                    221 ;	main.c: 58: smart_increment(&color->r);
      0080EA 1E 01            [ 2]  222 	ldw	x, (0x01, sp)
      0080EC CD 81 C8         [ 4]  223 	call	_smart_increment
      0080EF                        224 00102$:
                                    225 ;	main.c: 61: if(btn_r_minus_is_pressed()) {
      0080EF CD 83 84         [ 4]  226 	call	_btn_r_minus_is_pressed
      0080F2 4D               [ 1]  227 	tnz	a
      0080F3 27 05            [ 1]  228 	jreq	00104$
                                    229 ;	main.c: 62: smart_decrement(&color->r);
      0080F5 1E 01            [ 2]  230 	ldw	x, (0x01, sp)
      0080F7 CD 81 D1         [ 4]  231 	call	_smart_decrement
      0080FA                        232 00104$:
                                    233 ;	main.c: 65: if(btn_g_plus_is_pressed()) {
      0080FA CD 83 58         [ 4]  234 	call	_btn_g_plus_is_pressed
                                    235 ;	main.c: 66: smart_increment(&color->g);
      0080FD 1E 01            [ 2]  236 	ldw	x, (0x01, sp)
      0080FF 5C               [ 1]  237 	incw	x
                                    238 ;	main.c: 65: if(btn_g_plus_is_pressed()) {
      008100 4D               [ 1]  239 	tnz	a
      008101 27 05            [ 1]  240 	jreq	00106$
                                    241 ;	main.c: 66: smart_increment(&color->g);
      008103 89               [ 2]  242 	pushw	x
      008104 CD 81 C8         [ 4]  243 	call	_smart_increment
      008107 85               [ 2]  244 	popw	x
      008108                        245 00106$:
                                    246 ;	main.c: 69: if(btn_g_minus_is_pressed()) {
      008108 89               [ 2]  247 	pushw	x
      008109 CD 83 9A         [ 4]  248 	call	_btn_g_minus_is_pressed
      00810C 85               [ 2]  249 	popw	x
      00810D 4D               [ 1]  250 	tnz	a
      00810E 27 03            [ 1]  251 	jreq	00108$
                                    252 ;	main.c: 70: smart_decrement(&color->g);
      008110 CD 81 D1         [ 4]  253 	call	_smart_decrement
      008113                        254 00108$:
                                    255 ;	main.c: 73: if(btn_b_plus_is_pressed()) {
      008113 CD 83 6E         [ 4]  256 	call	_btn_b_plus_is_pressed
                                    257 ;	main.c: 74: smart_increment(&color->b);
      008116 1E 01            [ 2]  258 	ldw	x, (0x01, sp)
      008118 5C               [ 1]  259 	incw	x
      008119 5C               [ 1]  260 	incw	x
                                    261 ;	main.c: 73: if(btn_b_plus_is_pressed()) {
      00811A 4D               [ 1]  262 	tnz	a
      00811B 27 05            [ 1]  263 	jreq	00110$
                                    264 ;	main.c: 74: smart_increment(&color->b);
      00811D 89               [ 2]  265 	pushw	x
      00811E CD 81 C8         [ 4]  266 	call	_smart_increment
      008121 85               [ 2]  267 	popw	x
      008122                        268 00110$:
                                    269 ;	main.c: 77: if(btn_b_minus_is_pressed()) {
      008122 89               [ 2]  270 	pushw	x
      008123 CD 83 B0         [ 4]  271 	call	_btn_b_minus_is_pressed
      008126 85               [ 2]  272 	popw	x
      008127 4D               [ 1]  273 	tnz	a
      008128 27 03            [ 1]  274 	jreq	00112$
                                    275 ;	main.c: 78: smart_decrement(&color->b);
      00812A CD 81 D1         [ 4]  276 	call	_smart_decrement
      00812D                        277 00112$:
                                    278 ;	main.c: 84: if(btn_load_is_pressed()) {
      00812D CD 83 DC         [ 4]  279 	call	_btn_load_is_pressed
      008130 4D               [ 1]  280 	tnz	a
      008131 27 05            [ 1]  281 	jreq	00115$
                                    282 ;	main.c: 85: uint8_t cell_number = get_number_from_buttons();
      008133 5B 02            [ 2]  283 	addw	sp, #2
      008135 CC 83 FA         [ 2]  284 	jp	_get_number_from_buttons
                                    285 ;	main.c: 86: if(cell_number == 0) {
      008138                        286 00115$:
                                    287 ;	main.c: 93: }
      008138 5B 02            [ 2]  288 	addw	sp, #2
      00813A 81               [ 4]  289 	ret
                                    290 ;	main.c: 95: extern void uart1_rx_handler(void) __interrupt(18) {
                                    291 ;	-----------------------------------------
                                    292 ;	 function uart1_rx_handler
                                    293 ;	-----------------------------------------
      00813B                        294 _uart1_rx_handler:
      00813B 4F               [ 1]  295 	clr	a
      00813C 62               [ 2]  296 	div	x, a
      00813D 88               [ 1]  297 	push	a
                                    298 ;	main.c: 96: rgb.r = 0;
      00813E 35 00 00 01      [ 1]  299 	mov	_rgb+0, #0x00
                                    300 ;	main.c: 97: rgb.g = 0;
      008142 35 00 00 02      [ 1]  301 	mov	_rgb+1, #0x00
                                    302 ;	main.c: 98: rgb.b = 0;
      008146 35 00 00 03      [ 1]  303 	mov	_rgb+2, #0x00
                                    304 ;	main.c: 99: write_color_to_registers(&rgb);
      00814A AE 00 01         [ 2]  305 	ldw	x, #(_rgb+0)
      00814D CD 81 91         [ 4]  306 	call	_write_color_to_registers
                                    307 ;	main.c: 101: UART1_SR &= ~(1 << 5); // Clear interrupt
      008150 72 1B 52 30      [ 1]  308 	bres	0x5230, #5
                                    309 ;	main.c: 102: char byte = UART1_DR;
      008154 C6 52 31         [ 1]  310 	ld	a, 0x5231
      008157 6B 01            [ 1]  311 	ld	(0x01, sp), a
                                    312 ;	main.c: 103: uart_tx_byte(&byte);
      008159 96               [ 1]  313 	ldw	x, sp
      00815A 5C               [ 1]  314 	incw	x
      00815B CD 85 31         [ 4]  315 	call	_uart_tx_byte
                                    316 ;	main.c: 104: }
      00815E 84               [ 1]  317 	pop	a
      00815F 80               [11]  318 	iret
                                    319 	.area CODE
                                    320 	.area CONST
                                    321 	.area INITIALIZER
                                    322 	.area CABS (ABS)
