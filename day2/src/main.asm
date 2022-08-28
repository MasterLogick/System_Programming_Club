BITS 32
section .text
global _main_entry_asm
_main_entry_asm:
    mov al, 'A'
    mov [0xb8000], al
    jmp $
.end:
size _main_entry_asm _main_entry_asm.end - _main_entry_asm
