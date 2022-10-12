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
      008239                         62 _gpio_init:
                                     63 ;	./src/gpio.c: 6: PB_DDR |= (1 << 5);
      008239 72 1A 50 07      [ 1]   64 	bset	0x5007, #5
                                     65 ;	./src/gpio.c: 7: PB_CR1 |= (1 << 5);
      00823D 72 1A 50 08      [ 1]   66 	bset	0x5008, #5
                                     67 ;	./src/gpio.c: 8: PB_CR2 &= ~(1 << 5);
      008241 72 1B 50 09      [ 1]   68 	bres	0x5009, #5
                                     69 ;	./src/gpio.c: 9: PB_ODR |= (1 << 5);
      008245 72 1A 50 05      [ 1]   70 	bset	0x5005, #5
                                     71 ;	./src/gpio.c: 13: PD_DDR |= (1 << 4);
      008249 72 18 50 11      [ 1]   72 	bset	0x5011, #4
                                     73 ;	./src/gpio.c: 14: PD_CR1 |= (1 << 4);
      00824D 72 18 50 12      [ 1]   74 	bset	0x5012, #4
                                     75 ;	./src/gpio.c: 15: PD_CR2 &= ~(1 << 4);
      008251 72 19 50 13      [ 1]   76 	bres	0x5013, #4
                                     77 ;	./src/gpio.c: 16: PD_ODR &= ~(1 << 4);
      008255 72 19 50 0F      [ 1]   78 	bres	0x500f, #4
                                     79 ;	./src/gpio.c: 20: PD_DDR |= (1 << 3);
      008259 72 16 50 11      [ 1]   80 	bset	0x5011, #3
                                     81 ;	./src/gpio.c: 21: PD_CR1 |= (1 << 3);
      00825D 72 16 50 12      [ 1]   82 	bset	0x5012, #3
                                     83 ;	./src/gpio.c: 22: PD_CR2 &= ~(1 << 3);
      008261 72 17 50 13      [ 1]   84 	bres	0x5013, #3
                                     85 ;	./src/gpio.c: 23: PD_ODR &= ~(1 << 3);
      008265 72 17 50 0F      [ 1]   86 	bres	0x500f, #3
                                     87 ;	./src/gpio.c: 27: PA_DDR |= (1 << 3);
      008269 72 16 50 02      [ 1]   88 	bset	0x5002, #3
                                     89 ;	./src/gpio.c: 28: PA_CR1 |= (1 << 3);
      00826D 72 16 50 03      [ 1]   90 	bset	0x5003, #3
                                     91 ;	./src/gpio.c: 29: PA_CR2 &= ~(1 << 3);
      008271 72 17 50 04      [ 1]   92 	bres	0x5004, #3
                                     93 ;	./src/gpio.c: 30: PA_ODR &= ~(1 << 3);
      008275 72 17 50 00      [ 1]   94 	bres	0x5000, #3
                                     95 ;	./src/gpio.c: 44: PD_DDR &= ~(1 << 2); // Input 
      008279 72 15 50 11      [ 1]   96 	bres	0x5011, #2
                                     97 ;	./src/gpio.c: 45: PD_CR1 |= (1 << 2); // Pull-Up
      00827D 72 14 50 12      [ 1]   98 	bset	0x5012, #2
                                     99 ;	./src/gpio.c: 46: PD_CR2 &= ~(1 << 2); // Interrupt disabled
      008281 72 15 50 13      [ 1]  100 	bres	0x5013, #2
                                    101 ;	./src/gpio.c: 48: PC_DDR &= ~(1 << 7);
      008285 72 1F 50 0C      [ 1]  102 	bres	0x500c, #7
                                    103 ;	./src/gpio.c: 49: PC_CR1 |= (1 << 7);
      008289 72 1E 50 0D      [ 1]  104 	bset	0x500d, #7
                                    105 ;	./src/gpio.c: 50: PC_CR2 &= ~(1 << 7);
      00828D 72 1F 50 0E      [ 1]  106 	bres	0x500e, #7
                                    107 ;	./src/gpio.c: 52: PC_DDR &= ~(1 << 6);
      008291 72 1D 50 0C      [ 1]  108 	bres	0x500c, #6
                                    109 ;	./src/gpio.c: 53: PC_CR1 |= (1 << 6);
      008295 72 1C 50 0D      [ 1]  110 	bset	0x500d, #6
                                    111 ;	./src/gpio.c: 54: PC_CR2 &= ~(1 << 6);
      008299 72 1D 50 0E      [ 1]  112 	bres	0x500e, #6
                                    113 ;	./src/gpio.c: 56: PC_DDR &= ~(1 << 5);
      00829D 72 1B 50 0C      [ 1]  114 	bres	0x500c, #5
                                    115 ;	./src/gpio.c: 57: PC_CR1 |= (1 << 5);
      0082A1 72 1A 50 0D      [ 1]  116 	bset	0x500d, #5
                                    117 ;	./src/gpio.c: 58: PC_CR2 &= ~(1 << 5);
      0082A5 72 1B 50 0E      [ 1]  118 	bres	0x500e, #5
                                    119 ;	./src/gpio.c: 60: PC_DDR &= ~(1 << 4);
      0082A9 72 19 50 0C      [ 1]  120 	bres	0x500c, #4
                                    121 ;	./src/gpio.c: 61: PC_CR1 |= (1 << 4);
      0082AD 72 18 50 0D      [ 1]  122 	bset	0x500d, #4
                                    123 ;	./src/gpio.c: 62: PC_CR2 &= ~(1 << 4);
      0082B1 72 19 50 0E      [ 1]  124 	bres	0x500e, #4
                                    125 ;	./src/gpio.c: 64: PC_DDR &= ~(1 << 3);
      0082B5 72 17 50 0C      [ 1]  126 	bres	0x500c, #3
                                    127 ;	./src/gpio.c: 65: PC_CR1 |= (1 << 3);
      0082B9 72 16 50 0D      [ 1]  128 	bset	0x500d, #3
                                    129 ;	./src/gpio.c: 66: PC_CR2 &= ~(1 << 3);
      0082BD 72 17 50 0E      [ 1]  130 	bres	0x500e, #3
                                    131 ;	./src/gpio.c: 69: PB_DDR &= ~(1 << 4);
      0082C1 72 19 50 07      [ 1]  132 	bres	0x5007, #4
                                    133 ;	./src/gpio.c: 70: PB_CR1 |= (1 << 4);
      0082C5 72 18 50 08      [ 1]  134 	bset	0x5008, #4
                                    135 ;	./src/gpio.c: 71: PB_CR2 &= ~(1 << 4);
      0082C9 72 19 50 09      [ 1]  136 	bres	0x5009, #4
                                    137 ;	./src/gpio.c: 73: PB_DDR &= ~(1 << 5);
      0082CD 72 1B 50 07      [ 1]  138 	bres	0x5007, #5
                                    139 ;	./src/gpio.c: 74: PB_CR1 |= (1 << 5);
      0082D1 72 1A 50 08      [ 1]  140 	bset	0x5008, #5
                                    141 ;	./src/gpio.c: 75: PB_CR2 &= ~(1 << 5);
      0082D5 72 1B 50 09      [ 1]  142 	bres	0x5009, #5
                                    143 ;	./src/gpio.c: 80: PD_DDR |= (1 << 5); // Output
      0082D9 72 1A 50 11      [ 1]  144 	bset	0x5011, #5
                                    145 ;	./src/gpio.c: 81: PD_CR1 |= (1 << 5); // PushPull
      0082DD 72 1A 50 12      [ 1]  146 	bset	0x5012, #5
                                    147 ;	./src/gpio.c: 82: PD_CR2 &= ~(1 << 5); // To 2MHz
      0082E1 72 1B 50 13      [ 1]  148 	bres	0x5013, #5
                                    149 ;	./src/gpio.c: 85: PD_DDR &= ~(1 << 6); // Input
      0082E5 72 1D 50 11      [ 1]  150 	bres	0x5011, #6
                                    151 ;	./src/gpio.c: 86: PD_CR1 &= ~(1 << 6); // Floating
      0082E9 72 1D 50 12      [ 1]  152 	bres	0x5012, #6
                                    153 ;	./src/gpio.c: 87: PD_CR2 &= ~(1 << 6); // External interrupt disabled
      0082ED 72 1D 50 13      [ 1]  154 	bres	0x5013, #6
                                    155 ;	./src/gpio.c: 88: }
      0082F1 81               [ 4]  156 	ret
                                    157 ;	./src/gpio.c: 90: uint8_t btn_r_plus_is_pressed() {
                                    158 ;	-----------------------------------------
                                    159 ;	 function btn_r_plus_is_pressed
                                    160 ;	-----------------------------------------
      0082F2                        161 _btn_r_plus_is_pressed:
                                    162 ;	./src/gpio.c: 91: return((1 << 2) == (~PD_IDR & (1 << 2)));
      0082F2 C6 50 10         [ 1]  163 	ld	a, 0x5010
      0082F5 5F               [ 1]  164 	clrw	x
      0082F6 97               [ 1]  165 	ld	xl, a
      0082F7 53               [ 2]  166 	cplw	x
      0082F8 9F               [ 1]  167 	ld	a, xl
      0082F9 A4 04            [ 1]  168 	and	a, #0x04
      0082FB 97               [ 1]  169 	ld	xl, a
      0082FC 4F               [ 1]  170 	clr	a
      0082FD 95               [ 1]  171 	ld	xh, a
      0082FE A3 00 04         [ 2]  172 	cpw	x, #0x0004
      008301 26 03            [ 1]  173 	jrne	00104$
      008303 A6 01            [ 1]  174 	ld	a, #0x01
      008305 81               [ 4]  175 	ret
      008306                        176 00104$:
      008306 4F               [ 1]  177 	clr	a
                                    178 ;	./src/gpio.c: 92: }
      008307 81               [ 4]  179 	ret
                                    180 ;	./src/gpio.c: 94: uint8_t btn_g_plus_is_pressed() {
                                    181 ;	-----------------------------------------
                                    182 ;	 function btn_g_plus_is_pressed
                                    183 ;	-----------------------------------------
      008308                        184 _btn_g_plus_is_pressed:
                                    185 ;	./src/gpio.c: 95: return((1 << 6) == (~PC_IDR & (1 << 6)));
      008308 C6 50 0B         [ 1]  186 	ld	a, 0x500b
      00830B 5F               [ 1]  187 	clrw	x
      00830C 97               [ 1]  188 	ld	xl, a
      00830D 53               [ 2]  189 	cplw	x
      00830E 9F               [ 1]  190 	ld	a, xl
      00830F A4 40            [ 1]  191 	and	a, #0x40
      008311 97               [ 1]  192 	ld	xl, a
      008312 4F               [ 1]  193 	clr	a
      008313 95               [ 1]  194 	ld	xh, a
      008314 A3 00 40         [ 2]  195 	cpw	x, #0x0040
      008317 26 03            [ 1]  196 	jrne	00104$
      008319 A6 01            [ 1]  197 	ld	a, #0x01
      00831B 81               [ 4]  198 	ret
      00831C                        199 00104$:
      00831C 4F               [ 1]  200 	clr	a
                                    201 ;	./src/gpio.c: 96: }
      00831D 81               [ 4]  202 	ret
                                    203 ;	./src/gpio.c: 98: uint8_t btn_b_plus_is_pressed() {
                                    204 ;	-----------------------------------------
                                    205 ;	 function btn_b_plus_is_pressed
                                    206 ;	-----------------------------------------
      00831E                        207 _btn_b_plus_is_pressed:
                                    208 ;	./src/gpio.c: 99: return((1 << 4) == (~PC_IDR & (1 << 4)));
      00831E C6 50 0B         [ 1]  209 	ld	a, 0x500b
      008321 5F               [ 1]  210 	clrw	x
      008322 97               [ 1]  211 	ld	xl, a
      008323 53               [ 2]  212 	cplw	x
      008324 9F               [ 1]  213 	ld	a, xl
      008325 A4 10            [ 1]  214 	and	a, #0x10
      008327 97               [ 1]  215 	ld	xl, a
      008328 4F               [ 1]  216 	clr	a
      008329 95               [ 1]  217 	ld	xh, a
      00832A A3 00 10         [ 2]  218 	cpw	x, #0x0010
      00832D 26 03            [ 1]  219 	jrne	00104$
      00832F A6 01            [ 1]  220 	ld	a, #0x01
      008331 81               [ 4]  221 	ret
      008332                        222 00104$:
      008332 4F               [ 1]  223 	clr	a
                                    224 ;	./src/gpio.c: 100: }
      008333 81               [ 4]  225 	ret
                                    226 ;	./src/gpio.c: 102: uint8_t btn_r_minus_is_pressed() {
                                    227 ;	-----------------------------------------
                                    228 ;	 function btn_r_minus_is_pressed
                                    229 ;	-----------------------------------------
      008334                        230 _btn_r_minus_is_pressed:
                                    231 ;	./src/gpio.c: 103: return((1 << 7) == (~PC_IDR & (1 << 7)));
      008334 C6 50 0B         [ 1]  232 	ld	a, 0x500b
      008337 5F               [ 1]  233 	clrw	x
      008338 97               [ 1]  234 	ld	xl, a
      008339 53               [ 2]  235 	cplw	x
      00833A 9F               [ 1]  236 	ld	a, xl
      00833B A4 80            [ 1]  237 	and	a, #0x80
      00833D 97               [ 1]  238 	ld	xl, a
      00833E 4F               [ 1]  239 	clr	a
      00833F 95               [ 1]  240 	ld	xh, a
      008340 A3 00 80         [ 2]  241 	cpw	x, #0x0080
      008343 26 03            [ 1]  242 	jrne	00104$
      008345 A6 01            [ 1]  243 	ld	a, #0x01
      008347 81               [ 4]  244 	ret
      008348                        245 00104$:
      008348 4F               [ 1]  246 	clr	a
                                    247 ;	./src/gpio.c: 104: }
      008349 81               [ 4]  248 	ret
                                    249 ;	./src/gpio.c: 106: uint8_t btn_g_minus_is_pressed() {
                                    250 ;	-----------------------------------------
                                    251 ;	 function btn_g_minus_is_pressed
                                    252 ;	-----------------------------------------
      00834A                        253 _btn_g_minus_is_pressed:
                                    254 ;	./src/gpio.c: 107: return((1 << 5) == (~PC_IDR & (1 << 5)));
      00834A C6 50 0B         [ 1]  255 	ld	a, 0x500b
      00834D 5F               [ 1]  256 	clrw	x
      00834E 97               [ 1]  257 	ld	xl, a
      00834F 53               [ 2]  258 	cplw	x
      008350 9F               [ 1]  259 	ld	a, xl
      008351 A4 20            [ 1]  260 	and	a, #0x20
      008353 97               [ 1]  261 	ld	xl, a
      008354 4F               [ 1]  262 	clr	a
      008355 95               [ 1]  263 	ld	xh, a
      008356 A3 00 20         [ 2]  264 	cpw	x, #0x0020
      008359 26 03            [ 1]  265 	jrne	00104$
      00835B A6 01            [ 1]  266 	ld	a, #0x01
      00835D 81               [ 4]  267 	ret
      00835E                        268 00104$:
      00835E 4F               [ 1]  269 	clr	a
                                    270 ;	./src/gpio.c: 108: }
      00835F 81               [ 4]  271 	ret
                                    272 ;	./src/gpio.c: 110: uint8_t btn_b_minus_is_pressed() {
                                    273 ;	-----------------------------------------
                                    274 ;	 function btn_b_minus_is_pressed
                                    275 ;	-----------------------------------------
      008360                        276 _btn_b_minus_is_pressed:
                                    277 ;	./src/gpio.c: 111: return((1 << 3) == (~PC_IDR & (1 << 3)));
      008360 C6 50 0B         [ 1]  278 	ld	a, 0x500b
      008363 5F               [ 1]  279 	clrw	x
      008364 97               [ 1]  280 	ld	xl, a
      008365 53               [ 2]  281 	cplw	x
      008366 9F               [ 1]  282 	ld	a, xl
      008367 A4 08            [ 1]  283 	and	a, #0x08
      008369 97               [ 1]  284 	ld	xl, a
      00836A 4F               [ 1]  285 	clr	a
      00836B 95               [ 1]  286 	ld	xh, a
      00836C A3 00 08         [ 2]  287 	cpw	x, #0x0008
      00836F 26 03            [ 1]  288 	jrne	00104$
      008371 A6 01            [ 1]  289 	ld	a, #0x01
      008373 81               [ 4]  290 	ret
      008374                        291 00104$:
      008374 4F               [ 1]  292 	clr	a
                                    293 ;	./src/gpio.c: 112: }
      008375 81               [ 4]  294 	ret
                                    295 ;	./src/gpio.c: 114: uint8_t btn_flash_is_pressed() {
                                    296 ;	-----------------------------------------
                                    297 ;	 function btn_flash_is_pressed
                                    298 ;	-----------------------------------------
      008376                        299 _btn_flash_is_pressed:
                                    300 ;	./src/gpio.c: 115: return((1 << 4) == (~PB_IDR & (1 << 4)));
      008376 C6 50 06         [ 1]  301 	ld	a, 0x5006
      008379 5F               [ 1]  302 	clrw	x
      00837A 97               [ 1]  303 	ld	xl, a
      00837B 53               [ 2]  304 	cplw	x
      00837C 9F               [ 1]  305 	ld	a, xl
      00837D A4 10            [ 1]  306 	and	a, #0x10
      00837F 97               [ 1]  307 	ld	xl, a
      008380 4F               [ 1]  308 	clr	a
      008381 95               [ 1]  309 	ld	xh, a
      008382 A3 00 10         [ 2]  310 	cpw	x, #0x0010
      008385 26 03            [ 1]  311 	jrne	00104$
      008387 A6 01            [ 1]  312 	ld	a, #0x01
      008389 81               [ 4]  313 	ret
      00838A                        314 00104$:
      00838A 4F               [ 1]  315 	clr	a
                                    316 ;	./src/gpio.c: 116: }
      00838B 81               [ 4]  317 	ret
                                    318 ;	./src/gpio.c: 118: uint8_t btn_load_is_pressed() {
                                    319 ;	-----------------------------------------
                                    320 ;	 function btn_load_is_pressed
                                    321 ;	-----------------------------------------
      00838C                        322 _btn_load_is_pressed:
                                    323 ;	./src/gpio.c: 119: return((1 << 5) == (~PB_IDR & (1 << 5)));
      00838C C6 50 06         [ 1]  324 	ld	a, 0x5006
      00838F 5F               [ 1]  325 	clrw	x
      008390 97               [ 1]  326 	ld	xl, a
      008391 53               [ 2]  327 	cplw	x
      008392 9F               [ 1]  328 	ld	a, xl
      008393 A4 20            [ 1]  329 	and	a, #0x20
      008395 97               [ 1]  330 	ld	xl, a
      008396 4F               [ 1]  331 	clr	a
      008397 95               [ 1]  332 	ld	xh, a
      008398 A3 00 20         [ 2]  333 	cpw	x, #0x0020
      00839B 26 03            [ 1]  334 	jrne	00104$
      00839D A6 01            [ 1]  335 	ld	a, #0x01
      00839F 81               [ 4]  336 	ret
      0083A0                        337 00104$:
      0083A0 4F               [ 1]  338 	clr	a
                                    339 ;	./src/gpio.c: 120: }
      0083A1 81               [ 4]  340 	ret
                                    341 ;	./src/gpio.c: 122: static void delay(uint16_t t) {
                                    342 ;	-----------------------------------------
                                    343 ;	 function delay
                                    344 ;	-----------------------------------------
      0083A2                        345 _delay:
                                    346 ;	./src/gpio.c: 123: while(t--) {};
      0083A2                        347 00101$:
      0083A2 90 93            [ 1]  348 	ldw	y, x
      0083A4 5A               [ 2]  349 	decw	x
      0083A5 90 5D            [ 2]  350 	tnzw	y
      0083A7 26 F9            [ 1]  351 	jrne	00101$
                                    352 ;	./src/gpio.c: 124: }
      0083A9 81               [ 4]  353 	ret
                                    354 ;	./src/gpio.c: 126: uint8_t get_number_from_buttons() {
                                    355 ;	-----------------------------------------
                                    356 ;	 function get_number_from_buttons
                                    357 ;	-----------------------------------------
      0083AA                        358 _get_number_from_buttons:
      0083AA 88               [ 1]  359 	push	a
                                    360 ;	./src/gpio.c: 127: uint8_t number = 0;
      0083AB 0F 01            [ 1]  361 	clr	(0x01, sp)
                                    362 ;	./src/gpio.c: 129: while(1) { // In future should be added timeout
      0083AD                        363 00116$:
                                    364 ;	./src/gpio.c: 130: delay(65535);
      0083AD 5F               [ 1]  365 	clrw	x
      0083AE 5A               [ 2]  366 	decw	x
      0083AF CD 83 A2         [ 4]  367 	call	_delay
                                    368 ;	./src/gpio.c: 132: if(btn_r_plus_is_pressed()) {
      0083B2 CD 82 F2         [ 4]  369 	call	_btn_r_plus_is_pressed
      0083B5 4D               [ 1]  370 	tnz	a
      0083B6 27 06            [ 1]  371 	jreq	00102$
                                    372 ;	./src/gpio.c: 133: number |= (1 << 5);
      0083B8 7B 01            [ 1]  373 	ld	a, (0x01, sp)
      0083BA AA 20            [ 1]  374 	or	a, #0x20
      0083BC 6B 01            [ 1]  375 	ld	(0x01, sp), a
      0083BE                        376 00102$:
                                    377 ;	./src/gpio.c: 136: if(btn_g_plus_is_pressed()) {
      0083BE CD 83 08         [ 4]  378 	call	_btn_g_plus_is_pressed
      0083C1 4D               [ 1]  379 	tnz	a
      0083C2 27 06            [ 1]  380 	jreq	00104$
                                    381 ;	./src/gpio.c: 137: number |= (1 << 4);
      0083C4 7B 01            [ 1]  382 	ld	a, (0x01, sp)
      0083C6 AA 10            [ 1]  383 	or	a, #0x10
      0083C8 6B 01            [ 1]  384 	ld	(0x01, sp), a
      0083CA                        385 00104$:
                                    386 ;	./src/gpio.c: 140: if(btn_b_plus_is_pressed()) {
      0083CA CD 83 1E         [ 4]  387 	call	_btn_b_plus_is_pressed
      0083CD 4D               [ 1]  388 	tnz	a
      0083CE 27 06            [ 1]  389 	jreq	00106$
                                    390 ;	./src/gpio.c: 141: number |= (1 << 3);
      0083D0 7B 01            [ 1]  391 	ld	a, (0x01, sp)
      0083D2 AA 08            [ 1]  392 	or	a, #0x08
      0083D4 6B 01            [ 1]  393 	ld	(0x01, sp), a
      0083D6                        394 00106$:
                                    395 ;	./src/gpio.c: 144: if(btn_r_minus_is_pressed()) {
      0083D6 CD 83 34         [ 4]  396 	call	_btn_r_minus_is_pressed
      0083D9 4D               [ 1]  397 	tnz	a
      0083DA 27 06            [ 1]  398 	jreq	00108$
                                    399 ;	./src/gpio.c: 145: number |= (1 << 2);
      0083DC 7B 01            [ 1]  400 	ld	a, (0x01, sp)
      0083DE AA 04            [ 1]  401 	or	a, #0x04
      0083E0 6B 01            [ 1]  402 	ld	(0x01, sp), a
      0083E2                        403 00108$:
                                    404 ;	./src/gpio.c: 148: if(btn_g_minus_is_pressed()) {
      0083E2 CD 83 4A         [ 4]  405 	call	_btn_g_minus_is_pressed
      0083E5 4D               [ 1]  406 	tnz	a
      0083E6 27 06            [ 1]  407 	jreq	00110$
                                    408 ;	./src/gpio.c: 149: number |= (1 << 1);
      0083E8 7B 01            [ 1]  409 	ld	a, (0x01, sp)
      0083EA AA 02            [ 1]  410 	or	a, #0x02
      0083EC 6B 01            [ 1]  411 	ld	(0x01, sp), a
      0083EE                        412 00110$:
                                    413 ;	./src/gpio.c: 152: if(btn_b_minus_is_pressed()) {
      0083EE CD 83 60         [ 4]  414 	call	_btn_b_minus_is_pressed
      0083F1 4D               [ 1]  415 	tnz	a
      0083F2 27 05            [ 1]  416 	jreq	00112$
                                    417 ;	./src/gpio.c: 153: number |= (1 << 0);
      0083F4 04 01            [ 1]  418 	srl	(0x01, sp)
      0083F6 99               [ 1]  419 	scf
      0083F7 09 01            [ 1]  420 	rlc	(0x01, sp)
      0083F9                        421 00112$:
                                    422 ;	./src/gpio.c: 159: if(btn_load_is_pressed()) {
      0083F9 CD 83 8C         [ 4]  423 	call	_btn_load_is_pressed
      0083FC 4D               [ 1]  424 	tnz	a
      0083FD 27 AE            [ 1]  425 	jreq	00116$
                                    426 ;	./src/gpio.c: 164: return number;
      0083FF 7B 01            [ 1]  427 	ld	a, (0x01, sp)
                                    428 ;	./src/gpio.c: 165: }
      008401 5B 01            [ 2]  429 	addw	sp, #1
      008403 81               [ 4]  430 	ret
                                    431 	.area CODE
                                    432 	.area CONST
                                    433 	.area INITIALIZER
                                    434 	.area CABS (ABS)
