#!/bin/bash
#TODO: different programmers need different parameters
#openFPGALoader --cable ft232RL --pins=RXD:RTS:TXD:CTS top_system.bit
openFPGALoader --cable usb-blaster --probe-firmware /home/roby/intelFPGA_lite/22.1std/quartus/linux64/blaster_6810.hex top_system.bit