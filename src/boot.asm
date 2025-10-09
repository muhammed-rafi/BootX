[BITS 16]
[ORG 0x7C00]

start:
    cli;                 ; Clear interrupts
    mov ax, 0x00   ;
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00 ; Set stack pointer
    sti;                 ; Enable interrupts
    mov si, msg


print:
    lodsb; Loads byte at DS:SI into AL and increments SI
    cmp al, 0   ; Check for null terminator
    je done     ; If null terminator, we're done
    mov ah, 0x0E ; BIOS teletype function
    int 0x10    ; Call BIOS video interrupt
    jmp print   ; Repeat for next character 


done:
    cli
    hlt ; Halt the CPU


msg: db 'Hello, World!', 0

times 510-($-$$) db 0 ; Pad the rest of the boot sector with zeros

dw 0xAA55 ; Boot sector signature
