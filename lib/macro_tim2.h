#define TIM2_CR1    *(unsigned char*)0x5300
#define TIM2_IER    *(unsigned char*)0x5303
#define TIM2_SR1    *(unsigned char*)0x5304
#define TIM2_SR2    *(unsigned char*)0x5305
#define TIM2_EGR    *(unsigned char*)0x5306
#define TIM2_CCMR1  *(unsigned char*)0x5307
#define TIM2_CCMR2  *(unsigned char*)0x5308
#define TIM2_CCMR3  *(unsigned char*)0x5309
#define TIM2_CCER1  *(unsigned char*)0x530A
#define TIM2_CCER2  *(unsigned char*)0x530B
#define TIM2_CNTRH  *(unsigned char*)0x530C
#define TIM2_CNTRL  *(unsigned char*)0x530D
#define TIM2_PSCR   *(unsigned char*)0x530E
#define TIM2_ARRH   *(unsigned char*)0x530F
#define TIM2_ARRL   *(unsigned char*)0x5310
#define TIM2_CCR1H  *(unsigned char*)0x5311
#define TIM2_CCR1L  *(unsigned char*)0x5312
#define TIM2_CCR2H  *(unsigned char*)0x5313
#define TIM2_CCR2L  *(unsigned char*)0x5314
#define TIM2_CCR3H  *(unsigned char*)0x5315
#define TIM2_CCR3L  *(unsigned char*)0x5316

// TIM2_CR1 bits
#define ARPE    (1 << 7)
#define OPM     (1 << 3)
#define URS     (1 << 2)
#define UDIS    (1 << 1)
#define CEN     (1 << 0)

// TIM2_CCER1 bits
#define CC2P (1 << 5)
#define CC2E (1 << 4)
#define CC1P (1 << 1)
#define CC1E (1 << 0)

// TIM2_CCER2 bits
#define CC3P (1 << 1)
#define CC3E (1 << 0)
