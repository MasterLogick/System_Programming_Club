BITS 32
section .text
global _main_entry_asm
_main_entry_asm:
    ; disable all devices
    mov al, 0xad
    out 0x64, al
    mov al, 0xa7
    call send_ps2_command

    ; flush controller output buffer
    .controller_flush_loop:
    in al, 0x60
    in al, 0x64
    test al, 1
    jnz .controller_flush_loop

    ; disable interrupts
    mov al, 0x20
    call send_ps2_command
    call read_ps2_resp
    and al, ~3
    mov bl, al
    mov al, 0x60
    call send_ps2_command
    mov al, bl
    out 0x60, al

    ; self-test
    mov al, 0xaa
    call send_ps2_command
    call read_ps2_resp
    cmp al, 0x55
    mov al, '/'
    ; jne .err

    ; port test
    mov al, 0xab
    call send_ps2_command
    call read_ps2_resp
    cmp al, 0
    mov al, '/'
    ; jne .err

    ; enable first port
    mov al, 0xae
    call send_ps2_command

    mov ebx, 0
    .l2:
    xor eax, eax
    call read_ps2_resp
    test al, 1<<7
    jnz .l2
    call convert_char
    mov [0xb8000 + 2 * ebx], al
    inc ebx
    cmp ebx, 80*25
    jne .l2
    mov ebx, 0
    jmp .l2
    jmp $
.end:
size _main_entry_asm _main_entry_asm.end - _main_entry_asm

global wait_ps2_resp
wait_ps2_resp:
    push ax
    in al, 0x64
    test al, 1
    pop ax
    jz wait_ps2_resp
    ret
.end:
size wait_ps2_resp wait_ps2_resp.end - wait_ps2_resp

global wait_ps2_ready
wait_ps2_ready:
    push ax
    in al, 0x64
    test al, 2
    pop ax
    jnz wait_ps2_ready
    ret
.end:
size wait_ps2_ready wait_ps2_ready.end - wait_ps2_ready

global send_ps2_command
send_ps2_command:
    call wait_ps2_ready
    out 0x64, al
    ret
.end:
size send_ps2_command send_ps2_command.end - send_ps2_command

global read_ps2_resp
read_ps2_resp:
    call wait_ps2_resp
    in al, 0x60
    ret
.end:
size read_ps2_resp read_ps2_resp.end - read_ps2_resp

global convert_char
convert_char:
    lea eax, [lookup_table + eax]
    mov al, [eax]
    ret
.end:
size convert_char convert_char.end - convert_char

global print_bin
print_bin:
    push ecx
    push ebx
    push eax
    mov ecx, 8
    .l:
    mov bl, '0'
    shr al, 1
    jnc .p
    mov bl, '1'
    .p:
    mov [0xb8000 + 2 * ecx], bl
    loop .l
    pop eax
    pop ebx
    pop ecx
    ret
.end:
size print_bin print_bin.end - print_bin

section .data

lookup_table: db         0
              db         0
              db         '1'
              db         '2'
              db         '3'
              db         '4'
              db         '5'
              db         '6'
              db         '7'
              db         '8'
              db         '9'
              db         '0'
              db         '-'
              db         '='
              db         0
              db         't'
              db         'Q'
              db         'W'
              db         'E'
              db         'R'
              db         'T'
              db         'Y'
              db         'U'
              db         'I'
              db         'O'
              db         'P'
              db         '['
              db         ']'
              db         'n'
              db         0
              db         'A'
              db         'S'
              db         'D'
              db         'F'
              db         'G'
              db         'H'
              db         'J'
              db         'K'
              db         'L'
              db         ';'
              db         "'"
              db         '`'
              db         0
              db         '\'
              db         'Z'
              db         'X'
              db         'C'
              db         'V'
              db         'B'
              db         'N'
              db         'M'
              db         ','
              db         '.'
              db         '/'
              db         0
              db         '*'
              db         0
              db         ' '
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         '7'
              db         '8'
              db         '9'
              db         '-'
              db         '4'
              db         '5'
              db         '6'
              db         '+'
              db         '1'
              db         '2'
              db         '3'
              db         '0'
              db         '.'
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0
              db         0