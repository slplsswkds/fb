                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module gpio
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _gpio_init
                                     12 	.globl _btn_r_plus_is_pressed
                                     13 	.globl _btn_g_plus_is_pressed
                                     14 	.globl _btn_b_plus_is_pressed
                                     15 	.globl _btn_r_minus_is_pressed
                                     16 	.globl _btn_g_minus_is_pressed
                                     17 	.globl _btn_b_minus_is_pressed
                                     18 	.globl _btn_flash_is_pressed
                                     19 	.globl _btn_load_is_pressed
                                     20 	.globl _get_number_from_buttons
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area DATA
                                     25 ;--------------------------------------------------------
                                     26 ; ram data
                                     27 ;--------------------------------------------------------
                                     28 	.area INITIALIZED
                                     29 ;--------------------------------------------------------
                                     30 ; absolute external ram data
                                     31 ;--------------------------------------------------------
                                     32 	.area DABS (ABS)
                                     33 
                                     34 ; default segment ordering for linker
                                     35 	.area HOME
                                     36 	.area GSINIT
                                     37 	.area GSFINAL
                                     38 	.area CONST
                                     39 	.area INITIALIZER
                                     40 	.area CODE
                                     41 
                                     42 ;--------------------------------------------------------
                                     43 ; global & static initialisations
                                     44 ;--------------------------------------------------------
                                     45 	.area HOME
                                     46 	.area GSINIT
                                     47 	.area GSFINAL
                                     48 	.area GSINIT
                                     49 ;--------------------------------------------------------
                                     50 ; Home
                                     51 ;--------------------------------------------------------
                                     52 	.area HOME
                                     53 	.area HOME
                                     54 ;--------------------------------------------------------
                                     55 ; code
                                     56 ;--------------------------------------------------------
                                     57 	.area CODE
                                     58 ;	./src/gpio.c: 3: void gpio_init() {
                                     59 ;	-----------------------------------------
                                     60 ;	 function gpio_init
                                     61 ;	-----------------------------------------
      008289                         62 _gpio_init:
                                     63 ;	./src/gpio.c: 6: PB_DDR |= (1 << 5);
      008289 72 1A 50 07      [ 1]   64 	bset	0x5007, #5
                                     65 ;	./src/gpio.c: 7: PB_CR1 |= (1 << 5);
      00828D 72 1A 50 08      [ 1]   66 	bset	0x5008, #5
                                     67 ;	./src/gpio.c: 8: PB_CR2 &= ~(1 << 5);
      008291 72 1B 50 09      [ 1]   68 	bres	0x5009, #5
                                     69 ;	./src/gpio.c: 9: PB_ODR |= (1 << 5);
      008295 72 1A 50 05      [ 1]   70 	bset	0x5005, #5
                                     71 ;	./src/gpio.c: 13: PD_DDR |= (1 << 4);
      008299 72 18 50 11      [ 1]   72 	bset	0x5011, #4
                                     73 ;	./src/gpio.c: 14: PD_CR1 |= (1 << 4);
      00829D 72 18 50 12      [ 1]   74 	bset	0x5012, #4
                                     75 ;	./src/gpio.c: 15: PD_CR2 &= ~(1 << 4);
      0082A1 72 19 50 13      [ 1]   76 	bres	0x5013, #4
                                     77 ;	./src/gpio.c: 16: PD_ODR &= ~(1 << 4);
      0082A5 72 19 50 0F      [ 1]   78 	bres	0x500f, #4
                                     79 ;	./src/gpio.c: 20: PD_DDR |= (1 << 3);
      0082A9 72 16 50 11      [ 1]   80 	bset	0x5011, #3
                                     81 ;	./src/gpio.c: 21: PD_CR1 |= (1 << 3);
      0082AD 72 16 50 12      [ 1]   82 	bset	0x5012, #3
                                     83 ;	./src/gpio.c: 22: PD_CR2 &= ~(1 << 3);
      0082B1 72 17 50 13      [ 1]   84 	bres	0x5013, #3
                                     85 ;	./src/gpio.c: 23: PD_ODR &= ~(1 << 3);
      0082B5 72 17 50 0F      [ 1]   86 	bres	0x500f, #3
                                     87 ;	./src/gpio.c: 27: PA_DDR |= (1 << 3);
      0082B9 72 16 50 02      [ 1]   88 	bset	0x5002, #3
                                     89 ;	./src/gpio.c: 28: PA_CR1 |= (1 << 3);
      0082BD 72 16 50 03      [ 1]   90 	bset	0x5003, #3
                                     91 ;	./src/gpio.c: 29: PA_CR2 &= ~(1 << 3);
      0082C1 72 17 50 04      [ 1]   92 	bres	0x5004, #3
                                     93 ;	./src/gpio.c: 30: PA_ODR &= ~(1 << 3);
      0082C5 72 17 50 00      [ 1]   94 	bres	0x5000, #3
                                     95 ;	./src/gpio.c: 44: PD_DDR &= ~(1 << 2); // Input 
      0082C9 72 15 50 11      [ 1]   96 	bres	0x5011, #2
                                     97 ;	./src/gpio.c: 45: PD_CR1 |= (1 << 2); // Pull-Up
      0082CD 72 14 50 12      [ 1]   98 	bset	0x5012, #2
                                     99 ;	./src/gpio.c: 46: PD_CR2 &= ~(1 << 2); // Interrupt disabled
      0082D1 72 15 50 13      [ 1]  100 	bres	0x5013, #2
                                    101 ;	./src/gpio.c: 48: PC_DDR &= ~(1 << 7);
      0082D5 72 1F 50 0C      [ 1]  102 	bres	0x500c, #7
                                    103 ;	./src/gpio.c: 49: PC_CR1 |= (1 << 7);
      0082D9 72 1E 50 0D      [ 1]  104 	bset	0x500d, #7
                                    105 ;	./src/gpio.c: 50: PC_CR2 &= ~(1 << 7);
      0082DD 72 1F 50 0E      [ 1]  106 	bres	0x500e, #7
                                    107 ;	./src/gpio.c: 52: PC_DDR &= ~(1 << 6);
      0082E1 72 1D 50 0C      [ 1]  108 	bres	0x500c, #6
                                    109 ;	./src/gpio.c: 53: PC_CR1 |= (1 << 6);
      0082E5 72 1C 50 0D      [ 1]  110 	bset	0x500d, #6
                                    111 ;	./src/gpio.c: 54: PC_CR2 &= ~(1 << 6);
      0082E9 72 1D 50 0E      [ 1]  112 	bres	0x500e, #6
                                    113 ;	./src/gpio.c: 56: PC_DDR &= ~(1 << 5);
      0082ED 72 1B 50 0C      [ 1]  114 	bres	0x500c, #5
                                    115 ;	./src/gpio.c: 57: PC_CR1 |= (1 << 5);
      0082F1 72 1A 50 0D      [ 1]  116 	bset	0x500d, #5
                                    117 ;	./src/gpio.c: 58: PC_CR2 &= ~(1 << 5);
      0082F5 72 1B 50 0E      [ 1]  118 	bres	0x500e, #5
                                    119 ;	./src/gpio.c: 60: PC_DDR &= ~(1 << 4);
      0082F9 72 19 50 0C      [ 1]  120 	bres	0x500c, #4
                                    121 ;	./src/gpio.c: 61: PC_CR1 |= (1 << 4);
      0082FD 72 18 50 0D      [ 1]  122 	bset	0x500d, #4
                                    123 ;	./src/gpio.c: 62: PC_CR2 &= ~(1 << 4);
      008301 72 19 50 0E      [ 1]  124 	bres	0x500e, #4
                                    125 ;	./src/gpio.c: 64: PC_DDR &= ~(1 << 3);
      008305 72 17 50 0C      [ 1]  126 	bres	0x500c, #3
                                    127 ;	./src/gpio.c: 65: PC_CR1 |= (1 << 3);
      008309 72 16 50 0D      [ 1]  128 	bset	0x500d, #3
                                    129 ;	./src/gpio.c: 66: PC_CR2 &= ~(1 << 3);
      00830D 72 17 50 0E      [ 1]  130 	bres	0x500e, #3
                                    131 ;	./src/gpio.c: 69: PB_DDR &= ~(1 << 4);
      008311 72 19 50 07      [ 1]  132 	bres	0x5007, #4
                                    133 ;	./src/gpio.c: 70: PB_CR1 |= (1 << 4);
      008315 72 18 50 08      [ 1]  134 	bset	0x5008, #4
                                    135 ;	./src/gpio.c: 71: PB_CR2 &= ~(1 << 4);
      008319 72 19 50 09      [ 1]  136 	bres	0x5009, #4
                                    137 ;	./src/gpio.c: 73: PB_DDR &= ~(1 << 5);
      00831D 72 1B 50 07      [ 1]  138 	bres	0x5007, #5
                                    139 ;	./src/gpio.c: 74: PB_CR1 |= (1 << 5);
      008321 72 1A 50 08      [ 1]  140 	bset	0x5008, #5
                                    141 ;	./src/gpio.c: 75: PB_CR2 &= ~(1 << 5);
      008325 72 1B 50 09      [ 1]  142 	bres	0x5009, #5
                                    143 ;	./src/gpio.c: 80: PD_DDR |= (1 << 5); // Output
      008329 72 1A 50 11      [ 1]  144 	bset	0x5011, #5
                                    145 ;	./src/gpio.c: 81: PD_CR1 |= (1 << 5); // PushPull
      00832D 72 1A 50 12      [ 1]  146 	bset	0x5012, #5
                                    147 ;	./src/gpio.c: 82: PD_CR2 &= ~(1 << 5); // To 2MHz
      008331 72 1B 50 13      [ 1]  148 	bres	0x5013, #5
                                    149 ;	./src/gpio.c: 85: PD_DDR &= ~(1 << 6); // Input
      008335 72 1D 50 11      [ 1]  150 	bres	0x5011, #6
                                    151 ;	./src/gpio.c: 86: PD_CR1 &= ~(1 << 6); // Floating
      008339 72 1D 50 12      [ 1]  152 	bres	0x5012, #6
                                    153 ;	./src/gpio.c: 87: PD_CR2 &= ~(1 << 6); // External interrupt disabled
      00833D 72 1D 50 13      [ 1]  154 	bres	0x5013, #6
                                    155 ;	./src/gpio.c: 88: }
      008341 81               [ 4]  156 	ret
                                    157 ;	./src/gpio.c: 90: uint8_t btn_r_plus_is_pressed() {
                                    158 ;	-----------------------------------------
                                    159 ;	 function btn_r_plus_is_pressed
                                    160 ;	-----------------------------------------
      008342                        161 _btn_r_plus_is_pressed:
                                    162 ;	./src/gpio.c: 91: return((1 << 2) == (~PD_IDR & (1 << 2)));
      008342 C6 50 10         [ 1]  163 	ld	a, 0x5010
      008345 5F               [ 1]  164 	clrw	x
      008346 97               [ 1]  165 	ld	xl, a
      008347 53               [ 2]  166 	cplw	x
      008348 9F               [ 1]  167 	ld	a, xl
      008349 A4 04            [ 1]  168 	and	a, #0x04
      00834B 97               [ 1]  169 	ld	xl, a
      00834C 4F               [ 1]  170 	clr	a
      00834D 95               [ 1]  171 	ld	xh, a
      00834E A3 00 04         [ 2]  172 	cpw	x, #0x0004
      008351 26 03            [ 1]  173 	jrne	00104$
      008353 A6 01            [ 1]  174 	ld	a, #0x01
      008355 81               [ 4]  175 	ret
      008356                        176 00104$:
      008356 4F               [ 1]  177 	clr	a
                                    178 ;	./src/gpio.c: 92: }
      008357 81               [ 4]  179 	ret
                                    180 ;	./src/gpio.c: 94: uint8_t btn_g_plus_is_pressed() {
                                    181 ;	-----------------------------------------
                                    182 ;	 function btn_g_plus_is_pressed
                                    183 ;	-----------------------------------------
      008358                        184 _btn_g_plus_is_pressed:
                                    185 ;	./src/gpio.c: 95: return((1 << 6) == (~PC_IDR & (1 << 6)));
      008358 C6 50 0B         [ 1]  186 	ld	a, 0x500b
      00835B 5F               [ 1]  187 	clrw	x
      00835C 97               [ 1]  188 	ld	xl, a
      00835D 53               [ 2]  189 	cplw	x
      00835E 9F               [ 1]  190 	ld	a, xl
      00835F A4 40            [ 1]  191 	and	a, #0x40
      008361 97               [ 1]  192 	ld	xl, a
      008362 4F               [ 1]  193 	clr	a
      008363 95               [ 1]  194 	ld	xh, a
      008364 A3 00 40         [ 2]  195 	cpw	x, #0x0040
      008367 26 03            [ 1]  196 	jrne	00104$
      008369 A6 01            [ 1]  197 	ld	a, #0x01
      00836B 81               [ 4]  198 	ret
      00836C                        199 00104$:
      00836C 4F               [ 1]  200 	clr	a
                                    201 ;	./src/gpio.c: 96: }
      00836D 81               [ 4]  202 	ret
                                    203 ;	./src/gpio.c: 98: uint8_t btn_b_plus_is_pressed() {
                                    204 ;	-----------------------------------------
                                    205 ;	 function btn_b_plus_is_pressed
                                    206 ;	-----------------------------------------
      00836E                        207 _btn_b_plus_is_pressed:
                                    208 ;	./src/gpio.c: 99: return((1 << 4) == (~PC_IDR & (1 << 4)));
      00836E C6 50 0B         [ 1]  209 	ld	a, 0x500b
      008371 5F               [ 1]  210 	clrw	x
      008372 97               [ 1]  211 	ld	xl, a
      008373 53               [ 2]  212 	cplw	x
      008374 9F               [ 1]  213 	ld	a, xl
      008375 A4 10            [ 1]  214 	and	a, #0x10
      008377 97               [ 1]  215 	ld	xl, a
      008378 4F               [ 1]  216 	clr	a
      008379 95               [ 1]  217 	ld	xh, a
      00837A A3 00 10         [ 2]  218 	cpw	x, #0x0010
      00837D 26 03            [ 1]  219 	jrne	00104$
      00837F A6 01            [ 1]  220 	ld	a, #0x01
      008381 81               [ 4]  221 	ret
      008382                        222 00104$:
      008382 4F               [ 1]  223 	clr	a
                                    224 ;	./src/gpio.c: 100: }
      008383 81               [ 4]  225 	ret
                                    226 ;	./src/gpio.c: 102: uint8_t btn_r_minus_is_pressed() {
                                    227 ;	-----------------------------------------
                                    228 ;	 function btn_r_minus_is_pressed
                                    229 ;	-----------------------------------------
      008384                        230 _btn_r_minus_is_pressed:
                                    231 ;	./src/gpio.c: 103: return((1 << 7) == (~PC_IDR & (1 << 7)));
      008384 C6 50 0B         [ 1]  232 	ld	a, 0x500b
      008387 5F               [ 1]  233 	clrw	x
      008388 97               [ 1]  234 	ld	xl, a
      008389 53               [ 2]  235 	cplw	x
      00838A 9F               [ 1]  236 	ld	a, xl
      00838B A4 80            [ 1]  237 	and	a, #0x80
      00838D 97               [ 1]  238 	ld	xl, a
      00838E 4F               [ 1]  239 	clr	a
      00838F 95               [ 1]  240 	ld	xh, a
      008390 A3 00 80         [ 2]  241 	cpw	x, #0x0080
      008393 26 03            [ 1]  242 	jrne	00104$
      008395 A6 01            [ 1]  243 	ld	a, #0x01
      008397 81               [ 4]  244 	ret
      008398                        245 00104$:
      008398 4F               [ 1]  246 	clr	a
                                    247 ;	./src/gpio.c: 104: }
      008399 81               [ 4]  248 	ret
                                    249 ;	./src/gpio.c: 106: uint8_t btn_g_minus_is_pressed() {
                                    250 ;	-----------------------------------------
                                    251 ;	 function btn_g_minus_is_pressed
                                    252 ;	-----------------------------------------
      00839A                        253 _btn_g_minus_is_pressed:
                                    254 ;	./src/gpio.c: 107: return((1 << 5) == (~PC_IDR & (1 << 5)));
      00839A C6 50 0B         [ 1]  255 	ld	a, 0x500b
      00839D 5F               [ 1]  256 	clrw	x
      00839E 97               [ 1]  257 	ld	xl, a
      00839F 53               [ 2]  258 	cplw	x
      0083A0 9F               [ 1]  259 	ld	a, xl
      0083A1 A4 20            [ 1]  260 	and	a, #0x20
      0083A3 97               [ 1]  261 	ld	xl, a
      0083A4 4F               [ 1]  262 	clr	a
      0083A5 95               [ 1]  263 	ld	xh, a
      0083A6 A3 00 20         [ 2]  264 	cpw	x, #0x0020
      0083A9 26 03            [ 1]  265 	jrne	00104$
      0083AB A6 01            [ 1]  266 	ld	a, #0x01
      0083AD 81               [ 4]  267 	ret
      0083AE                        268 00104$:
      0083AE 4F               [ 1]  269 	clr	a
                                    270 ;	./src/gpio.c: 108: }
      0083AF 81               [ 4]  271 	ret
                                    272 ;	./src/gpio.c: 110: uint8_t btn_b_minus_is_pressed() {
                                    273 ;	-----------------------------------------
                                    274 ;	 function btn_b_minus_is_pressed
                                    275 ;	-----------------------------------------
      0083B0                        276 _btn_b_minus_is_pressed:
                                    277 ;	./src/gpio.c: 111: return((1 << 3) == (~PC_IDR & (1 << 3)));
      0083B0 C6 50 0B         [ 1]  278 	ld	a, 0x500b
      0083B3 5F               [ 1]  279 	clrw	x
      0083B4 97               [ 1]  280 	ld	xl, a
      0083B5 53               [ 2]  281 	cplw	x
      0083B6 9F               [ 1]  282 	ld	a, xl
      0083B7 A4 08            [ 1]  283 	and	a, #0x08
      0083B9 97               [ 1]  284 	ld	xl, a
      0083BA 4F               [ 1]  285 	clr	a
      0083BB 95               [ 1]  286 	ld	xh, a
      0083BC A3 00 08         [ 2]  287 	cpw	x, #0x0008
      0083BF 26 03            [ 1]  288 	jrne	00104$
      0083C1 A6 01            [ 1]  289 	ld	a, #0x01
      0083C3 81               [ 4]  290 	ret
      0083C4                        291 00104$:
      0083C4 4F               [ 1]  292 	clr	a
                                    293 ;	./src/gpio.c: 112: }
      0083C5 81               [ 4]  294 	ret
                                    295 ;	./src/gpio.c: 114: uint8_t btn_flash_is_pressed() {
                                    296 ;	-----------------------------------------
                                    297 ;	 function btn_flash_is_pressed
                                    298 ;	-----------------------------------------
      0083C6                        299 _btn_flash_is_pressed:
                                    300 ;	./src/gpio.c: 115: return((1 << 4) == (~PB_IDR & (1 << 4)));
      0083C6 C6 50 06         [ 1]  301 	ld	a, 0x5006
      0083C9 5F               [ 1]  302 	clrw	x
      0083CA 97               [ 1]  303 	ld	xl, a
      0083CB 53               [ 2]  304 	cplw	x
      0083CC 9F               [ 1]  305 	ld	a, xl
      0083CD A4 10            [ 1]  306 	and	a, #0x10
      0083CF 97               [ 1]  307 	ld	xl, a
      0083D0 4F               [ 1]  308 	clr	a
      0083D1 95               [ 1]  309 	ld	xh, a
      0083D2 A3 00 10         [ 2]  310 	cpw	x, #0x0010
      0083D5 26 03            [ 1]  311 	jrne	00104$
      0083D7 A6 01            [ 1]  312 	ld	a, #0x01
      0083D9 81               [ 4]  313 	ret
      0083DA                        314 00104$:
      0083DA 4F               [ 1]  315 	clr	a
                                    316 ;	./src/gpio.c: 116: }
      0083DB 81               [ 4]  317 	ret
                                    318 ;	./src/gpio.c: 118: uint8_t btn_load_is_pressed() {
                                    319 ;	-----------------------------------------
                                    320 ;	 function btn_load_is_pressed
                                    321 ;	-----------------------------------------
      0083DC                        322 _btn_load_is_pressed:
                                    323 ;	./src/gpio.c: 119: return((1 << 5) == (~PB_IDR & (1 << 5)));
      0083DC C6 50 06         [ 1]  324 	ld	a, 0x5006
      0083DF 5F               [ 1]  325 	clrw	x
      0083E0 97               [ 1]  326 	ld	xl, a
      0083E1 53               [ 2]  327 	cplw	x
      0083E2 9F               [ 1]  328 	ld	a, xl
      0083E3 A4 20            [ 1]  329 	and	a, #0x20
      0083E5 97               [ 1]  330 	ld	xl, a
      0083E6 4F               [ 1]  331 	clr	a
      0083E7 95               [ 1]  332 	ld	xh, a
      0083E8 A3 00 20         [ 2]  333 	cpw	x, #0x0020
      0083EB 26 03            [ 1]  334 	jrne	00104$
      0083ED A6 01            [ 1]  335 	ld	a, #0x01
      0083EF 81               [ 4]  336 	ret
      0083F0                        337 00104$:
      0083F0 4F               [ 1]  338 	clr	a
                                    339 ;	./src/gpio.c: 120: }
      0083F1 81               [ 4]  340 	ret
                                    341 ;	./src/gpio.c: 122: static void delay(uint16_t t) {
                                    342 ;	-----------------------------------------
                                    343 ;	 function delay
                                    344 ;	-----------------------------------------
      0083F2                        345 _delay:
                                    346 ;	./src/gpio.c: 123: while(t--) {};
      0083F2                        347 00101$:
      0083F2 90 93            [ 1]  348 	ldw	y, x
      0083F4 5A               [ 2]  349 	decw	x
      0083F5 90 5D            [ 2]  350 	tnzw	y
      0083F7 26 F9            [ 1]  351 	jrne	00101$
                                    352 ;	./src/gpio.c: 124: }
      0083F9 81               [ 4]  353 	ret
                                    354 ;	./src/gpio.c: 126: uint8_t get_number_from_buttons() {
                                    355 ;	-----------------------------------------
                                    356 ;	 function get_number_from_buttons
                                    357 ;	-----------------------------------------
      0083FA                        358 _get_number_from_buttons:
      0083FA 88               [ 1]  359 	push	a
                                    360 ;	./src/gpio.c: 127: uint8_t number = 0;
      0083FB 0F 01            [ 1]  361 	clr	(0x01, sp)
                                    362 ;	./src/gpio.c: 129: while(1) { // In future should be added timeout
      0083FD                        363 00116$:
                                    364 ;	./src/gpio.c: 130: delay(65535);
      0083FD 5F               [ 1]  365 	clrw	x
      0083FE 5A               [ 2]  366 	decw	x
      0083FF CD 83 F2         [ 4]  367 	call	_delay
                                    368 ;	./src/gpio.c: 132: if(btn_r_plus_is_pressed()) {
      008402 CD 83 42         [ 4]  369 	call	_btn_r_plus_is_pressed
      008405 4D               [ 1]  370 	tnz	a
      008406 27 06            [ 1]  371 	jreq	00102$
                                    372 ;	./src/gpio.c: 133: number |= (1 << 5);
      008408 7B 01            [ 1]  373 	ld	a, (0x01, sp)
      00840A AA 20            [ 1]  374 	or	a, #0x20
      00840C 6B 01            [ 1]  375 	ld	(0x01, sp), a
      00840E                        376 00102$:
                                    377 ;	./src/gpio.c: 136: if(btn_g_plus_is_pressed()) {
      00840E CD 83 58         [ 4]  378 	call	_btn_g_plus_is_pressed
      008411 4D               [ 1]  379 	tnz	a
      008412 27 06            [ 1]  380 	jreq	00104$
                                    381 ;	./src/gpio.c: 137: number |= (1 << 4);
      008414 7B 01            [ 1]  382 	ld	a, (0x01, sp)
      008416 AA 10            [ 1]  383 	or	a, #0x10
      008418 6B 01            [ 1]  384 	ld	(0x01, sp), a
      00841A                        385 00104$:
                                    386 ;	./src/gpio.c: 140: if(btn_b_plus_is_pressed()) {
      00841A CD 83 6E         [ 4]  387 	call	_btn_b_plus_is_pressed
      00841D 4D               [ 1]  388 	tnz	a
      00841E 27 06            [ 1]  389 	jreq	00106$
                                    390 ;	./src/gpio.c: 141: number |= (1 << 3);
      008420 7B 01            [ 1]  391 	ld	a, (0x01, sp)
      008422 AA 08            [ 1]  392 	or	a, #0x08
      008424 6B 01            [ 1]  393 	ld	(0x01, sp), a
      008426                        394 00106$:
                                    395 ;	./src/gpio.c: 144: if(btn_r_minus_is_pressed()) {
      008426 CD 83 84         [ 4]  396 	call	_btn_r_minus_is_pressed
      008429 4D               [ 1]  397 	tnz	a
      00842A 27 06            [ 1]  398 	jreq	00108$
                                    399 ;	./src/gpio.c: 145: number |= (1 << 2);
      00842C 7B 01            [ 1]  400 	ld	a, (0x01, sp)
      00842E AA 04            [ 1]  401 	or	a, #0x04
      008430 6B 01            [ 1]  402 	ld	(0x01, sp), a
      008432                        403 00108$:
                                    404 ;	./src/gpio.c: 148: if(btn_g_minus_is_pressed()) {
      008432 CD 83 9A         [ 4]  405 	call	_btn_g_minus_is_pressed
      008435 4D               [ 1]  406 	tnz	a
      008436 27 06            [ 1]  407 	jreq	00110$
                                    408 ;	./src/gpio.c: 149: number |= (1 << 1);
      008438 7B 01            [ 1]  409 	ld	a, (0x01, sp)
      00843A AA 02            [ 1]  410 	or	a, #0x02
      00843C 6B 01            [ 1]  411 	ld	(0x01, sp), a
      00843E                        412 00110$:
                                    413 ;	./src/gpio.c: 152: if(btn_b_minus_is_pressed()) {
      00843E CD 83 B0         [ 4]  414 	call	_btn_b_minus_is_pressed
      008441 4D               [ 1]  415 	tnz	a
      008442 27 05            [ 1]  416 	jreq	00112$
                                    417 ;	./src/gpio.c: 153: number |= (1 << 0);
      008444 04 01            [ 1]  418 	srl	(0x01, sp)
      008446 99               [ 1]  419 	scf
      008447 09 01            [ 1]  420 	rlc	(0x01, sp)
      008449                        421 00112$:
                                    422 ;	./src/gpio.c: 159: if(btn_load_is_pressed()) {
      008449 CD 83 DC         [ 4]  423 	call	_btn_load_is_pressed
      00844C 4D               [ 1]  424 	tnz	a
      00844D 27 AE            [ 1]  425 	jreq	00116$
                                    426 ;	./src/gpio.c: 164: return number;
      00844F 7B 01            [ 1]  427 	ld	a, (0x01, sp)
                                    428 ;	./src/gpio.c: 165: }
      008451 5B 01            [ 2]  429 	addw	sp, #1
      008453 81               [ 4]  430 	ret
                                    431 	.area CODE
                                    432 	.area CONST
                                    433 	.area INITIALIZER
                                    434 	.area CABS (ABS)
