#include "../inc/flash.h"

void eeprom_unlock() {
    FLASH_PUKR = 0x56;
    FLASH_PUKR = 0xAE;
}

void eeprom_write(uint16_t mem_cell, uint8_t data) {
    if (!(FLASH_IAPSR & 0x02))
    {
        // unlock EEPROM
        FLASH_DUKR = 0xAE;
        FLASH_DUKR = 0x56;
    }
    // wait for acces to write
    while (!(FLASH_IAPSR & DUL));

    uint8_t  *addr;
    addr = (uint8_t *)(EEPROM_FIRST_ADDR + mem_cell); //Initialize  pointer
                                                      //
    __asm sim __endasm; // Disable interrupts
    *addr = data;
    while(EOP != (~FLASH_IAPSR & EOP)); // Wait for writing to complete
    __asm rim __endasm; // Enable interrupts

    FLASH_IAPSR &= ~(DUL);      // lock EEPROM
}
