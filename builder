#!/bin/bash

# CheeseOS Builder Script
# Used for compiling CheeseOS

function build_floppy_image() {
    echo "Building floppy image..."
    dd if=/dev/zero of=build/main_floppy.img bs=512 count=2880
    mkfs.fat -F 12 -n "NBOS" build/main_floppy.img
    dd if=build/bootloader.bin of=build/main_floppy.img conv=notrunc
    mcopy -i build/main_floppy.img build/kernel.bin "::kernel.bin"
    echo "Floppy image built."
}

function assemble_bootloader() {
    echo "Assembling bootloader..."
    nasm -f bin src/boot/main.asm -o build/bootloader.bin
    echo "Bootloader assembled."
}

function assemble_kernel() {
    echo "Assembling kernel..."
    nasm -f bin src/kernel/kernel.asm -o build/kernel.bin
    echo "Kernel assembled."
}

function create_build_dir() {
    echo "Creating build directory..."
    mkdir -p build
}

function build() {
    create_build_dir
    assemble_bootloader
    assemble_kernel
    build_floppy_image
    echo "CheeseOS built successfully."
}

function run() {
    echo "Running CheeseOS..."
    qemu-system-x86_64 -drive format=raw,file=build/main_floppy.img
}

# Main script logic
if [ "$1" = "build" ]; then
    build
elif [ "$1" = "run" ]; then
    run
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
else
    echo "Command '$1' not found. Run './builder help' for help."
fi
