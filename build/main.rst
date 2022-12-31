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
                                     18 	.globl _btn_brightness_minus_is_pressed
                                     19 	.globl _btn_brightness_plus_is_pressed
                                     20 	.globl _btn_load_is_pressed
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
      000008                         45 __start__stack:
      000008                         46 	.ds	1
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
      008000 82 00 80 07             66 	int s_GSINIT ; reset
                                     67 ;--------------------------------------------------------
                                     68 ; global & static initialisations
                                     69 ;--------------------------------------------------------
                                     70 	.area HOME
                                     71 	.area GSINIT
                                     72 	.area GSFINAL
                                     73 	.area GSINIT
      008007                         74 __sdcc_init_data:
                                     75 ; stm8_genXINIT() start
      008007 AE 00 05         [ 2]   76 	ldw x, #l_DATA
      00800A 27 07            [ 1]   77 	jreq	00002$
      00800C                         78 00001$:
      00800C 72 4F 00 00      [ 1]   79 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   80 	decw x
      008011 26 F9            [ 1]   81 	jrne	00001$
      008013                         82 00002$:
      008013 AE 00 02         [ 2]   83 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   84 	jreq	00004$
      008018                         85 00003$:
      008018 D6 80 23         [ 1]   86 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 05         [ 1]   87 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   88 	decw	x
      00801F 26 F7            [ 1]   89 	jrne	00003$
      008021                         90 00004$:
                                     91 ; stm8_genXINIT() end
                                     92 	.area GSFINAL
      008021 CC 80 04         [ 2]   93 	jp	__sdcc_program_startup
                                     94 ;--------------------------------------------------------
                                     95 ; Home
                                     96 ;--------------------------------------------------------
                                     97 	.area HOME
                                     98 	.area HOME
      008004                         99 __sdcc_program_startup:
      008004 CC 80 2E         [ 2]  100 	jp	_main
                                    101 ;	return from main will return to caller
                                    102 ;--------------------------------------------------------
                                    103 ; code
                                    104 ;--------------------------------------------------------
                                    105 	.area CODE
                                    106 ;	main.c: 19: static void delay(uint16_t t) {
                                    107 ;	-----------------------------------------
                                    108 ;	 function delay
                                    109 ;	-----------------------------------------
      008026                        110 _delay:
                                    111 ;	main.c: 20: while(t--) {};
      008026                        112 00101$:
      008026 90 93            [ 1]  113 	ldw	y, x
      008028 5A               [ 2]  114 	decw	x
      008029 90 5D            [ 2]  115 	tnzw	y
      00802B 26 F9            [ 1]  116 	jrne	00101$
                                    117 ;	main.c: 21: }
      00802D 81               [ 4]  118 	ret
                                    119 ;	main.c: 25: int main() {
                                    120 ;	-----------------------------------------
                                    121 ;	 function main
                                    122 ;	-----------------------------------------
      00802E                        123 _main:
                                    124 ;	main.c: 26: __asm sim __endasm; // Disable interrupts
      00802E 9B               [ 1]  125 	sim	
                                    126 ;	main.c: 28: clk_init();
      00802F CD 84 DB         [ 4]  127 	call	_clk_init
                                    128 ;	main.c: 29: gpio_init();
      008032 CD 82 CC         [ 4]  129 	call	_gpio_init
                                    130 ;	main.c: 30: tim2_init();
      008035 CD 82 63         [ 4]  131 	call	_tim2_init
                                    132 ;	main.c: 36: __asm rim __endasm; // Enable interrupts
      008038 9A               [ 1]  133 	rim	
                                    134 ;	main.c: 40: rgb.r = 0;
      008039 35 00 00 01      [ 1]  135 	mov	_rgb+0, #0x00
                                    136 ;	main.c: 41: rgb.g = 0;
      00803D 35 00 00 02      [ 1]  137 	mov	_rgb+1, #0x00
                                    138 ;	main.c: 42: rgb.b = 0;
      008041 35 00 00 03      [ 1]  139 	mov	_rgb+2, #0x00
                                    140 ;	main.c: 48: load_color_from_eeprom(&rgb, 0);
      008045 4F               [ 1]  141 	clr	a
      008046 AE 00 01         [ 2]  142 	ldw	x, #(_rgb+0)
      008049 CD 81 EA         [ 4]  143 	call	_load_color_from_eeprom
                                    144 ;	main.c: 50: while(1) {
      00804C                        145 00102$:
                                    146 ;	main.c: 51: button_hundler(&rgb);
      00804C AE 00 01         [ 2]  147 	ldw	x, #(_rgb+0)
      00804F CD 80 5B         [ 4]  148 	call	_button_hundler
                                    149 ;	main.c: 52: write_color_to_registers(&rgb);
      008052 AE 00 01         [ 2]  150 	ldw	x, #(_rgb+0)
      008055 CD 81 A3         [ 4]  151 	call	_write_color_to_registers
      008058 20 F2            [ 2]  152 	jra	00102$
                                    153 ;	main.c: 54: }
      00805A 81               [ 4]  154 	ret
                                    155 ;	main.c: 56: void button_hundler(struct Color *color) {
                                    156 ;	-----------------------------------------
                                    157 ;	 function button_hundler
                                    158 ;	-----------------------------------------
      00805B                        159 _button_hundler:
      00805B 52 09            [ 2]  160 	sub	sp, #9
      00805D 1F 08            [ 2]  161 	ldw	(0x08, sp), x
                                    162 ;	main.c: 57: if(btn_r_plus_is_pressed()) {
      00805F CD 83 9D         [ 4]  163 	call	_btn_r_plus_is_pressed
      008062 4D               [ 1]  164 	tnz	a
      008063 27 05            [ 1]  165 	jreq	00102$
                                    166 ;	main.c: 58: smart_increment(&color->r);
      008065 1E 08            [ 2]  167 	ldw	x, (0x08, sp)
      008067 CD 81 DA         [ 4]  168 	call	_smart_increment
      00806A                        169 00102$:
                                    170 ;	main.c: 61: if(btn_r_minus_is_pressed()) {
      00806A CD 83 DF         [ 4]  171 	call	_btn_r_minus_is_pressed
      00806D 4D               [ 1]  172 	tnz	a
      00806E 27 05            [ 1]  173 	jreq	00104$
                                    174 ;	main.c: 62: smart_decrement(&color->r);
      008070 1E 08            [ 2]  175 	ldw	x, (0x08, sp)
      008072 CD 81 E3         [ 4]  176 	call	_smart_decrement
      008075                        177 00104$:
                                    178 ;	main.c: 65: if(btn_g_plus_is_pressed()) {
      008075 CD 83 B3         [ 4]  179 	call	_btn_g_plus_is_pressed
                                    180 ;	main.c: 66: smart_increment(&color->g);
      008078 1E 08            [ 2]  181 	ldw	x, (0x08, sp)
      00807A 5C               [ 1]  182 	incw	x
      00807B 1F 01            [ 2]  183 	ldw	(0x01, sp), x
                                    184 ;	main.c: 65: if(btn_g_plus_is_pressed()) {
      00807D 4D               [ 1]  185 	tnz	a
      00807E 27 05            [ 1]  186 	jreq	00106$
                                    187 ;	main.c: 66: smart_increment(&color->g);
      008080 1E 01            [ 2]  188 	ldw	x, (0x01, sp)
      008082 CD 81 DA         [ 4]  189 	call	_smart_increment
      008085                        190 00106$:
                                    191 ;	main.c: 69: if(btn_g_minus_is_pressed()) {
      008085 CD 83 F5         [ 4]  192 	call	_btn_g_minus_is_pressed
      008088 4D               [ 1]  193 	tnz	a
      008089 27 05            [ 1]  194 	jreq	00108$
                                    195 ;	main.c: 70: smart_decrement(&color->g);
      00808B 1E 01            [ 2]  196 	ldw	x, (0x01, sp)
      00808D CD 81 E3         [ 4]  197 	call	_smart_decrement
      008090                        198 00108$:
                                    199 ;	main.c: 73: if(btn_b_plus_is_pressed()) {
      008090 CD 83 C9         [ 4]  200 	call	_btn_b_plus_is_pressed
                                    201 ;	main.c: 74: smart_increment(&color->b);
      008093 1E 08            [ 2]  202 	ldw	x, (0x08, sp)
      008095 5C               [ 1]  203 	incw	x
      008096 5C               [ 1]  204 	incw	x
      008097 1F 06            [ 2]  205 	ldw	(0x06, sp), x
                                    206 ;	main.c: 73: if(btn_b_plus_is_pressed()) {
      008099 4D               [ 1]  207 	tnz	a
      00809A 27 05            [ 1]  208 	jreq	00110$
                                    209 ;	main.c: 74: smart_increment(&color->b);
      00809C 1E 06            [ 2]  210 	ldw	x, (0x06, sp)
      00809E CD 81 DA         [ 4]  211 	call	_smart_increment
      0080A1                        212 00110$:
                                    213 ;	main.c: 77: if(btn_b_minus_is_pressed()) {
      0080A1 CD 84 0B         [ 4]  214 	call	_btn_b_minus_is_pressed
      0080A4 4D               [ 1]  215 	tnz	a
      0080A5 27 05            [ 1]  216 	jreq	00112$
                                    217 ;	main.c: 78: smart_decrement(&color->b);
      0080A7 1E 06            [ 2]  218 	ldw	x, (0x06, sp)
      0080A9 CD 81 E3         [ 4]  219 	call	_smart_decrement
      0080AC                        220 00112$:
                                    221 ;	main.c: 81: if(btn_brightness_plus_is_pressed()) {
      0080AC CD 84 4D         [ 4]  222 	call	_btn_brightness_plus_is_pressed
      0080AF 4D               [ 1]  223 	tnz	a
      0080B0 27 0F            [ 1]  224 	jreq	00114$
                                    225 ;	main.c: 82: smart_increment(&color->r);
      0080B2 1E 08            [ 2]  226 	ldw	x, (0x08, sp)
      0080B4 CD 81 DA         [ 4]  227 	call	_smart_increment
                                    228 ;	main.c: 83: smart_increment(&color->g);
      0080B7 1E 01            [ 2]  229 	ldw	x, (0x01, sp)
      0080B9 CD 81 DA         [ 4]  230 	call	_smart_increment
                                    231 ;	main.c: 84: smart_increment(&color->b);
      0080BC 1E 06            [ 2]  232 	ldw	x, (0x06, sp)
      0080BE CD 81 DA         [ 4]  233 	call	_smart_increment
      0080C1                        234 00114$:
                                    235 ;	main.c: 87: if(btn_brightness_minus_is_pressed()) {
      0080C1 CD 84 63         [ 4]  236 	call	_btn_brightness_minus_is_pressed
      0080C4 4D               [ 1]  237 	tnz	a
      0080C5 27 0F            [ 1]  238 	jreq	00116$
                                    239 ;	main.c: 88: smart_decrement(&color->r);
      0080C7 1E 08            [ 2]  240 	ldw	x, (0x08, sp)
      0080C9 CD 81 E3         [ 4]  241 	call	_smart_decrement
                                    242 ;	main.c: 89: smart_decrement(&color->g);
      0080CC 1E 01            [ 2]  243 	ldw	x, (0x01, sp)
      0080CE CD 81 E3         [ 4]  244 	call	_smart_decrement
                                    245 ;	main.c: 90: smart_decrement(&color->b);
      0080D1 1E 06            [ 2]  246 	ldw	x, (0x06, sp)
      0080D3 CD 81 E3         [ 4]  247 	call	_smart_decrement
      0080D6                        248 00116$:
                                    249 ;	main.c: 100: if(btn_load_is_pressed()) {
      0080D6 CD 84 37         [ 4]  250 	call	_btn_load_is_pressed
      0080D9 6B 07            [ 1]  251 	ld	(0x07, sp), a
      0080DB 26 03            [ 1]  252 	jrne	00241$
      0080DD CC 81 6F         [ 2]  253 	jp	00136$
      0080E0                        254 00241$:
                                    255 ;	main.c: 101: uint8_t counter = 0;
      0080E0 0F 06            [ 1]  256 	clr	(0x06, sp)
                                    257 ;	main.c: 102: while(counter < 10 && btn_load_is_pressed()) {
      0080E2                        258 00118$:
      0080E2 7B 06            [ 1]  259 	ld	a, (0x06, sp)
      0080E4 A1 0A            [ 1]  260 	cp	a, #0x0a
      0080E6 24 0F            [ 1]  261 	jrnc	00120$
      0080E8 CD 84 37         [ 4]  262 	call	_btn_load_is_pressed
      0080EB 4D               [ 1]  263 	tnz	a
      0080EC 27 09            [ 1]  264 	jreq	00120$
                                    265 ;	main.c: 103: delay(65535);
      0080EE 5F               [ 1]  266 	clrw	x
      0080EF 5A               [ 2]  267 	decw	x
      0080F0 CD 80 26         [ 4]  268 	call	_delay
                                    269 ;	main.c: 104: counter += 1;
      0080F3 0C 06            [ 1]  270 	inc	(0x06, sp)
      0080F5 20 EB            [ 2]  271 	jra	00118$
      0080F7                        272 00120$:
                                    273 ;	main.c: 108: load_color_from_eeprom(&rgb_buf, 0);        
      0080F7 4F               [ 1]  274 	clr	a
      0080F8 96               [ 1]  275 	ldw	x, sp
      0080F9 1C 00 03         [ 2]  276 	addw	x, #3
      0080FC CD 81 EA         [ 4]  277 	call	_load_color_from_eeprom
                                    278 ;	main.c: 109: write_color_to_registers(&rgb_buf);
      0080FF 96               [ 1]  279 	ldw	x, sp
      008100 1C 00 03         [ 2]  280 	addw	x, #3
      008103 CD 81 A3         [ 4]  281 	call	_write_color_to_registers
                                    282 ;	main.c: 110: delay(65535);
      008106 5F               [ 1]  283 	clrw	x
      008107 5A               [ 2]  284 	decw	x
      008108 CD 80 26         [ 4]  285 	call	_delay
                                    286 ;	main.c: 111: delay(65535);
      00810B 5F               [ 1]  287 	clrw	x
      00810C 5A               [ 2]  288 	decw	x
      00810D CD 80 26         [ 4]  289 	call	_delay
                                    290 ;	main.c: 112: delay(65535);
      008110 5F               [ 1]  291 	clrw	x
      008111 5A               [ 2]  292 	decw	x
      008112 CD 80 26         [ 4]  293 	call	_delay
                                    294 ;	main.c: 115: while(counter < 23 && btn_load_is_pressed()) {
      008115                        295 00125$:
      008115 7B 06            [ 1]  296 	ld	a, (0x06, sp)
      008117 A1 17            [ 1]  297 	cp	a, #0x17
      008119 4F               [ 1]  298 	clr	a
      00811A 49               [ 1]  299 	rlc	a
      00811B 6B 07            [ 1]  300 	ld	(0x07, sp), a
      00811D 27 28            [ 1]  301 	jreq	00127$
      00811F CD 84 37         [ 4]  302 	call	_btn_load_is_pressed
      008122 4D               [ 1]  303 	tnz	a
      008123 27 22            [ 1]  304 	jreq	00127$
                                    305 ;	main.c: 116: delay(65535);
      008125 5F               [ 1]  306 	clrw	x
      008126 5A               [ 2]  307 	decw	x
      008127 CD 80 26         [ 4]  308 	call	_delay
                                    309 ;	main.c: 117: delay(65535);
      00812A 5F               [ 1]  310 	clrw	x
      00812B 5A               [ 2]  311 	decw	x
      00812C CD 80 26         [ 4]  312 	call	_delay
                                    313 ;	main.c: 118: if (counter % 2 == 0) {
      00812F 7B 06            [ 1]  314 	ld	a, (0x06, sp)
      008131 44               [ 1]  315 	srl	a
      008132 25 09            [ 1]  316 	jrc	00122$
                                    317 ;	main.c: 119: write_color_to_registers(&rgb_buf);
      008134 96               [ 1]  318 	ldw	x, sp
      008135 1C 00 03         [ 2]  319 	addw	x, #3
      008138 CD 81 A3         [ 4]  320 	call	_write_color_to_registers
      00813B 20 06            [ 2]  321 	jra	00123$
      00813D                        322 00122$:
                                    323 ;	main.c: 122: write_color_to_registers(&rgb);
      00813D AE 00 01         [ 2]  324 	ldw	x, #(_rgb+0)
      008140 CD 81 A3         [ 4]  325 	call	_write_color_to_registers
      008143                        326 00123$:
                                    327 ;	main.c: 124: counter += 1;
      008143 0C 06            [ 1]  328 	inc	(0x06, sp)
      008145 20 CE            [ 2]  329 	jra	00125$
      008147                        330 00127$:
                                    331 ;	main.c: 127: if(counter >= 10 && counter < 23) {
      008147 7B 06            [ 1]  332 	ld	a, (0x06, sp)
      008149 A1 0A            [ 1]  333 	cp	a, #0x0a
      00814B 25 15            [ 1]  334 	jrc	00131$
      00814D 0D 07            [ 1]  335 	tnz	(0x07, sp)
      00814F 27 11            [ 1]  336 	jreq	00131$
                                    337 ;	main.c: 128: rgb = rgb_buf;
      008151 4B 03            [ 1]  338 	push	#0x03
      008153 4B 00            [ 1]  339 	push	#0x00
      008155 96               [ 1]  340 	ldw	x, sp
      008156 1C 00 05         [ 2]  341 	addw	x, #5
      008159 89               [ 2]  342 	pushw	x
      00815A AE 00 01         [ 2]  343 	ldw	x, #(_rgb+0)
      00815D CD 8E 1A         [ 4]  344 	call	___memcpy
      008160 20 0D            [ 2]  345 	jra	00136$
      008162                        346 00131$:
                                    347 ;	main.c: 130: else if (counter == 23) { 
      008162 7B 06            [ 1]  348 	ld	a, (0x06, sp)
      008164 A1 17            [ 1]  349 	cp	a, #0x17
      008166 26 07            [ 1]  350 	jrne	00136$
                                    351 ;	main.c: 131: write_color_to_eeprom(&rgb, 0);        
      008168 4F               [ 1]  352 	clr	a
      008169 AE 00 01         [ 2]  353 	ldw	x, #(_rgb+0)
      00816C CD 82 32         [ 4]  354 	call	_write_color_to_eeprom
      00816F                        355 00136$:
                                    356 ;	main.c: 134: }
      00816F 5B 09            [ 2]  357 	addw	sp, #9
      008171 81               [ 4]  358 	ret
                                    359 	.area CODE
                                    360 	.area CONST
                                    361 	.area INITIALIZER
                                    362 	.area CABS (ABS)
