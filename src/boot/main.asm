[org 0x7c00]
[bits 16]






mov si, CHEESEOS_INTRO
call print


mov al, 1
mov cl, 2
call readDisk
jmp test_label

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



TEST_STR: db "you are in the second sector of the disk", 0x0a, 0x0d, 0
CHEESEOS_INTRO: db "CheeseOS on Top - CheeseOS Unstable Alpha 0.0.1", 0x0a, 0x0d, 0

; error messages
DISK_ERR: db "Error reading Disk.", 0x0a, 0x0d, 0

test_label:
    mov si, TEST_STR
    call print


; mgic byte and padding
times 510-($-$$) db 0
dw 0xaa55



times 512 db 0
