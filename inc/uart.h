#include "../lib/macro_uart1.h"
#include <stdint.h>

void uart_init();

void uart_tx_byte(char *byte);
void uart_tx_byte_array(char data[], uint8_t size);
