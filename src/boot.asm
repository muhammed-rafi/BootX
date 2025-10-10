[BITS 16]
[ORG 0x7C00]

CODE_OFFSET equ 0x8
DATA_OFFSET equ 0x10

KERNEL_LOAD_SEG equ 0x1000
KERNEL_START_ADDR equ 0x100000 

start:
    cli;                 ; Clear interrupts
    mov ax, 0x00   ;
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00 ; Set stack pointer
    sti;                 ; Enable interrupts

;load kernel 
mov bx, KERNEL_LOAD_SEG
mov dh, 0x00
mov dl, 0x80
mov cl, 0x02
mov ch, 0x00
mov ah, 0x02
mov al, 8
int 0x13

jc disk_read_error



load_PM:
    cli;                 ; Clear interrupts
    lgdt [gdt_descriptor]  ; Load GDT

    ; Switch to protected mode
    mov eax, cr0
    or al, 1            ; Set PE bit
    mov cr0, eax
    jmp CODE_OFFSET:PModeMain


disk_read_error:
    hlt

gdt_start:
    dd 0x0               ; Null descriptor
    dd 0x0

    ;code segment descriptor
    dw 0xFFFF                   ; Limit low
    dw 0x0000                   ; Base low
    db 0x00                     ; Base middle
    db 0x9A                     ; Access byte
    db 0xCF                     ; Granularity
    db 0x00                     ; Base high

    ;data segment descriptor
    dw 0xFFFF                   ; Limit low
    dw 0x0000                   ; Base low
    db 0x00                     ; Base middle
    db 0x92                     ; Access byte
    db 0xCF                     ; Granularity
    db 0x00                     ; Base high

gdt_end:


gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; Limit
    dd gdt_start                 ; Base

[BITS 32]
PModeMain:
    mov ax, DATA_OFFSET
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov ss, ax
    mov gs, ax
    mov ebp , 0x09C00 ; 
    mov esp, ebp; 

    in al, 0x92
    or al, 0x02
    out 0x92, al

    jmp CODE_OFFSET:KERNEL_START_ADDR



times 510-($-$$) db 0 ; Pad the rest of the boot sector with zeros

dw 0xAA55 ; Boot sector signature
