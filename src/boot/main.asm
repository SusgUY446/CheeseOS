org 0x7c00
bits 16 ; 16 bit real mode

%DEFINE ENDL 0x0a, 0x0d ; sets endl (endline) to new line chraracters. (easier to type)


section .text
    global main

main:


; init
cli
jmp 0x0000:ZeroSeg 

ZeroSeg:
    xor ax, ax ; set ax to 0. 1 bit smaller then mov
    mov ss, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov sp, main ; set stackpointer to main
    cld

sti


push ax
xor ax, ax
mov dl, 0x80
int 0x13
pop ax

; Print CheeseOS Intro To Screen 
mov si, CHEESEOS_INTRO
call print





mov dx, 0x1341
call printh

jmp $




; multiple files broke print somehow so we will keep it here

print:
    pusha
    str_loop:
        mov al, [si]
        cmp al, 0
        jne print_char
        popa
        ret

    print_char: 
        mov ah, 0x0e
        int 0x10
        add si, 1
        jmp str_loop




; for documentation see documentation/readDisk.md
readDisk:
    pusha
    mov ah, 0x02
    mov dl, 0x80
    mov ch, 0 
    mov dh, 0
    mov al, 1
    mov cl, 2


    push bx
    mov bx, 0 
    mov es, bx
    pop bx
    mov bx, 0x7c00 + 512

    int 0x13

    jc disk_error
    popa 
    ret

    disk_error:
        mov si, DISK_ERR
        call print
        jmp $



CHEESEOS_INTRO: db "CheeseOS on Top - CheeseOS Unstable Alpha 0.0.2", ENDL, 0



; error messages
DISK_ERR: db "Error reading Disk.", ENDL, 0

; mgic byte and padding
times 510-($-$$) db 0
dw 0xaa55
