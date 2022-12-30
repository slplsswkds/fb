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
                                     12 	.globl _write_color_to_eeprom
                                     13 	.globl _load_color_from_eeprom
                                     14 	.globl _smart_decrement
                                     15 	.globl _smart_increment
                                     16 	.globl _write_color_to_registers
                                     17 	.globl _tim2_init
                                     18 	.globl _btn_load_is_pressed
                                     19 	.globl _btn_b_minus_is_pressed
                                     20 	.globl _btn_g_minus_is_pressed
                                     21 	.globl _btn_r_minus_is_pressed
                                     22 	.globl _btn_b_plus_is_pressed
                                     23 	.globl _btn_g_plus_is_pressed
                                     24 	.globl _btn_r_plus_is_pressed
                                     25 	.globl _gpio_init
                                     26 	.globl _clk_init
                                     27 	.globl _rgb
                                     28 	.globl _button_hundler
                                     29 ;--------------------------------------------------------
                                     30 ; ram data
                                     31 ;--------------------------------------------------------
                                     32 	.area DATA
      000001                         33 _rgb::
      000001                         34 	.ds 3
                                     35 ;--------------------------------------------------------
                                     36 ; ram data
                                     37 ;--------------------------------------------------------
                                     38 	.area INITIALIZED
                                     39 ;--------------------------------------------------------
                                     40 ; Stack segment in internal ram
                                     41 ;--------------------------------------------------------
                                     42 	.area	SSEG
      000008                         43 __start__stack:
      000008                         44 	.ds	1
                                     45 
                                     46 ;--------------------------------------------------------
                                     47 ; absolute external ram data
                                     48 ;--------------------------------------------------------
                                     49 	.area DABS (ABS)
                                     50 
                                     51 ; default segment ordering for linker
                                     52 	.area HOME
                                     53 	.area GSINIT
                                     54 	.area GSFINAL
                                     55 	.area CONST
                                     56 	.area INITIALIZER
                                     57 	.area CODE
                                     58 
                                     59 ;--------------------------------------------------------
                                     60 ; interrupt vector
                                     61 ;--------------------------------------------------------
                                     62 	.area HOME
      008000                         63 __interrupt_vect:
      008000 82 00 80 07             64 	int s_GSINIT ; reset
                                     65 ;--------------------------------------------------------
                                     66 ; global & static initialisations
                                     67 ;--------------------------------------------------------
                                     68 	.area HOME
                                     69 	.area GSINIT
                                     70 	.area GSFINAL
                                     71 	.area GSINIT
      008007                         72 __sdcc_init_data:
                                     73 ; stm8_genXINIT() start
      008007 AE 00 05         [ 2]   74 	ldw x, #l_DATA
      00800A 27 07            [ 1]   75 	jreq	00002$
      00800C                         76 00001$:
      00800C 72 4F 00 00      [ 1]   77 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   78 	decw x
      008011 26 F9            [ 1]   79 	jrne	00001$
      008013                         80 00002$:
      008013 AE 00 02         [ 2]   81 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   82 	jreq	00004$
      008018                         83 00003$:
      008018 D6 80 23         [ 1]   84 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 05         [ 1]   85 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   86 	decw	x
      00801F 26 F7            [ 1]   87 	jrne	00003$
      008021                         88 00004$:
                                     89 ; stm8_genXINIT() end
                                     90 	.area GSFINAL
      008021 CC 80 04         [ 2]   91 	jp	__sdcc_program_startup
                                     92 ;--------------------------------------------------------
                                     93 ; Home
                                     94 ;--------------------------------------------------------
                                     95 	.area HOME
                                     96 	.area HOME
      008004                         97 __sdcc_program_startup:
      008004 CC 80 2E         [ 2]   98 	jp	_main
                                     99 ;	return from main will return to caller
                                    100 ;--------------------------------------------------------
                                    101 ; code
                                    102 ;--------------------------------------------------------
                                    103 	.area CODE
                                    104 ;	main.c: 19: static void delay(uint16_t t) {
                                    105 ;	-----------------------------------------
                                    106 ;	 function delay
                                    107 ;	-----------------------------------------
      008026                        108 _delay:
                                    109 ;	main.c: 20: while(t--) {};
      008026                        110 00101$:
      008026 90 93            [ 1]  111 	ldw	y, x
      008028 5A               [ 2]  112 	decw	x
      008029 90 5D            [ 2]  113 	tnzw	y
      00802B 26 F9            [ 1]  114 	jrne	00101$
                                    115 ;	main.c: 21: }
      00802D 81               [ 4]  116 	ret
                                    117 ;	main.c: 25: int main() {
                                    118 ;	-----------------------------------------
                                    119 ;	 function main
                                    120 ;	-----------------------------------------
      00802E                        121 _main:
                                    122 ;	main.c: 26: __asm sim __endasm; // Disable interrupts
      00802E 9B               [ 1]  123 	sim	
                                    124 ;	main.c: 28: clk_init();
      00802F CD 84 63         [ 4]  125 	call	_clk_init
                                    126 ;	main.c: 29: gpio_init();
      008032 CD 82 98         [ 4]  127 	call	_gpio_init
                                    128 ;	main.c: 30: tim2_init();
      008035 CD 82 2F         [ 4]  129 	call	_tim2_init
                                    130 ;	main.c: 36: __asm rim __endasm; // Enable interrupts
      008038 9A               [ 1]  131 	rim	
                                    132 ;	main.c: 40: rgb.r = 0;
      008039 35 00 00 01      [ 1]  133 	mov	_rgb+0, #0x00
                                    134 ;	main.c: 41: rgb.g = 0;
      00803D 35 00 00 02      [ 1]  135 	mov	_rgb+1, #0x00
                                    136 ;	main.c: 42: rgb.b = 0;
      008041 35 00 00 03      [ 1]  137 	mov	_rgb+2, #0x00
                                    138 ;	main.c: 48: load_color_from_eeprom(&rgb, 0);
      008045 4F               [ 1]  139 	clr	a
      008046 AE 00 01         [ 2]  140 	ldw	x, #(_rgb+0)
      008049 CD 81 B6         [ 4]  141 	call	_load_color_from_eeprom
                                    142 ;	main.c: 50: while(1) {
      00804C                        143 00102$:
                                    144 ;	main.c: 51: button_hundler(&rgb);
      00804C AE 00 01         [ 2]  145 	ldw	x, #(_rgb+0)
      00804F CD 80 5B         [ 4]  146 	call	_button_hundler
                                    147 ;	main.c: 52: write_color_to_registers(&rgb);
      008052 AE 00 01         [ 2]  148 	ldw	x, #(_rgb+0)
      008055 CD 81 6F         [ 4]  149 	call	_write_color_to_registers
      008058 20 F2            [ 2]  150 	jra	00102$
                                    151 ;	main.c: 54: }
      00805A 81               [ 4]  152 	ret
                                    153 ;	main.c: 56: void button_hundler(struct Color *color) {
                                    154 ;	-----------------------------------------
                                    155 ;	 function button_hundler
                                    156 ;	-----------------------------------------
      00805B                        157 _button_hundler:
      00805B 52 07            [ 2]  158 	sub	sp, #7
      00805D 1F 06            [ 2]  159 	ldw	(0x06, sp), x
                                    160 ;	main.c: 57: if(btn_r_plus_is_pressed()) {
      00805F CD 83 51         [ 4]  161 	call	_btn_r_plus_is_pressed
      008062 4D               [ 1]  162 	tnz	a
      008063 27 05            [ 1]  163 	jreq	00102$
                                    164 ;	main.c: 58: smart_increment(&color->r);
      008065 1E 06            [ 2]  165 	ldw	x, (0x06, sp)
      008067 CD 81 A6         [ 4]  166 	call	_smart_increment
      00806A                        167 00102$:
                                    168 ;	main.c: 61: if(btn_r_minus_is_pressed()) {
      00806A CD 83 93         [ 4]  169 	call	_btn_r_minus_is_pressed
      00806D 4D               [ 1]  170 	tnz	a
      00806E 27 05            [ 1]  171 	jreq	00104$
                                    172 ;	main.c: 62: smart_decrement(&color->r);
      008070 1E 06            [ 2]  173 	ldw	x, (0x06, sp)
      008072 CD 81 AF         [ 4]  174 	call	_smart_decrement
      008075                        175 00104$:
                                    176 ;	main.c: 65: if(btn_g_plus_is_pressed()) {
      008075 CD 83 67         [ 4]  177 	call	_btn_g_plus_is_pressed
                                    178 ;	main.c: 66: smart_increment(&color->g);
      008078 1E 06            [ 2]  179 	ldw	x, (0x06, sp)
      00807A 5C               [ 1]  180 	incw	x
                                    181 ;	main.c: 65: if(btn_g_plus_is_pressed()) {
      00807B 4D               [ 1]  182 	tnz	a
      00807C 27 05            [ 1]  183 	jreq	00106$
                                    184 ;	main.c: 66: smart_increment(&color->g);
      00807E 89               [ 2]  185 	pushw	x
      00807F CD 81 A6         [ 4]  186 	call	_smart_increment
      008082 85               [ 2]  187 	popw	x
      008083                        188 00106$:
                                    189 ;	main.c: 69: if(btn_g_minus_is_pressed()) {
      008083 89               [ 2]  190 	pushw	x
      008084 CD 83 A9         [ 4]  191 	call	_btn_g_minus_is_pressed
      008087 85               [ 2]  192 	popw	x
      008088 4D               [ 1]  193 	tnz	a
      008089 27 03            [ 1]  194 	jreq	00108$
                                    195 ;	main.c: 70: smart_decrement(&color->g);
      00808B CD 81 AF         [ 4]  196 	call	_smart_decrement
      00808E                        197 00108$:
                                    198 ;	main.c: 73: if(btn_b_plus_is_pressed()) {
      00808E CD 83 7D         [ 4]  199 	call	_btn_b_plus_is_pressed
                                    200 ;	main.c: 74: smart_increment(&color->b);
      008091 1E 06            [ 2]  201 	ldw	x, (0x06, sp)
      008093 5C               [ 1]  202 	incw	x
      008094 5C               [ 1]  203 	incw	x
                                    204 ;	main.c: 73: if(btn_b_plus_is_pressed()) {
      008095 4D               [ 1]  205 	tnz	a
      008096 27 05            [ 1]  206 	jreq	00110$
                                    207 ;	main.c: 74: smart_increment(&color->b);
      008098 89               [ 2]  208 	pushw	x
      008099 CD 81 A6         [ 4]  209 	call	_smart_increment
      00809C 85               [ 2]  210 	popw	x
      00809D                        211 00110$:
                                    212 ;	main.c: 77: if(btn_b_minus_is_pressed()) {
      00809D 89               [ 2]  213 	pushw	x
      00809E CD 83 BF         [ 4]  214 	call	_btn_b_minus_is_pressed
      0080A1 85               [ 2]  215 	popw	x
      0080A2 4D               [ 1]  216 	tnz	a
      0080A3 27 03            [ 1]  217 	jreq	00112$
                                    218 ;	main.c: 78: smart_decrement(&color->b);
      0080A5 CD 81 AF         [ 4]  219 	call	_smart_decrement
      0080A8                        220 00112$:
                                    221 ;	main.c: 88: if(btn_load_is_pressed()) {
      0080A8 CD 83 EB         [ 4]  222 	call	_btn_load_is_pressed
      0080AB 6B 05            [ 1]  223 	ld	(0x05, sp), a
      0080AD 26 03            [ 1]  224 	jrne	00225$
      0080AF CC 81 3B         [ 2]  225 	jp	00132$
      0080B2                        226 00225$:
                                    227 ;	main.c: 89: uint8_t counter = 0;
      0080B2 0F 04            [ 1]  228 	clr	(0x04, sp)
                                    229 ;	main.c: 90: while(counter < 10 && btn_load_is_pressed()) {
      0080B4                        230 00114$:
      0080B4 7B 04            [ 1]  231 	ld	a, (0x04, sp)
      0080B6 A1 0A            [ 1]  232 	cp	a, #0x0a
      0080B8 24 0F            [ 1]  233 	jrnc	00116$
      0080BA CD 83 EB         [ 4]  234 	call	_btn_load_is_pressed
      0080BD 4D               [ 1]  235 	tnz	a
      0080BE 27 09            [ 1]  236 	jreq	00116$
                                    237 ;	main.c: 91: delay(65535);
      0080C0 5F               [ 1]  238 	clrw	x
      0080C1 5A               [ 2]  239 	decw	x
      0080C2 CD 80 26         [ 4]  240 	call	_delay
                                    241 ;	main.c: 92: counter += 1;
      0080C5 0C 04            [ 1]  242 	inc	(0x04, sp)
      0080C7 20 EB            [ 2]  243 	jra	00114$
      0080C9                        244 00116$:
                                    245 ;	main.c: 96: load_color_from_eeprom(&rgb_buf, 0);        
      0080C9 4F               [ 1]  246 	clr	a
      0080CA 96               [ 1]  247 	ldw	x, sp
      0080CB 5C               [ 1]  248 	incw	x
      0080CC CD 81 B6         [ 4]  249 	call	_load_color_from_eeprom
                                    250 ;	main.c: 97: write_color_to_registers(&rgb_buf);
      0080CF 96               [ 1]  251 	ldw	x, sp
      0080D0 5C               [ 1]  252 	incw	x
      0080D1 CD 81 6F         [ 4]  253 	call	_write_color_to_registers
                                    254 ;	main.c: 98: delay(65535);
      0080D4 5F               [ 1]  255 	clrw	x
      0080D5 5A               [ 2]  256 	decw	x
      0080D6 CD 80 26         [ 4]  257 	call	_delay
                                    258 ;	main.c: 99: delay(65535);
      0080D9 5F               [ 1]  259 	clrw	x
      0080DA 5A               [ 2]  260 	decw	x
      0080DB CD 80 26         [ 4]  261 	call	_delay
                                    262 ;	main.c: 100: delay(65535);
      0080DE 5F               [ 1]  263 	clrw	x
      0080DF 5A               [ 2]  264 	decw	x
      0080E0 CD 80 26         [ 4]  265 	call	_delay
                                    266 ;	main.c: 103: while(counter < 23 && btn_load_is_pressed()) {
      0080E3                        267 00121$:
      0080E3 7B 04            [ 1]  268 	ld	a, (0x04, sp)
      0080E5 A1 17            [ 1]  269 	cp	a, #0x17
      0080E7 4F               [ 1]  270 	clr	a
      0080E8 49               [ 1]  271 	rlc	a
      0080E9 6B 05            [ 1]  272 	ld	(0x05, sp), a
      0080EB 27 26            [ 1]  273 	jreq	00123$
      0080ED CD 83 EB         [ 4]  274 	call	_btn_load_is_pressed
      0080F0 4D               [ 1]  275 	tnz	a
      0080F1 27 20            [ 1]  276 	jreq	00123$
                                    277 ;	main.c: 104: delay(65535);
      0080F3 5F               [ 1]  278 	clrw	x
      0080F4 5A               [ 2]  279 	decw	x
      0080F5 CD 80 26         [ 4]  280 	call	_delay
                                    281 ;	main.c: 105: delay(65535);
      0080F8 5F               [ 1]  282 	clrw	x
      0080F9 5A               [ 2]  283 	decw	x
      0080FA CD 80 26         [ 4]  284 	call	_delay
                                    285 ;	main.c: 106: if (counter % 2 == 0) {
      0080FD 7B 04            [ 1]  286 	ld	a, (0x04, sp)
      0080FF 44               [ 1]  287 	srl	a
      008100 25 07            [ 1]  288 	jrc	00118$
                                    289 ;	main.c: 107: write_color_to_registers(&rgb_buf);
      008102 96               [ 1]  290 	ldw	x, sp
      008103 5C               [ 1]  291 	incw	x
      008104 CD 81 6F         [ 4]  292 	call	_write_color_to_registers
      008107 20 06            [ 2]  293 	jra	00119$
      008109                        294 00118$:
                                    295 ;	main.c: 110: write_color_to_registers(&rgb);
      008109 AE 00 01         [ 2]  296 	ldw	x, #(_rgb+0)
      00810C CD 81 6F         [ 4]  297 	call	_write_color_to_registers
      00810F                        298 00119$:
                                    299 ;	main.c: 112: counter += 1;
      00810F 0C 04            [ 1]  300 	inc	(0x04, sp)
      008111 20 D0            [ 2]  301 	jra	00121$
      008113                        302 00123$:
                                    303 ;	main.c: 115: if(counter > 10 && counter < 23) {
      008113 7B 04            [ 1]  304 	ld	a, (0x04, sp)
      008115 A1 0A            [ 1]  305 	cp	a, #0x0a
      008117 23 15            [ 2]  306 	jrule	00127$
      008119 0D 05            [ 1]  307 	tnz	(0x05, sp)
      00811B 27 11            [ 1]  308 	jreq	00127$
                                    309 ;	main.c: 116: rgb = rgb_buf;
      00811D 4B 03            [ 1]  310 	push	#0x03
      00811F 4B 00            [ 1]  311 	push	#0x00
      008121 96               [ 1]  312 	ldw	x, sp
      008122 1C 00 03         [ 2]  313 	addw	x, #3
      008125 89               [ 2]  314 	pushw	x
      008126 AE 00 01         [ 2]  315 	ldw	x, #(_rgb+0)
      008129 CD 8D A2         [ 4]  316 	call	___memcpy
      00812C 20 0D            [ 2]  317 	jra	00132$
      00812E                        318 00127$:
                                    319 ;	main.c: 118: else if (counter == 23) { 
      00812E 7B 04            [ 1]  320 	ld	a, (0x04, sp)
      008130 A1 17            [ 1]  321 	cp	a, #0x17
      008132 26 07            [ 1]  322 	jrne	00132$
                                    323 ;	main.c: 119: write_color_to_eeprom(&rgb, 0);        
      008134 4F               [ 1]  324 	clr	a
      008135 AE 00 01         [ 2]  325 	ldw	x, #(_rgb+0)
      008138 CD 81 FE         [ 4]  326 	call	_write_color_to_eeprom
      00813B                        327 00132$:
                                    328 ;	main.c: 122: }
      00813B 5B 07            [ 2]  329 	addw	sp, #7
      00813D 81               [ 4]  330 	ret
                                    331 	.area CODE
                                    332 	.area CONST
                                    333 	.area INITIALIZER
                                    334 	.area CABS (ABS)
