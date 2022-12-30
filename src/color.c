#include "../inc/color.h"

uint16_t normalize_from(uint8_t *val) {
    float tmp1 = *val;
    float tmp2 = sqrtf(10 * tmp1) / 5;
    return (expf(tmp2));
}


void write_color_to_registers(struct Color *color) {
    uint16_t red = normalize_from( &color->r );
    uint16_t green = normalize_from( &color->g );
    uint16_t blue = normalize_from( &color->b );

    TIM2_CCR2H = red >> 8;
    TIM2_CCR2L = red;

    TIM2_CCR1H = green >> 8;
    TIM2_CCR1L = green;

    TIM2_CCR3H = blue >> 8;
    TIM2_CCR3L = blue;
}

void smart_increment(uint8_t *val) {
    if(*val < 255) {
        *val += 1;
    }
}

void smart_decrement(uint8_t *val) {
    if(*val > 0) {
        *val -= 1;
    }
}

void load_color_from_eeprom(struct Color *color, uint8_t color_cell) {
    uint8_t r, g, b;
    eeprom_read(3*color_cell+0, &r);
    eeprom_read(3*color_cell+1, &g);
    eeprom_read(3*color_cell+2, &b);
    
    color->r = r;
    color->g = g;
    color->b = b;
}

void write_color_to_eeprom(struct Color *color, uint8_t color_cell) {
    eeprom_write(3*color_cell+0, color->r);
    eeprom_write(3*color_cell+1, color->g);
    eeprom_write(3*color_cell+2, color->b);
}
