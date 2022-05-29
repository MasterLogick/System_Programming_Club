BITS 16
section .text
global _main_entry_asm
_main_entry_asm:
    mov al, '5'
    call _print_asm
    jmp $
.end:
size _main_entry_asm _main_entry_asm.end - _main_entry_asm

;al = ascii code to print
.err:
_print_asm:
    push ax
    push bx
    push cx
    mov bx, 0xf
    mov cx, 1
    mov ah, 0xe
    int 0x10
    pop cx
    pop bx
    pop ax
    ret
.end:
