#include "../inc/flash.h"

void eeprom_unlock() {
    if (!(FLASH_IAPSR & 0x02))
    {
        // unlock EEPROM
        FLASH_DUKR = 0xAE;
        FLASH_DUKR = 0x56;
    }
    // wait for acces to write
    while (!(FLASH_IAPSR & DUL));
}

void eeprom_lock() {
    FLASH_IAPSR &= ~(DUL);
}

void eeprom_clear_all() {
    for(int c = 0; c < 639; c++) {
        eeprom_write(c, 0);
    }
}

void eeprom_write(uint16_t mem_cell, uint8_t data) {
    eeprom_unlock();
    // wait for acces to write
    while (!(FLASH_IAPSR & DUL));

    uint8_t  *addr;
    addr = (uint8_t *)(EEPROM_FIRST_ADDR + mem_cell); //Initialize  pointer
                                                      //
    __asm sim __endasm; // Disable interrupts
    *addr = data;
    while(EOP != (~FLASH_IAPSR & EOP)); // Wait for writing to complete
    __asm rim __endasm; // Enable interrupts

    eeprom_lock();
}

void eeprom_read(uint16_t mem_cell, uint8_t *data) {
    uint8_t  *addr;
    addr = (uint8_t *)(EEPROM_FIRST_ADDR + mem_cell);
                                                      
    __asm sim __endasm;
    *data = *addr;
    while(EOP != (~FLASH_IAPSR & EOP));
    __asm rim __endasm;
}
