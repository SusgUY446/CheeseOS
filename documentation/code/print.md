# `print` Assembly function explained

Print function in assembly (found in src/boot/main.asm):
```asm
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
``` 


## Line by line explanation

`print:` - Creates a label called print
`pusha` - Pushes all registers to the stack
`str_loop:`