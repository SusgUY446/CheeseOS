#!/bin/bash





# CheeseOS Builder Script
# Used for compiling CheeseOS
# to clear build run ./builder clear

if [ "$1" = "build" ]; then
    echo "CheeseOS Builder"

    # Create build dir
    echo "Creating Build Directory"
    mkdir -p build

    # Change directory to src/boot/
    echo "Entering src/boot/ directory"
    cd src/boot/

    # Assemble main.asm
    echo "Assembling main.asm"
    nasm -f bin main.asm -o ../../build/main.bin

    # Change back to the root directory
    echo "Returning to the root directory"
    cd ../..

    echo "Done Building"
fi

if [ "$1" = "clear" ]; then
    echo "Cleared system from build files"
    rm -r build
fi 


if [ "$1" = "version" ]; then
    echo "Cheese Builder Alpha 0.0.1"
fi

if [ "$1" = "-v" ]; then
    echo "Cheese Builder Alpha 0.0.1"
fi