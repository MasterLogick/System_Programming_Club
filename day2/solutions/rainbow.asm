BITS 32
section .text
global _main_entry_asm
_main_entry_asm:
    xor dl, dl
    xor eax, eax
    mov bl, 'A'
    mov ecx, 80 * 25 - 1
.l1:
    loop .l1
.l:
    add dl, 1
    and dl, ~(1<<7)
    mov [0xb8000 + eax * 2 + 1], dl
    mov [0xb8000 + eax * 2], bl
    add eax, 1
    mov ecx, 100000
    loop $
    cmp eax, 80*25
    jl .l
    xor ax, ax
    jmp .l
    jmp $
.end:
size _main_entry_asm _main_entry_asm.end - _main_entry_asm
