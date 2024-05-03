#!/bin/bash

# CheeseOS Builder Script
# Used for compiling CheeseOS


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
elif [ "$1" = "clear" ]; then
    echo "Cleared system from build files"
    rm -r build
elif [ "$1" = "version" ] || [ "$1" = "-v" ]; then
    echo "Cheese Builder Alpha 0.0.1"
elif [ "$1" = "help" ]; then
    echo "Usage: ./builder [command]"
    echo "Commands:"
    echo "  build    - Build CheeseOS"
    echo "  run      - Run CheeseOS with QEMU"
    echo "  clear    - Clear build files"
    echo "  version  - Show Cheese Builder version"
    echo "  help     - Show this help message"
    
elif [ "$1" = "" ]; then
    echo "Usage: ./builder [command]"
    echo "Commands:"
    echo "  build    - Build CheeseOS"
    echo "  run      - Run CheeseOS with QEMU"
    echo "  clear    - Clear build files"
    echo "  version  - Show Cheese Builder version"
    echo "  help     - Show this help message"

elif [ "$1" = "run" ]; then
    qemu-system-x86_64 -drive format=raw,file=build/main.bin
else
    echo "Command '$1' not found. Run './builder help' for help."
fi