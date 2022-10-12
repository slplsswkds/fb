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
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area DATA
                                     24 ;--------------------------------------------------------
                                     25 ; ram data
                                     26 ;--------------------------------------------------------
                                     27 	.area INITIALIZED
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
                                     57 ;	./src/gpio.c: 3: void gpio_init() {
                                     58 ;	-----------------------------------------
                                     59 ;	 function gpio_init
                                     60 ;	-----------------------------------------
      00821F                         61 _gpio_init:
                                     62 ;	./src/gpio.c: 6: PB_DDR |= (1 << 5);
      00821F 72 1A 50 07      [ 1]   63 	bset	0x5007, #5
                                     64 ;	./src/gpio.c: 7: PB_CR1 |= (1 << 5);
      008223 72 1A 50 08      [ 1]   65 	bset	0x5008, #5
                                     66 ;	./src/gpio.c: 8: PB_CR2 &= ~(1 << 5);
      008227 72 1B 50 09      [ 1]   67 	bres	0x5009, #5
                                     68 ;	./src/gpio.c: 9: PB_ODR |= (1 << 5);
      00822B 72 1A 50 05      [ 1]   69 	bset	0x5005, #5
                                     70 ;	./src/gpio.c: 13: PD_DDR |= (1 << 4);
      00822F 72 18 50 11      [ 1]   71 	bset	0x5011, #4
                                     72 ;	./src/gpio.c: 14: PD_CR1 |= (1 << 4);
      008233 72 18 50 12      [ 1]   73 	bset	0x5012, #4
                                     74 ;	./src/gpio.c: 15: PD_CR2 &= ~(1 << 4);
      008237 72 19 50 13      [ 1]   75 	bres	0x5013, #4
                                     76 ;	./src/gpio.c: 16: PD_ODR &= ~(1 << 4);
      00823B 72 19 50 0F      [ 1]   77 	bres	0x500f, #4
                                     78 ;	./src/gpio.c: 20: PD_DDR |= (1 << 3);
      00823F 72 16 50 11      [ 1]   79 	bset	0x5011, #3
                                     80 ;	./src/gpio.c: 21: PD_CR1 |= (1 << 3);
      008243 72 16 50 12      [ 1]   81 	bset	0x5012, #3
                                     82 ;	./src/gpio.c: 22: PD_CR2 &= ~(1 << 3);
      008247 72 17 50 13      [ 1]   83 	bres	0x5013, #3
                                     84 ;	./src/gpio.c: 23: PD_ODR &= ~(1 << 3);
      00824B 72 17 50 0F      [ 1]   85 	bres	0x500f, #3
                                     86 ;	./src/gpio.c: 27: PA_DDR |= (1 << 3);
      00824F 72 16 50 02      [ 1]   87 	bset	0x5002, #3
                                     88 ;	./src/gpio.c: 28: PA_CR1 |= (1 << 3);
      008253 72 16 50 03      [ 1]   89 	bset	0x5003, #3
                                     90 ;	./src/gpio.c: 29: PA_CR2 &= ~(1 << 3);
      008257 72 17 50 04      [ 1]   91 	bres	0x5004, #3
                                     92 ;	./src/gpio.c: 30: PA_ODR &= ~(1 << 3);
      00825B 72 17 50 00      [ 1]   93 	bres	0x5000, #3
                                     94 ;	./src/gpio.c: 44: PD_DDR &= ~(1 << 2); // Input 
      00825F 72 15 50 11      [ 1]   95 	bres	0x5011, #2
                                     96 ;	./src/gpio.c: 45: PD_CR1 |= (1 << 2); // Pull-Up
      008263 72 14 50 12      [ 1]   97 	bset	0x5012, #2
                                     98 ;	./src/gpio.c: 46: PD_CR2 &= ~(1 << 2); // Interrupt disabled
      008267 72 15 50 13      [ 1]   99 	bres	0x5013, #2
                                    100 ;	./src/gpio.c: 48: PC_DDR &= ~(1 << 7);
      00826B 72 1F 50 0C      [ 1]  101 	bres	0x500c, #7
                                    102 ;	./src/gpio.c: 49: PC_CR1 |= (1 << 7);
      00826F 72 1E 50 0D      [ 1]  103 	bset	0x500d, #7
                                    104 ;	./src/gpio.c: 50: PC_CR2 &= ~(1 << 7);
      008273 72 1F 50 0E      [ 1]  105 	bres	0x500e, #7
                                    106 ;	./src/gpio.c: 52: PC_DDR &= ~(1 << 6);
      008277 72 1D 50 0C      [ 1]  107 	bres	0x500c, #6
                                    108 ;	./src/gpio.c: 53: PC_CR1 |= (1 << 6);
      00827B 72 1C 50 0D      [ 1]  109 	bset	0x500d, #6
                                    110 ;	./src/gpio.c: 54: PC_CR2 &= ~(1 << 6);
      00827F 72 1D 50 0E      [ 1]  111 	bres	0x500e, #6
                                    112 ;	./src/gpio.c: 56: PC_DDR &= ~(1 << 5);
      008283 72 1B 50 0C      [ 1]  113 	bres	0x500c, #5
                                    114 ;	./src/gpio.c: 57: PC_CR1 |= (1 << 5);
      008287 72 1A 50 0D      [ 1]  115 	bset	0x500d, #5
                                    116 ;	./src/gpio.c: 58: PC_CR2 &= ~(1 << 5);
      00828B 72 1B 50 0E      [ 1]  117 	bres	0x500e, #5
                                    118 ;	./src/gpio.c: 60: PC_DDR &= ~(1 << 4);
      00828F 72 19 50 0C      [ 1]  119 	bres	0x500c, #4
                                    120 ;	./src/gpio.c: 61: PC_CR1 |= (1 << 4);
      008293 72 18 50 0D      [ 1]  121 	bset	0x500d, #4
                                    122 ;	./src/gpio.c: 62: PC_CR2 &= ~(1 << 4);
      008297 72 19 50 0E      [ 1]  123 	bres	0x500e, #4
                                    124 ;	./src/gpio.c: 64: PC_DDR &= ~(1 << 3);
      00829B 72 17 50 0C      [ 1]  125 	bres	0x500c, #3
                                    126 ;	./src/gpio.c: 65: PC_CR1 |= (1 << 3);
      00829F 72 16 50 0D      [ 1]  127 	bset	0x500d, #3
                                    128 ;	./src/gpio.c: 66: PC_CR2 &= ~(1 << 3);
      0082A3 72 17 50 0E      [ 1]  129 	bres	0x500e, #3
                                    130 ;	./src/gpio.c: 69: PB_DDR &= ~(1 << 4);
      0082A7 72 19 50 07      [ 1]  131 	bres	0x5007, #4
                                    132 ;	./src/gpio.c: 70: PB_CR1 |= (1 << 4);
      0082AB 72 18 50 08      [ 1]  133 	bset	0x5008, #4
                                    134 ;	./src/gpio.c: 71: PB_CR2 &= ~(1 << 4);
      0082AF 72 19 50 09      [ 1]  135 	bres	0x5009, #4
                                    136 ;	./src/gpio.c: 73: PB_DDR &= ~(1 << 5);
      0082B3 72 1B 50 07      [ 1]  137 	bres	0x5007, #5
                                    138 ;	./src/gpio.c: 74: PB_CR1 |= (1 << 5);
      0082B7 72 1A 50 08      [ 1]  139 	bset	0x5008, #5
                                    140 ;	./src/gpio.c: 75: PB_CR2 &= ~(1 << 5);
      0082BB 72 1B 50 09      [ 1]  141 	bres	0x5009, #5
                                    142 ;	./src/gpio.c: 80: PD_DDR |= (1 << 5); // Output
      0082BF 72 1A 50 11      [ 1]  143 	bset	0x5011, #5
                                    144 ;	./src/gpio.c: 81: PD_CR1 |= (1 << 5); // PushPull
      0082C3 72 1A 50 12      [ 1]  145 	bset	0x5012, #5
                                    146 ;	./src/gpio.c: 82: PD_CR2 &= ~(1 << 5); // To 2MHz
      0082C7 72 1B 50 13      [ 1]  147 	bres	0x5013, #5
                                    148 ;	./src/gpio.c: 85: PD_DDR &= ~(1 << 6); // Input
      0082CB 72 1D 50 11      [ 1]  149 	bres	0x5011, #6
                                    150 ;	./src/gpio.c: 86: PD_CR1 &= ~(1 << 6); // Floating
      0082CF 72 1D 50 12      [ 1]  151 	bres	0x5012, #6
                                    152 ;	./src/gpio.c: 87: PD_CR2 &= ~(1 << 6); // External interrupt disabled
      0082D3 72 1D 50 13      [ 1]  153 	bres	0x5013, #6
                                    154 ;	./src/gpio.c: 88: }
      0082D7 81               [ 4]  155 	ret
                                    156 ;	./src/gpio.c: 90: uint8_t btn_r_plus_is_pressed() {
                                    157 ;	-----------------------------------------
                                    158 ;	 function btn_r_plus_is_pressed
                                    159 ;	-----------------------------------------
      0082D8                        160 _btn_r_plus_is_pressed:
                                    161 ;	./src/gpio.c: 91: return((1 << 2) == (~PD_IDR & (1 << 2)));
      0082D8 C6 50 10         [ 1]  162 	ld	a, 0x5010
      0082DB 5F               [ 1]  163 	clrw	x
      0082DC 97               [ 1]  164 	ld	xl, a
      0082DD 53               [ 2]  165 	cplw	x
      0082DE 9F               [ 1]  166 	ld	a, xl
      0082DF A4 04            [ 1]  167 	and	a, #0x04
      0082E1 97               [ 1]  168 	ld	xl, a
      0082E2 4F               [ 1]  169 	clr	a
      0082E3 95               [ 1]  170 	ld	xh, a
      0082E4 A3 00 04         [ 2]  171 	cpw	x, #0x0004
      0082E7 26 03            [ 1]  172 	jrne	00104$
      0082E9 A6 01            [ 1]  173 	ld	a, #0x01
      0082EB 81               [ 4]  174 	ret
      0082EC                        175 00104$:
      0082EC 4F               [ 1]  176 	clr	a
                                    177 ;	./src/gpio.c: 92: }
      0082ED 81               [ 4]  178 	ret
                                    179 ;	./src/gpio.c: 94: uint8_t btn_g_plus_is_pressed() {
                                    180 ;	-----------------------------------------
                                    181 ;	 function btn_g_plus_is_pressed
                                    182 ;	-----------------------------------------
      0082EE                        183 _btn_g_plus_is_pressed:
                                    184 ;	./src/gpio.c: 95: return((1 << 6) == (~PC_IDR & (1 << 6)));
      0082EE C6 50 0B         [ 1]  185 	ld	a, 0x500b
      0082F1 5F               [ 1]  186 	clrw	x
      0082F2 97               [ 1]  187 	ld	xl, a
      0082F3 53               [ 2]  188 	cplw	x
      0082F4 9F               [ 1]  189 	ld	a, xl
      0082F5 A4 40            [ 1]  190 	and	a, #0x40
      0082F7 97               [ 1]  191 	ld	xl, a
      0082F8 4F               [ 1]  192 	clr	a
      0082F9 95               [ 1]  193 	ld	xh, a
      0082FA A3 00 40         [ 2]  194 	cpw	x, #0x0040
      0082FD 26 03            [ 1]  195 	jrne	00104$
      0082FF A6 01            [ 1]  196 	ld	a, #0x01
      008301 81               [ 4]  197 	ret
      008302                        198 00104$:
      008302 4F               [ 1]  199 	clr	a
                                    200 ;	./src/gpio.c: 96: }
      008303 81               [ 4]  201 	ret
                                    202 ;	./src/gpio.c: 98: uint8_t btn_b_plus_is_pressed() {
                                    203 ;	-----------------------------------------
                                    204 ;	 function btn_b_plus_is_pressed
                                    205 ;	-----------------------------------------
      008304                        206 _btn_b_plus_is_pressed:
                                    207 ;	./src/gpio.c: 99: return((1 << 4) == (~PC_IDR & (1 << 4)));
      008304 C6 50 0B         [ 1]  208 	ld	a, 0x500b
      008307 5F               [ 1]  209 	clrw	x
      008308 97               [ 1]  210 	ld	xl, a
      008309 53               [ 2]  211 	cplw	x
      00830A 9F               [ 1]  212 	ld	a, xl
      00830B A4 10            [ 1]  213 	and	a, #0x10
      00830D 97               [ 1]  214 	ld	xl, a
      00830E 4F               [ 1]  215 	clr	a
      00830F 95               [ 1]  216 	ld	xh, a
      008310 A3 00 10         [ 2]  217 	cpw	x, #0x0010
      008313 26 03            [ 1]  218 	jrne	00104$
      008315 A6 01            [ 1]  219 	ld	a, #0x01
      008317 81               [ 4]  220 	ret
      008318                        221 00104$:
      008318 4F               [ 1]  222 	clr	a
                                    223 ;	./src/gpio.c: 100: }
      008319 81               [ 4]  224 	ret
                                    225 ;	./src/gpio.c: 102: uint8_t btn_r_minus_is_pressed() {
                                    226 ;	-----------------------------------------
                                    227 ;	 function btn_r_minus_is_pressed
                                    228 ;	-----------------------------------------
      00831A                        229 _btn_r_minus_is_pressed:
                                    230 ;	./src/gpio.c: 103: return((1 << 7) == (~PC_IDR & (1 << 7)));
      00831A C6 50 0B         [ 1]  231 	ld	a, 0x500b
      00831D 5F               [ 1]  232 	clrw	x
      00831E 97               [ 1]  233 	ld	xl, a
      00831F 53               [ 2]  234 	cplw	x
      008320 9F               [ 1]  235 	ld	a, xl
      008321 A4 80            [ 1]  236 	and	a, #0x80
      008323 97               [ 1]  237 	ld	xl, a
      008324 4F               [ 1]  238 	clr	a
      008325 95               [ 1]  239 	ld	xh, a
      008326 A3 00 80         [ 2]  240 	cpw	x, #0x0080
      008329 26 03            [ 1]  241 	jrne	00104$
      00832B A6 01            [ 1]  242 	ld	a, #0x01
      00832D 81               [ 4]  243 	ret
      00832E                        244 00104$:
      00832E 4F               [ 1]  245 	clr	a
                                    246 ;	./src/gpio.c: 104: }
      00832F 81               [ 4]  247 	ret
                                    248 ;	./src/gpio.c: 106: uint8_t btn_g_minus_is_pressed() {
                                    249 ;	-----------------------------------------
                                    250 ;	 function btn_g_minus_is_pressed
                                    251 ;	-----------------------------------------
      008330                        252 _btn_g_minus_is_pressed:
                                    253 ;	./src/gpio.c: 107: return((1 << 5) == (~PC_IDR & (1 << 5)));
      008330 C6 50 0B         [ 1]  254 	ld	a, 0x500b
      008333 5F               [ 1]  255 	clrw	x
      008334 97               [ 1]  256 	ld	xl, a
      008335 53               [ 2]  257 	cplw	x
      008336 9F               [ 1]  258 	ld	a, xl
      008337 A4 20            [ 1]  259 	and	a, #0x20
      008339 97               [ 1]  260 	ld	xl, a
      00833A 4F               [ 1]  261 	clr	a
      00833B 95               [ 1]  262 	ld	xh, a
      00833C A3 00 20         [ 2]  263 	cpw	x, #0x0020
      00833F 26 03            [ 1]  264 	jrne	00104$
      008341 A6 01            [ 1]  265 	ld	a, #0x01
      008343 81               [ 4]  266 	ret
      008344                        267 00104$:
      008344 4F               [ 1]  268 	clr	a
                                    269 ;	./src/gpio.c: 108: }
      008345 81               [ 4]  270 	ret
                                    271 ;	./src/gpio.c: 110: uint8_t btn_b_minus_is_pressed() {
                                    272 ;	-----------------------------------------
                                    273 ;	 function btn_b_minus_is_pressed
                                    274 ;	-----------------------------------------
      008346                        275 _btn_b_minus_is_pressed:
                                    276 ;	./src/gpio.c: 111: return((1 << 3) == (~PC_IDR & (1 << 3)));
      008346 C6 50 0B         [ 1]  277 	ld	a, 0x500b
      008349 5F               [ 1]  278 	clrw	x
      00834A 97               [ 1]  279 	ld	xl, a
      00834B 53               [ 2]  280 	cplw	x
      00834C 9F               [ 1]  281 	ld	a, xl
      00834D A4 08            [ 1]  282 	and	a, #0x08
      00834F 97               [ 1]  283 	ld	xl, a
      008350 4F               [ 1]  284 	clr	a
      008351 95               [ 1]  285 	ld	xh, a
      008352 A3 00 08         [ 2]  286 	cpw	x, #0x0008
      008355 26 03            [ 1]  287 	jrne	00104$
      008357 A6 01            [ 1]  288 	ld	a, #0x01
      008359 81               [ 4]  289 	ret
      00835A                        290 00104$:
      00835A 4F               [ 1]  291 	clr	a
                                    292 ;	./src/gpio.c: 112: }
      00835B 81               [ 4]  293 	ret
                                    294 ;	./src/gpio.c: 114: uint8_t btn_flash_is_pressed() {
                                    295 ;	-----------------------------------------
                                    296 ;	 function btn_flash_is_pressed
                                    297 ;	-----------------------------------------
      00835C                        298 _btn_flash_is_pressed:
                                    299 ;	./src/gpio.c: 115: return((1 << 4) == (~PB_IDR & (1 << 4)));
      00835C C6 50 06         [ 1]  300 	ld	a, 0x5006
      00835F 5F               [ 1]  301 	clrw	x
      008360 97               [ 1]  302 	ld	xl, a
      008361 53               [ 2]  303 	cplw	x
      008362 9F               [ 1]  304 	ld	a, xl
      008363 A4 10            [ 1]  305 	and	a, #0x10
      008365 97               [ 1]  306 	ld	xl, a
      008366 4F               [ 1]  307 	clr	a
      008367 95               [ 1]  308 	ld	xh, a
      008368 A3 00 10         [ 2]  309 	cpw	x, #0x0010
      00836B 26 03            [ 1]  310 	jrne	00104$
      00836D A6 01            [ 1]  311 	ld	a, #0x01
      00836F 81               [ 4]  312 	ret
      008370                        313 00104$:
      008370 4F               [ 1]  314 	clr	a
                                    315 ;	./src/gpio.c: 116: }
      008371 81               [ 4]  316 	ret
                                    317 ;	./src/gpio.c: 118: uint8_t btn_load_is_pressed() {
                                    318 ;	-----------------------------------------
                                    319 ;	 function btn_load_is_pressed
                                    320 ;	-----------------------------------------
      008372                        321 _btn_load_is_pressed:
                                    322 ;	./src/gpio.c: 119: return((1 << 5) == (~PB_IDR & (1 << 5)));
      008372 C6 50 06         [ 1]  323 	ld	a, 0x5006
      008375 5F               [ 1]  324 	clrw	x
      008376 97               [ 1]  325 	ld	xl, a
      008377 53               [ 2]  326 	cplw	x
      008378 9F               [ 1]  327 	ld	a, xl
      008379 A4 20            [ 1]  328 	and	a, #0x20
      00837B 97               [ 1]  329 	ld	xl, a
      00837C 4F               [ 1]  330 	clr	a
      00837D 95               [ 1]  331 	ld	xh, a
      00837E A3 00 20         [ 2]  332 	cpw	x, #0x0020
      008381 26 03            [ 1]  333 	jrne	00104$
      008383 A6 01            [ 1]  334 	ld	a, #0x01
      008385 81               [ 4]  335 	ret
      008386                        336 00104$:
      008386 4F               [ 1]  337 	clr	a
                                    338 ;	./src/gpio.c: 120: }
      008387 81               [ 4]  339 	ret
                                    340 	.area CODE
                                    341 	.area CONST
                                    342 	.area INITIALIZER
                                    343 	.area CABS (ABS)
