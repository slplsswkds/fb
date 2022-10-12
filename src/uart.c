#include "../inc/uart.h"

char NEWLINE = '\n';

void uart_init() {
    // UART_DIV = Fmaster/Baud rate
    // 2 (MHz) / 9600 = 208.333
    uint16_t brr = 2000000/9600;

    UART1_BRR1 = brr & 0x000F;
    UART1_BRR2 |= brr >> 12;
    UART1_BRR1 = (brr >> 4) & 0x00FF;
    
    UART1_CR1 &= ~PIEN; // Parity interrupt disabled
    UART1_CR1 &= ~PCEN; // Parity control disabled
    UART1_CR1 &= ~M; // 8-bit mode
    UART1_CR1 &= UARTD; // UART1 enable
    
    // Interrupts while transmitter register has cleared disabled
    UART1_CR2 &= ~TIEN; 
    // Disable interrupts while transmit completed
    UART1_CR2 &= ~TCIEN;
    // Disable interrupts when recive register has felt
    UART1_CR2 |= RIEN;
    // IDLE line interrupt disabled
    UART1_CR2 &= ~ILIEN;
    // TX enable
    UART1_CR2 |= TEN;
    // RX enable
    UART1_CR2 |= REN;
    // Dont send break symbol
    UART1_CR2 &= ~SBK;
    
    // One stop-bit
    UART1_CR3 &= ~(1 << 5);
    UART1_CR3 &= ~(1 << 4);
}

void uart_tx_byte(char *byte) {
    // Wait while while data register will be empty
    while(TXE == (~UART1_SR & TXE)) {};
    UART1_DR = *byte;
}

void uart_tx_byte_array(char data[], uint8_t size) {
    for(uint8_t cb = 0; cb < size; cb ++) {
        uart_tx_byte(&data[cb]);
    }
}
