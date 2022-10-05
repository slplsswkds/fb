#include "../inc/color.h"

uint16_t normalize_from(uint8_t *val) {
    //return (*val * 62); // Not ready variant!
                        // 15999 is max duty for 125 Hz
    float tmp1 = *val;
    float tmp2 = sqrtf(11 * tmp1) / 5;
    //return(16000);
    return (expf(tmp2));
}


void write_color_to_registers(struct Color *color) {
    uint16_t red = normalize_from( &color->r );
    uint16_t green = normalize_from( &color->g );
    uint16_t blue = normalize_from( &color->b );

    TIM2_CCR1H = red >> 8; // Red
    TIM2_CCR1L = red;

    TIM2_CCR2H = green >> 8; // Green
    TIM2_CCR2L = green;
    
    TIM2_CCR3H = blue >> 8; // Blue
    TIM2_CCR3L = blue;
}
