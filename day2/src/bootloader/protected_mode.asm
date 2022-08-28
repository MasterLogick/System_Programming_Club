BITS 32
section .protected_mode_section

extern stack_top

global _protected_mode_entry_asm
extern _main_entry_asm
_protected_mode_entry_asm:

    ;setup segment registers
    mov ax, 0x10
    mov es, ax
    mov ss, ax
    mov ds, ax
    mov fs, ax
    mov gs, ax
    mov esp, stack_top
    mov ebp, stack_top
    jmp _main_entry_asm
.end:
size _protected_mode_entry_asm _protected_mode_entry_asm.end - _protected_mode_entry_asm

