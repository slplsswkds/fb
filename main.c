#include "lib/macro_clk.h"
#include "lib/macro_gpio.h"
#include "lib/macro_tim2.h"
#include "stdint.h"
#include "stdbool.h"

#include "inc/clk.h"
#include "inc/gpio.h"
#include "inc/tim2.h"

/*
 * TIM2_CH1 -> PD4
 * TIM2_CH2 -> PD3
 * TIM2_CH3 -> PA3
 * */

const uint16_t pwm_steps[16] = {0, 1, 2, 5, 11, 24, 52, 116, 256,\
                     565, 1247, 2753, 6079, 13423, 29637, 65534};

static void delay(uint16_t t) {
    while(t--) {};
}


int main() {
    do { __asm sim __endasm; } while(0); // Disable interrupts

    clk_init();
    gpio_init();
    tim2_init();
    
    do { __asm rim __endasm; } while(0); // Enable interrupts
    
    PB_ODR |= (1 << 5);

    for(;;) {
        static uint16_t counter, duty = 0;
        TIM2_CCR1H = duty >> 8; // Red
        TIM2_CCR1L = duty;

        TIM2_CCR2H = duty >> 8; // Green
        TIM2_CCR2L = duty;
        
        TIM2_CCR3H = duty >> 8; // Blue
        TIM2_CCR3L = duty;
        
        if(counter < 16) {
            counter ++;
            duty = pwm_steps[counter];
        }
        else {
            duty = 0;
            counter = 0;
            PB_ODR &= ~(1 << 5);
            while(1);
        }

        delay(65535);
    }
}

