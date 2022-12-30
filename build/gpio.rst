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
      008298                         62 _gpio_init:
                                     63 ;	./src/gpio.c: 6: PB_DDR |= (1 << 5);
      008298 72 1A 50 07      [ 1]   64 	bset	0x5007, #5
                                     65 ;	./src/gpio.c: 7: PB_CR1 |= (1 << 5);
      00829C 72 1A 50 08      [ 1]   66 	bset	0x5008, #5
                                     67 ;	./src/gpio.c: 8: PB_CR2 &= ~(1 << 5);
      0082A0 72 1B 50 09      [ 1]   68 	bres	0x5009, #5
                                     69 ;	./src/gpio.c: 9: PB_ODR |= (1 << 5);
      0082A4 72 1A 50 05      [ 1]   70 	bset	0x5005, #5
                                     71 ;	./src/gpio.c: 13: PD_DDR |= (1 << 4);
      0082A8 72 18 50 11      [ 1]   72 	bset	0x5011, #4
                                     73 ;	./src/gpio.c: 14: PD_CR1 |= (1 << 4);
      0082AC 72 18 50 12      [ 1]   74 	bset	0x5012, #4
                                     75 ;	./src/gpio.c: 15: PD_CR2 &= ~(1 << 4);
      0082B0 72 19 50 13      [ 1]   76 	bres	0x5013, #4
                                     77 ;	./src/gpio.c: 16: PD_ODR &= ~(1 << 4);
      0082B4 72 19 50 0F      [ 1]   78 	bres	0x500f, #4
                                     79 ;	./src/gpio.c: 20: PD_DDR |= (1 << 3);
      0082B8 72 16 50 11      [ 1]   80 	bset	0x5011, #3
                                     81 ;	./src/gpio.c: 21: PD_CR1 |= (1 << 3);
      0082BC 72 16 50 12      [ 1]   82 	bset	0x5012, #3
                                     83 ;	./src/gpio.c: 22: PD_CR2 &= ~(1 << 3);
      0082C0 72 17 50 13      [ 1]   84 	bres	0x5013, #3
                                     85 ;	./src/gpio.c: 23: PD_ODR &= ~(1 << 3);
      0082C4 72 17 50 0F      [ 1]   86 	bres	0x500f, #3
                                     87 ;	./src/gpio.c: 27: PA_DDR |= (1 << 3);
      0082C8 72 16 50 02      [ 1]   88 	bset	0x5002, #3
                                     89 ;	./src/gpio.c: 28: PA_CR1 |= (1 << 3);
      0082CC 72 16 50 03      [ 1]   90 	bset	0x5003, #3
                                     91 ;	./src/gpio.c: 29: PA_CR2 &= ~(1 << 3);
      0082D0 72 17 50 04      [ 1]   92 	bres	0x5004, #3
                                     93 ;	./src/gpio.c: 30: PA_ODR &= ~(1 << 3);
      0082D4 72 17 50 00      [ 1]   94 	bres	0x5000, #3
                                     95 ;	./src/gpio.c: 44: PD_DDR &= ~(1 << 2); // Input 
      0082D8 72 15 50 11      [ 1]   96 	bres	0x5011, #2
                                     97 ;	./src/gpio.c: 45: PD_CR1 |= (1 << 2); // Pull-Up
      0082DC 72 14 50 12      [ 1]   98 	bset	0x5012, #2
                                     99 ;	./src/gpio.c: 46: PD_CR2 &= ~(1 << 2); // Interrupt disabled
      0082E0 72 15 50 13      [ 1]  100 	bres	0x5013, #2
                                    101 ;	./src/gpio.c: 48: PC_DDR &= ~(1 << 7);
      0082E4 72 1F 50 0C      [ 1]  102 	bres	0x500c, #7
                                    103 ;	./src/gpio.c: 49: PC_CR1 |= (1 << 7);
      0082E8 72 1E 50 0D      [ 1]  104 	bset	0x500d, #7
                                    105 ;	./src/gpio.c: 50: PC_CR2 &= ~(1 << 7);
      0082EC 72 1F 50 0E      [ 1]  106 	bres	0x500e, #7
                                    107 ;	./src/gpio.c: 52: PC_DDR &= ~(1 << 6);
      0082F0 72 1D 50 0C      [ 1]  108 	bres	0x500c, #6
                                    109 ;	./src/gpio.c: 53: PC_CR1 |= (1 << 6);
      0082F4 72 1C 50 0D      [ 1]  110 	bset	0x500d, #6
                                    111 ;	./src/gpio.c: 54: PC_CR2 &= ~(1 << 6);
      0082F8 72 1D 50 0E      [ 1]  112 	bres	0x500e, #6
                                    113 ;	./src/gpio.c: 56: PC_DDR &= ~(1 << 5);
      0082FC 72 1B 50 0C      [ 1]  114 	bres	0x500c, #5
                                    115 ;	./src/gpio.c: 57: PC_CR1 |= (1 << 5);
      008300 72 1A 50 0D      [ 1]  116 	bset	0x500d, #5
                                    117 ;	./src/gpio.c: 58: PC_CR2 &= ~(1 << 5);
      008304 72 1B 50 0E      [ 1]  118 	bres	0x500e, #5
                                    119 ;	./src/gpio.c: 60: PC_DDR &= ~(1 << 4);
      008308 72 19 50 0C      [ 1]  120 	bres	0x500c, #4
                                    121 ;	./src/gpio.c: 61: PC_CR1 |= (1 << 4);
      00830C 72 18 50 0D      [ 1]  122 	bset	0x500d, #4
                                    123 ;	./src/gpio.c: 62: PC_CR2 &= ~(1 << 4);
      008310 72 19 50 0E      [ 1]  124 	bres	0x500e, #4
                                    125 ;	./src/gpio.c: 64: PC_DDR &= ~(1 << 3);
      008314 72 17 50 0C      [ 1]  126 	bres	0x500c, #3
                                    127 ;	./src/gpio.c: 65: PC_CR1 |= (1 << 3);
      008318 72 16 50 0D      [ 1]  128 	bset	0x500d, #3
                                    129 ;	./src/gpio.c: 66: PC_CR2 &= ~(1 << 3);
      00831C 72 17 50 0E      [ 1]  130 	bres	0x500e, #3
                                    131 ;	./src/gpio.c: 69: PB_DDR &= ~(1 << 4);
      008320 72 19 50 07      [ 1]  132 	bres	0x5007, #4
                                    133 ;	./src/gpio.c: 70: PB_CR1 |= (1 << 4);
      008324 72 18 50 08      [ 1]  134 	bset	0x5008, #4
                                    135 ;	./src/gpio.c: 71: PB_CR2 &= ~(1 << 4);
      008328 72 19 50 09      [ 1]  136 	bres	0x5009, #4
                                    137 ;	./src/gpio.c: 73: PB_DDR &= ~(1 << 5);
      00832C 72 1B 50 07      [ 1]  138 	bres	0x5007, #5
                                    139 ;	./src/gpio.c: 74: PB_CR1 |= (1 << 5);
      008330 72 1A 50 08      [ 1]  140 	bset	0x5008, #5
                                    141 ;	./src/gpio.c: 75: PB_CR2 &= ~(1 << 5);
      008334 72 1B 50 09      [ 1]  142 	bres	0x5009, #5
                                    143 ;	./src/gpio.c: 80: PD_DDR |= (1 << 5); // Output
      008338 72 1A 50 11      [ 1]  144 	bset	0x5011, #5
                                    145 ;	./src/gpio.c: 81: PD_CR1 |= (1 << 5); // PushPull
      00833C 72 1A 50 12      [ 1]  146 	bset	0x5012, #5
                                    147 ;	./src/gpio.c: 82: PD_CR2 &= ~(1 << 5); // To 2MHz
      008340 72 1B 50 13      [ 1]  148 	bres	0x5013, #5
                                    149 ;	./src/gpio.c: 85: PD_DDR &= ~(1 << 6); // Input
      008344 72 1D 50 11      [ 1]  150 	bres	0x5011, #6
                                    151 ;	./src/gpio.c: 86: PD_CR1 &= ~(1 << 6); // Floating
      008348 72 1D 50 12      [ 1]  152 	bres	0x5012, #6
                                    153 ;	./src/gpio.c: 87: PD_CR2 &= ~(1 << 6); // External interrupt disabled
      00834C 72 1D 50 13      [ 1]  154 	bres	0x5013, #6
                                    155 ;	./src/gpio.c: 88: }
      008350 81               [ 4]  156 	ret
                                    157 ;	./src/gpio.c: 90: uint8_t btn_r_plus_is_pressed() {
                                    158 ;	-----------------------------------------
                                    159 ;	 function btn_r_plus_is_pressed
                                    160 ;	-----------------------------------------
      008351                        161 _btn_r_plus_is_pressed:
                                    162 ;	./src/gpio.c: 91: return((1 << 2) == (~PD_IDR & (1 << 2)));
      008351 C6 50 10         [ 1]  163 	ld	a, 0x5010
      008354 5F               [ 1]  164 	clrw	x
      008355 97               [ 1]  165 	ld	xl, a
      008356 53               [ 2]  166 	cplw	x
      008357 9F               [ 1]  167 	ld	a, xl
      008358 A4 04            [ 1]  168 	and	a, #0x04
      00835A 97               [ 1]  169 	ld	xl, a
      00835B 4F               [ 1]  170 	clr	a
      00835C 95               [ 1]  171 	ld	xh, a
      00835D A3 00 04         [ 2]  172 	cpw	x, #0x0004
      008360 26 03            [ 1]  173 	jrne	00104$
      008362 A6 01            [ 1]  174 	ld	a, #0x01
      008364 81               [ 4]  175 	ret
      008365                        176 00104$:
      008365 4F               [ 1]  177 	clr	a
                                    178 ;	./src/gpio.c: 92: }
      008366 81               [ 4]  179 	ret
                                    180 ;	./src/gpio.c: 94: uint8_t btn_g_plus_is_pressed() {
                                    181 ;	-----------------------------------------
                                    182 ;	 function btn_g_plus_is_pressed
                                    183 ;	-----------------------------------------
      008367                        184 _btn_g_plus_is_pressed:
                                    185 ;	./src/gpio.c: 95: return((1 << 6) == (~PC_IDR & (1 << 6)));
      008367 C6 50 0B         [ 1]  186 	ld	a, 0x500b
      00836A 5F               [ 1]  187 	clrw	x
      00836B 97               [ 1]  188 	ld	xl, a
      00836C 53               [ 2]  189 	cplw	x
      00836D 9F               [ 1]  190 	ld	a, xl
      00836E A4 40            [ 1]  191 	and	a, #0x40
      008370 97               [ 1]  192 	ld	xl, a
      008371 4F               [ 1]  193 	clr	a
      008372 95               [ 1]  194 	ld	xh, a
      008373 A3 00 40         [ 2]  195 	cpw	x, #0x0040
      008376 26 03            [ 1]  196 	jrne	00104$
      008378 A6 01            [ 1]  197 	ld	a, #0x01
      00837A 81               [ 4]  198 	ret
      00837B                        199 00104$:
      00837B 4F               [ 1]  200 	clr	a
                                    201 ;	./src/gpio.c: 96: }
      00837C 81               [ 4]  202 	ret
                                    203 ;	./src/gpio.c: 98: uint8_t btn_b_plus_is_pressed() {
                                    204 ;	-----------------------------------------
                                    205 ;	 function btn_b_plus_is_pressed
                                    206 ;	-----------------------------------------
      00837D                        207 _btn_b_plus_is_pressed:
                                    208 ;	./src/gpio.c: 99: return((1 << 4) == (~PC_IDR & (1 << 4)));
      00837D C6 50 0B         [ 1]  209 	ld	a, 0x500b
      008380 5F               [ 1]  210 	clrw	x
      008381 97               [ 1]  211 	ld	xl, a
      008382 53               [ 2]  212 	cplw	x
      008383 9F               [ 1]  213 	ld	a, xl
      008384 A4 10            [ 1]  214 	and	a, #0x10
      008386 97               [ 1]  215 	ld	xl, a
      008387 4F               [ 1]  216 	clr	a
      008388 95               [ 1]  217 	ld	xh, a
      008389 A3 00 10         [ 2]  218 	cpw	x, #0x0010
      00838C 26 03            [ 1]  219 	jrne	00104$
      00838E A6 01            [ 1]  220 	ld	a, #0x01
      008390 81               [ 4]  221 	ret
      008391                        222 00104$:
      008391 4F               [ 1]  223 	clr	a
                                    224 ;	./src/gpio.c: 100: }
      008392 81               [ 4]  225 	ret
                                    226 ;	./src/gpio.c: 102: uint8_t btn_r_minus_is_pressed() {
                                    227 ;	-----------------------------------------
                                    228 ;	 function btn_r_minus_is_pressed
                                    229 ;	-----------------------------------------
      008393                        230 _btn_r_minus_is_pressed:
                                    231 ;	./src/gpio.c: 103: return((1 << 7) == (~PC_IDR & (1 << 7)));
      008393 C6 50 0B         [ 1]  232 	ld	a, 0x500b
      008396 5F               [ 1]  233 	clrw	x
      008397 97               [ 1]  234 	ld	xl, a
      008398 53               [ 2]  235 	cplw	x
      008399 9F               [ 1]  236 	ld	a, xl
      00839A A4 80            [ 1]  237 	and	a, #0x80
      00839C 97               [ 1]  238 	ld	xl, a
      00839D 4F               [ 1]  239 	clr	a
      00839E 95               [ 1]  240 	ld	xh, a
      00839F A3 00 80         [ 2]  241 	cpw	x, #0x0080
      0083A2 26 03            [ 1]  242 	jrne	00104$
      0083A4 A6 01            [ 1]  243 	ld	a, #0x01
      0083A6 81               [ 4]  244 	ret
      0083A7                        245 00104$:
      0083A7 4F               [ 1]  246 	clr	a
                                    247 ;	./src/gpio.c: 104: }
      0083A8 81               [ 4]  248 	ret
                                    249 ;	./src/gpio.c: 106: uint8_t btn_g_minus_is_pressed() {
                                    250 ;	-----------------------------------------
                                    251 ;	 function btn_g_minus_is_pressed
                                    252 ;	-----------------------------------------
      0083A9                        253 _btn_g_minus_is_pressed:
                                    254 ;	./src/gpio.c: 107: return((1 << 5) == (~PC_IDR & (1 << 5)));
      0083A9 C6 50 0B         [ 1]  255 	ld	a, 0x500b
      0083AC 5F               [ 1]  256 	clrw	x
      0083AD 97               [ 1]  257 	ld	xl, a
      0083AE 53               [ 2]  258 	cplw	x
      0083AF 9F               [ 1]  259 	ld	a, xl
      0083B0 A4 20            [ 1]  260 	and	a, #0x20
      0083B2 97               [ 1]  261 	ld	xl, a
      0083B3 4F               [ 1]  262 	clr	a
      0083B4 95               [ 1]  263 	ld	xh, a
      0083B5 A3 00 20         [ 2]  264 	cpw	x, #0x0020
      0083B8 26 03            [ 1]  265 	jrne	00104$
      0083BA A6 01            [ 1]  266 	ld	a, #0x01
      0083BC 81               [ 4]  267 	ret
      0083BD                        268 00104$:
      0083BD 4F               [ 1]  269 	clr	a
                                    270 ;	./src/gpio.c: 108: }
      0083BE 81               [ 4]  271 	ret
                                    272 ;	./src/gpio.c: 110: uint8_t btn_b_minus_is_pressed() {
                                    273 ;	-----------------------------------------
                                    274 ;	 function btn_b_minus_is_pressed
                                    275 ;	-----------------------------------------
      0083BF                        276 _btn_b_minus_is_pressed:
                                    277 ;	./src/gpio.c: 111: return((1 << 3) == (~PC_IDR & (1 << 3)));
      0083BF C6 50 0B         [ 1]  278 	ld	a, 0x500b
      0083C2 5F               [ 1]  279 	clrw	x
      0083C3 97               [ 1]  280 	ld	xl, a
      0083C4 53               [ 2]  281 	cplw	x
      0083C5 9F               [ 1]  282 	ld	a, xl
      0083C6 A4 08            [ 1]  283 	and	a, #0x08
      0083C8 97               [ 1]  284 	ld	xl, a
      0083C9 4F               [ 1]  285 	clr	a
      0083CA 95               [ 1]  286 	ld	xh, a
      0083CB A3 00 08         [ 2]  287 	cpw	x, #0x0008
      0083CE 26 03            [ 1]  288 	jrne	00104$
      0083D0 A6 01            [ 1]  289 	ld	a, #0x01
      0083D2 81               [ 4]  290 	ret
      0083D3                        291 00104$:
      0083D3 4F               [ 1]  292 	clr	a
                                    293 ;	./src/gpio.c: 112: }
      0083D4 81               [ 4]  294 	ret
                                    295 ;	./src/gpio.c: 114: uint8_t btn_flash_is_pressed() {
                                    296 ;	-----------------------------------------
                                    297 ;	 function btn_flash_is_pressed
                                    298 ;	-----------------------------------------
      0083D5                        299 _btn_flash_is_pressed:
                                    300 ;	./src/gpio.c: 115: return((1 << 4) == (~PB_IDR & (1 << 4)));
      0083D5 C6 50 06         [ 1]  301 	ld	a, 0x5006
      0083D8 5F               [ 1]  302 	clrw	x
      0083D9 97               [ 1]  303 	ld	xl, a
      0083DA 53               [ 2]  304 	cplw	x
      0083DB 9F               [ 1]  305 	ld	a, xl
      0083DC A4 10            [ 1]  306 	and	a, #0x10
      0083DE 97               [ 1]  307 	ld	xl, a
      0083DF 4F               [ 1]  308 	clr	a
      0083E0 95               [ 1]  309 	ld	xh, a
      0083E1 A3 00 10         [ 2]  310 	cpw	x, #0x0010
      0083E4 26 03            [ 1]  311 	jrne	00104$
      0083E6 A6 01            [ 1]  312 	ld	a, #0x01
      0083E8 81               [ 4]  313 	ret
      0083E9                        314 00104$:
      0083E9 4F               [ 1]  315 	clr	a
                                    316 ;	./src/gpio.c: 116: }
      0083EA 81               [ 4]  317 	ret
                                    318 ;	./src/gpio.c: 118: uint8_t btn_load_is_pressed() {
                                    319 ;	-----------------------------------------
                                    320 ;	 function btn_load_is_pressed
                                    321 ;	-----------------------------------------
      0083EB                        322 _btn_load_is_pressed:
                                    323 ;	./src/gpio.c: 119: return((1 << 5) == (~PB_IDR & (1 << 5)));
      0083EB C6 50 06         [ 1]  324 	ld	a, 0x5006
      0083EE 5F               [ 1]  325 	clrw	x
      0083EF 97               [ 1]  326 	ld	xl, a
      0083F0 53               [ 2]  327 	cplw	x
      0083F1 9F               [ 1]  328 	ld	a, xl
      0083F2 A4 20            [ 1]  329 	and	a, #0x20
      0083F4 97               [ 1]  330 	ld	xl, a
      0083F5 4F               [ 1]  331 	clr	a
      0083F6 95               [ 1]  332 	ld	xh, a
      0083F7 A3 00 20         [ 2]  333 	cpw	x, #0x0020
      0083FA 26 03            [ 1]  334 	jrne	00104$
      0083FC A6 01            [ 1]  335 	ld	a, #0x01
      0083FE 81               [ 4]  336 	ret
      0083FF                        337 00104$:
      0083FF 4F               [ 1]  338 	clr	a
                                    339 ;	./src/gpio.c: 120: }
      008400 81               [ 4]  340 	ret
                                    341 ;	./src/gpio.c: 122: static void delay(uint16_t t) {
                                    342 ;	-----------------------------------------
                                    343 ;	 function delay
                                    344 ;	-----------------------------------------
      008401                        345 _delay:
                                    346 ;	./src/gpio.c: 123: while(t--) {};
      008401                        347 00101$:
      008401 90 93            [ 1]  348 	ldw	y, x
      008403 5A               [ 2]  349 	decw	x
      008404 90 5D            [ 2]  350 	tnzw	y
      008406 26 F9            [ 1]  351 	jrne	00101$
                                    352 ;	./src/gpio.c: 124: }
      008408 81               [ 4]  353 	ret
                                    354 ;	./src/gpio.c: 126: uint8_t get_number_from_buttons() {
                                    355 ;	-----------------------------------------
                                    356 ;	 function get_number_from_buttons
                                    357 ;	-----------------------------------------
      008409                        358 _get_number_from_buttons:
      008409 88               [ 1]  359 	push	a
                                    360 ;	./src/gpio.c: 127: uint8_t number = 0;
      00840A 0F 01            [ 1]  361 	clr	(0x01, sp)
                                    362 ;	./src/gpio.c: 129: while(1) { // In future should be added timeout
      00840C                        363 00116$:
                                    364 ;	./src/gpio.c: 130: delay(65535);
      00840C 5F               [ 1]  365 	clrw	x
      00840D 5A               [ 2]  366 	decw	x
      00840E CD 84 01         [ 4]  367 	call	_delay
                                    368 ;	./src/gpio.c: 132: if(btn_r_plus_is_pressed()) {
      008411 CD 83 51         [ 4]  369 	call	_btn_r_plus_is_pressed
      008414 4D               [ 1]  370 	tnz	a
      008415 27 06            [ 1]  371 	jreq	00102$
                                    372 ;	./src/gpio.c: 133: number |= (1 << 5);
      008417 7B 01            [ 1]  373 	ld	a, (0x01, sp)
      008419 AA 20            [ 1]  374 	or	a, #0x20
      00841B 6B 01            [ 1]  375 	ld	(0x01, sp), a
      00841D                        376 00102$:
                                    377 ;	./src/gpio.c: 136: if(btn_g_plus_is_pressed()) {
      00841D CD 83 67         [ 4]  378 	call	_btn_g_plus_is_pressed
      008420 4D               [ 1]  379 	tnz	a
      008421 27 06            [ 1]  380 	jreq	00104$
                                    381 ;	./src/gpio.c: 137: number |= (1 << 4);
      008423 7B 01            [ 1]  382 	ld	a, (0x01, sp)
      008425 AA 10            [ 1]  383 	or	a, #0x10
      008427 6B 01            [ 1]  384 	ld	(0x01, sp), a
      008429                        385 00104$:
                                    386 ;	./src/gpio.c: 140: if(btn_b_plus_is_pressed()) {
      008429 CD 83 7D         [ 4]  387 	call	_btn_b_plus_is_pressed
      00842C 4D               [ 1]  388 	tnz	a
      00842D 27 06            [ 1]  389 	jreq	00106$
                                    390 ;	./src/gpio.c: 141: number |= (1 << 3);
      00842F 7B 01            [ 1]  391 	ld	a, (0x01, sp)
      008431 AA 08            [ 1]  392 	or	a, #0x08
      008433 6B 01            [ 1]  393 	ld	(0x01, sp), a
      008435                        394 00106$:
                                    395 ;	./src/gpio.c: 144: if(btn_r_minus_is_pressed()) {
      008435 CD 83 93         [ 4]  396 	call	_btn_r_minus_is_pressed
      008438 4D               [ 1]  397 	tnz	a
      008439 27 06            [ 1]  398 	jreq	00108$
                                    399 ;	./src/gpio.c: 145: number |= (1 << 2);
      00843B 7B 01            [ 1]  400 	ld	a, (0x01, sp)
      00843D AA 04            [ 1]  401 	or	a, #0x04
      00843F 6B 01            [ 1]  402 	ld	(0x01, sp), a
      008441                        403 00108$:
                                    404 ;	./src/gpio.c: 148: if(btn_g_minus_is_pressed()) {
      008441 CD 83 A9         [ 4]  405 	call	_btn_g_minus_is_pressed
      008444 4D               [ 1]  406 	tnz	a
      008445 27 06            [ 1]  407 	jreq	00110$
                                    408 ;	./src/gpio.c: 149: number |= (1 << 1);
      008447 7B 01            [ 1]  409 	ld	a, (0x01, sp)
      008449 AA 02            [ 1]  410 	or	a, #0x02
      00844B 6B 01            [ 1]  411 	ld	(0x01, sp), a
      00844D                        412 00110$:
                                    413 ;	./src/gpio.c: 152: if(btn_b_minus_is_pressed()) {
      00844D CD 83 BF         [ 4]  414 	call	_btn_b_minus_is_pressed
      008450 4D               [ 1]  415 	tnz	a
      008451 27 05            [ 1]  416 	jreq	00112$
                                    417 ;	./src/gpio.c: 153: number |= (1 << 0);
      008453 04 01            [ 1]  418 	srl	(0x01, sp)
      008455 99               [ 1]  419 	scf
      008456 09 01            [ 1]  420 	rlc	(0x01, sp)
      008458                        421 00112$:
                                    422 ;	./src/gpio.c: 159: if(btn_load_is_pressed()) {
      008458 CD 83 EB         [ 4]  423 	call	_btn_load_is_pressed
      00845B 4D               [ 1]  424 	tnz	a
      00845C 27 AE            [ 1]  425 	jreq	00116$
                                    426 ;	./src/gpio.c: 164: return number;
      00845E 7B 01            [ 1]  427 	ld	a, (0x01, sp)
                                    428 ;	./src/gpio.c: 165: }
      008460 5B 01            [ 2]  429 	addw	sp, #1
      008462 81               [ 4]  430 	ret
                                    431 	.area CODE
                                    432 	.area CONST
                                    433 	.area INITIALIZER
                                    434 	.area CABS (ABS)
