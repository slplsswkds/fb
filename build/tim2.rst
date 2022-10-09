                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.2.0 #13081 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module tim2
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _tim2_init
                                     12 ;--------------------------------------------------------
                                     13 ; ram data
                                     14 ;--------------------------------------------------------
                                     15 	.area DATA
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area INITIALIZED
                                     20 ;--------------------------------------------------------
                                     21 ; absolute external ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area DABS (ABS)
                                     24 
                                     25 ; default segment ordering for linker
                                     26 	.area HOME
                                     27 	.area GSINIT
                                     28 	.area GSFINAL
                                     29 	.area CONST
                                     30 	.area INITIALIZER
                                     31 	.area CODE
                                     32 
                                     33 ;--------------------------------------------------------
                                     34 ; global & static initialisations
                                     35 ;--------------------------------------------------------
                                     36 	.area HOME
                                     37 	.area GSINIT
                                     38 	.area GSFINAL
                                     39 	.area GSINIT
                                     40 ;--------------------------------------------------------
                                     41 ; Home
                                     42 ;--------------------------------------------------------
                                     43 	.area HOME
                                     44 	.area HOME
                                     45 ;--------------------------------------------------------
                                     46 ; code
                                     47 ;--------------------------------------------------------
                                     48 	.area CODE
                                     49 ;	./src/tim2.c: 3: void tim2_init() {
                                     50 ;	-----------------------------------------
                                     51 ;	 function tim2_init
                                     52 ;	-----------------------------------------
      00817F                         53 _tim2_init:
                                     54 ;	./src/tim2.c: 8: TIM2_PSCR = 0x00; // Prescaler = 1
      00817F 35 00 53 0E      [ 1]   55 	mov	0x530e+0, #0x00
                                     56 ;	./src/tim2.c: 9: TIM2_ARRH = tim2_arrval >> 8;
      008183 35 3E 53 0F      [ 1]   57 	mov	0x530f+0, #0x3e
                                     58 ;	./src/tim2.c: 10: TIM2_ARRL = tim2_arrval & 0x00FF;
      008187 A6 80            [ 1]   59 	ld	a, #0x80
      008189 C7 53 10         [ 1]   60 	ld	0x5310, a
                                     61 ;	./src/tim2.c: 13: TIM2_CCR1H = 0x00;
      00818C 35 00 53 11      [ 1]   62 	mov	0x5311+0, #0x00
                                     63 ;	./src/tim2.c: 14: TIM2_CCR1L = 0x00;
      008190 35 00 53 12      [ 1]   64 	mov	0x5312+0, #0x00
                                     65 ;	./src/tim2.c: 15: TIM2_CCER1 &= ~CC1P; // Active high
      008194 C6 53 0A         [ 1]   66 	ld	a, 0x530a
      008197 A4 FD            [ 1]   67 	and	a, #0xfd
                                     68 ;	./src/tim2.c: 16: TIM2_CCER1 |= CC1E; // Enable CH1 output
      008199 C7 53 0A         [ 1]   69 	ld	0x530a, a
      00819C AA 01            [ 1]   70 	or	a, #0x01
      00819E C7 53 0A         [ 1]   71 	ld	0x530a, a
                                     72 ;	./src/tim2.c: 17: TIM2_CCMR1 |= (0b110 << 4); //PWM mode 1
      0081A1 C6 53 07         [ 1]   73 	ld	a, 0x5307
      0081A4 AA 60            [ 1]   74 	or	a, #0x60
      0081A6 C7 53 07         [ 1]   75 	ld	0x5307, a
                                     76 ;	./src/tim2.c: 20: TIM2_CCR2H = 0x00;
      0081A9 35 00 53 13      [ 1]   77 	mov	0x5313+0, #0x00
                                     78 ;	./src/tim2.c: 21: TIM2_CCR2L = 0x00;
      0081AD 35 00 53 14      [ 1]   79 	mov	0x5314+0, #0x00
                                     80 ;	./src/tim2.c: 22: TIM2_CCER1 &= ~CC2P; // Active high
      0081B1 C6 53 0A         [ 1]   81 	ld	a, 0x530a
      0081B4 A4 DF            [ 1]   82 	and	a, #0xdf
                                     83 ;	./src/tim2.c: 23: TIM2_CCER1 |= CC2E; // Enable CH1 output
      0081B6 C7 53 0A         [ 1]   84 	ld	0x530a, a
      0081B9 AA 10            [ 1]   85 	or	a, #0x10
      0081BB C7 53 0A         [ 1]   86 	ld	0x530a, a
                                     87 ;	./src/tim2.c: 24: TIM2_CCMR2 |= (0b110 << 4); //PWM mode 1
      0081BE C6 53 08         [ 1]   88 	ld	a, 0x5308
      0081C1 AA 60            [ 1]   89 	or	a, #0x60
      0081C3 C7 53 08         [ 1]   90 	ld	0x5308, a
                                     91 ;	./src/tim2.c: 27: TIM2_CCR3H = 0x00;
      0081C6 35 00 53 15      [ 1]   92 	mov	0x5315+0, #0x00
                                     93 ;	./src/tim2.c: 28: TIM2_CCR3L = 0x00;
      0081CA 35 00 53 16      [ 1]   94 	mov	0x5316+0, #0x00
                                     95 ;	./src/tim2.c: 29: TIM2_CCER2 &= ~CC3P; // Active high
      0081CE C6 53 0B         [ 1]   96 	ld	a, 0x530b
      0081D1 A4 FD            [ 1]   97 	and	a, #0xfd
                                     98 ;	./src/tim2.c: 30: TIM2_CCER2 |= CC3E; // Enable CH1 output
      0081D3 C7 53 0B         [ 1]   99 	ld	0x530b, a
      0081D6 AA 01            [ 1]  100 	or	a, #0x01
      0081D8 C7 53 0B         [ 1]  101 	ld	0x530b, a
                                    102 ;	./src/tim2.c: 31: TIM2_CCMR3 |= (0b110 << 4); //PWM mode 1
      0081DB C6 53 09         [ 1]  103 	ld	a, 0x5309
      0081DE AA 60            [ 1]  104 	or	a, #0x60
      0081E0 C7 53 09         [ 1]  105 	ld	0x5309, a
                                    106 ;	./src/tim2.c: 33: TIM2_CR1 |= CEN; // Enable TIM2
      0081E3 72 10 53 00      [ 1]  107 	bset	0x5300, #0
                                    108 ;	./src/tim2.c: 34: }
      0081E7 81               [ 4]  109 	ret
                                    110 	.area CODE
                                    111 	.area CONST
                                    112 	.area INITIALIZER
                                    113 	.area CABS (ABS)
