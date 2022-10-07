#include "../inc/gpio.h"

void gpio_init() {
    // Output - PushPull - 2MHz
    PB_DDR |= (1 << 5);
    PB_CR1 |= (1 << 5);
    PB_CR2 &= ~(1 << 5);
    
    // TIM2_CH1 
    // Output - PushPull - 2MHz
    PD_DDR |= (1 << 4);
    PD_CR1 |= (1 << 4);
    PD_CR2 &= ~(1 << 4);
    PD_ODR &= ~(1 << 4);

    // TIM2_CH2 
    // Output - PushPull - 2MHz
    PD_DDR |= (1 << 3);
    PD_CR1 |= (1 << 3);
    PD_CR2 &= ~(1 << 3);
    PD_ODR &= ~(1 << 3);

    // TIM2_CH3 
    // Output - PushPull - 2MHz
    PA_DDR |= (1 << 3);
    PA_CR1 |= (1 << 3);
    PA_CR2 &= ~(1 << 3);
    PA_ODR &= ~(1 << 3);
    
    /* Buttons 
     * But_R+ -> PD1
     * But_R- -> PC7
     * But_G+ -> PC6
     * But_G- -> PC5
     * But_B+ -> PC4
     * But_B- -> PC3
     */
    
    PD_DDR &= ~(1 << 2); // Input 
    PD_CR1 |= (1 << 2); // Pull-Up
    PD_CR2 &= ~(1 << 2); // Interrupt disabled

    PC_DDR &= ~(1 << 7);
    PC_CR1 |= (1 << 7);
    PC_CR2 &= ~(1 << 7);

    PC_DDR &= ~(1 << 6);
    PC_CR1 |= (1 << 6);
    PC_CR2 &= ~(1 << 6);

    PC_DDR &= ~(1 << 5);
    PC_CR1 |= (1 << 5);
    PC_CR2 &= ~(1 << 5);

    PC_DDR &= ~(1 << 4);
    PC_CR1 |= (1 << 4);
    PC_CR2 &= ~(1 << 4);

    PC_DDR &= ~(1 << 3);
    PC_CR1 |= (1 << 3);
    PC_CR2 &= ~(1 << 3);
}

