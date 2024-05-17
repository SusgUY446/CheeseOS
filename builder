#!/bin/bash

# CheeseOS Builder Script
# Used for compiling CheeseOS

# Define constants
ASM=nasm
CC=gcc
SRC_DIR=src
TOOLS_DIR=tools
BUILD_DIR=build

function build_floppy_image() {
    echo "Building floppy image..."
    dd if=/dev/zero of=$BUILD_DIR/main_floppy.img bs=512 count=2880
    mkfs.fat -F 12 -n "CHOS" $BUILD_DIR/main_floppy.img
    dd if=$BUILD_DIR/bootloader.bin of=$BUILD_DIR/main_floppy.img conv=notrunc bs=512 seek=0
    mcopy -i $BUILD_DIR/main_floppy.img $BUILD_DIR/kernel.bin "::kernel.bin"
    mcopy -i $BUILD_DIR/main_floppy.img test.txt "::test.txt"
    echo "Floppy image built."
}

function assemble_bootloader() {
    echo "Assembling bootloader..."
    $ASM $SRC_DIR/boot/main.asm -f bin -o $BUILD_DIR/bootloader.bin
    echo "Bootloader assembled."
}

function assemble_kernel() {
    echo "Assembling kernel..."
    $ASM $SRC_DIR/kernel/main.asm -f bin -o $BUILD_DIR/kernel.bin
    echo "Kernel assembled."
}

function build_tools() {
    echo "Building tools..."
    mkdir -p $BUILD_DIR/tools
    $CC -g -o $BUILD_DIR/tools/fat $TOOLS_DIR/fat/fat.c
    echo "Tools built."
}

function create_build_dir() {
    echo "Creating build directory..."
    mkdir -p $BUILD_DIR
}

function build() {
    create_build_dir
    assemble_bootloader
    assemble_kernel
    build_tools
    build_floppy_image
    echo "CheeseOS built successfully."
}

function run() {
    echo "Running CheeseOS..."
    qemu-system-x86_64 -drive format=raw,file=$BUILD_DIR/main_floppy.img
}

function clear_build() {
    echo "Clearing build files..."
    rm -rf $BUILD_DIR/*
    echo "Build files cleared."
}

function show_version() {
    echo "Cheese Builder Alpha 0.0.1"
}

function show_help() {
    echo "Usage: ./builder [command]"
    echo "Commands:"
    echo "  build    - Build CheeseOS"
    echo "  run      - Run CheeseOS with QEMU"
    echo "  clear    - Clear build files"
    echo "  version  - Show Cheese Builder version"
    echo "  help     - Show this help message"
}

# Main script logic
if [ "$1" == "build" ]; then
    build
elif [ "$1" == "run" ]; then
    run
elif [ "$1" == "clear" ]; then
    clear_build
elif [ "$1" == "version" ] || [ "$1" == "-v" ]; then
    show_version
elif [ "$1" == "help" ]; then
    show_help
else
    echo "Command '$1' not found. Run './builder help' for help."
fi
