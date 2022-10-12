#include "../inc/gpio.h"

void gpio_init() {
    // Onboard LED
    // Output - PushPull - 2MHz
    PB_DDR |= (1 << 5);
    PB_CR1 |= (1 << 5);
    PB_CR2 &= ~(1 << 5);
    PB_ODR |= (1 << 5);
    
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
    * Btn_R+ -> PD2
    * Btn_R- -> PC7
    * Btn_G+ -> PC6
    * Btn_G- -> PC5
    * Btn_B+ -> PC4
    * Btn_B- -> PC3
    * 
    * Btn_FLASH -> PB4
    * Btn_LOAD -> PB5
    * */
    
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


    PB_DDR &= ~(1 << 4);
    PB_CR1 |= (1 << 4);
    PB_CR2 &= ~(1 << 4);

    PB_DDR &= ~(1 << 5);
    PB_CR1 |= (1 << 5);
    PB_CR2 &= ~(1 << 5);
    

    // UART pins
    // UART1 TX
    PD_DDR |= (1 << 5); // Output
    PD_CR1 |= (1 << 5); // PushPull
    PD_CR2 &= ~(1 << 5); // To 2MHz

    // UART1 RX
    PD_DDR &= ~(1 << 6); // Input
    PD_CR1 &= ~(1 << 6); // Floating
    PD_CR2 &= ~(1 << 6); // External interrupt disabled
}

uint8_t btn_r_plus_is_pressed() {
    return((1 << 2) == (~PD_IDR & (1 << 2)));
}

uint8_t btn_g_plus_is_pressed() {
    return((1 << 6) == (~PC_IDR & (1 << 6)));
}

uint8_t btn_b_plus_is_pressed() {
    return((1 << 4) == (~PC_IDR & (1 << 4)));
}

uint8_t btn_r_minus_is_pressed() {
    return((1 << 7) == (~PC_IDR & (1 << 7)));
}

uint8_t btn_g_minus_is_pressed() {
    return((1 << 5) == (~PC_IDR & (1 << 5)));
}

uint8_t btn_b_minus_is_pressed() {
    return((1 << 3) == (~PC_IDR & (1 << 3)));
}

uint8_t btn_flash_is_pressed() {
    return((1 << 4) == (~PB_IDR & (1 << 4)));
}

uint8_t btn_load_is_pressed() {
    return((1 << 5) == (~PB_IDR & (1 << 5)));
}
