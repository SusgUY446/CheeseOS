#!/bin/bash


echo  "CheeseOS Build Script"




# Create build dir
echo "Creating Build Directory"
mkdir -p build

# assemble main.asm
echo "Assembeling src/boot/main.asm"
nasm -fbin src/boot/main.asm -o build/main.bin


echo "Done Building"