#include "../inc/tim2.h"

void tim2_init() {
    // TIM2_ARR = F_Master / F_PWM
    // 2 (MHz) / 125 (Hz) = 16000
    const uint16_t tim2_arrval = 16000;

    TIM2_PSCR = 0x00; // Prescaler = 1
    TIM2_ARRH = tim2_arrval >> 8;
    TIM2_ARRL = tim2_arrval & 0x00FF;
    
    // TIM2_CH1 init
    TIM2_CCR1H = 0x00;
    TIM2_CCR1L = 0x00;
    TIM2_CCER1 &= ~CC1P; // Active high
    TIM2_CCER1 |= CC1E; // Enable CH1 output
    TIM2_CCMR1 |= (0b110 << 4); //PWM mode 1
    
    // TIM2_CH2 init
    TIM2_CCR2H = 0x00;
    TIM2_CCR2L = 0x00;
    TIM2_CCER1 &= ~CC2P; // Active high
    TIM2_CCER1 |= CC2E; // Enable CH1 output
    TIM2_CCMR2 |= (0b110 << 4); //PWM mode 1
    
    // TIM2_CH3 init
    TIM2_CCR3H = 0x00;
    TIM2_CCR3L = 0x00;
    TIM2_CCER2 &= ~CC3P; // Active high
    TIM2_CCER2 |= CC3E; // Enable CH1 output
    TIM2_CCMR3 |= (0b110 << 4); //PWM mode 1

    TIM2_CR1 |= CEN; // Enable TIM2
}

