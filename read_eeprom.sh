#!/bin/sh

stm8flash -c stlinkv2 -p stm8s103f2 -s eeprom -r eeprom_data.hex \
    && cat eeprom_data.hex \
    && rm eeprom_data.hex \
    echo "MC should be rebooted for future working"
