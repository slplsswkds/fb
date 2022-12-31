#include "inc/main.h"

/*
 * TIM2_CH1 -> PD4
 * TIM2_CH2 -> PD3
 * TIM2_CH3 -> PA3
 * 
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

static void delay(uint16_t t) {
    while(t--) {};
}

struct Color rgb;

int main() {
    __asm sim __endasm; // Disable interrupts
    
    clk_init();
    gpio_init();
    tim2_init();
    //uart_init();
    
    //char banner[5] = {'1', '2', '3', '4', '5'};
    //uart_tx_byte_array(banner, 5);
    
    __asm rim __endasm; // Enable interrupts

    //eeprom_clear_all();

    rgb.r = 0;
    rgb.g = 0;
    rgb.b = 0;
    
    //eeprom_write(0, 0x0F);
    //eeprom_write(1, 0x00);
    //eeprom_write(2, 0xFF);

    load_color_from_eeprom(&rgb, 0);
    
    while(1) {
        button_hundler(&rgb);
        write_color_to_registers(&rgb);
    }
}

void button_hundler(struct Color *color) {
    if(btn_r_plus_is_pressed()) {
        smart_increment(&color->r);
    }

    if(btn_r_minus_is_pressed()) {
        smart_decrement(&color->r);
    }

    if(btn_g_plus_is_pressed()) {
        smart_increment(&color->g);
    }

    if(btn_g_minus_is_pressed()) {
        smart_decrement(&color->g);
    }
    
    if(btn_b_plus_is_pressed()) {
        smart_increment(&color->b);
    }
    
    if(btn_b_minus_is_pressed()) {
        smart_decrement(&color->b);
    }
    
    if(btn_brightness_plus_is_pressed()) {
        smart_increment(&color->r);
        smart_increment(&color->g);
        smart_increment(&color->b);
    }

    if(btn_brightness_minus_is_pressed()) {
        smart_decrement(&color->r);
        smart_decrement(&color->g);
        smart_decrement(&color->b);
    }

    // Problems with reading input status. Button disabled
    //if(btn_flash_is_pressed()) {
    //   load_color_from_eeprom(&rgb, 0);        
    //    rgb.r = 100;
    //}

    // Button uses as flash and load button
    if(btn_load_is_pressed()) {
        uint8_t counter = 0;
        while(counter < 10 && btn_load_is_pressed()) {
            delay(65535);
            counter += 1;
        }
        
        struct Color rgb_buf;
        load_color_from_eeprom(&rgb_buf, 0);        
        write_color_to_registers(&rgb_buf);
        delay(65535);
        delay(65535);
        delay(65535);
        
        // Timer with a preview of the color that will be erased in EEPROM to record the new color
        while(counter < 23 && btn_load_is_pressed()) {
            delay(65535);
            delay(65535);
            if (counter % 2 == 0) {
                write_color_to_registers(&rgb_buf);
            }
            else {
                write_color_to_registers(&rgb);
            }
            counter += 1;
        }
        
        if(counter >= 10 && counter < 23) {
            rgb = rgb_buf;
        }
        else if (counter == 23) { 
            write_color_to_eeprom(&rgb, 0);        
        }
    }
}

/*extern void uart1_rx_handler(void) __interrupt(18) {
    rgb.r = 0;
    rgb.g = 0;
    rgb.b = 0;
    write_color_to_registers(&rgb);
    
    UART1_SR &= ~(1 << 5); // Clear interrupt
    char byte = UART1_DR;
    uart_tx_byte(&byte);
}*/
