BITS 64
section .text
global _main_entry_asm
_main_entry_asm:
;ABCDEFGH
    mov rax, 'HGFEDCBA'
    mov [0xb8000], rax
    jmp $