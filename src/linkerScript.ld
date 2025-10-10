ENTRY(_start)

OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386)

SECTIONS
{
    /* Load the kernel at 1 MB (after bootloader) */
    . = 0x00100000;

    /* Code (text) section */
    .text ALIGN(4K) :
    {
        *(.multiboot)
        *(.text*)
    }

    /* Read-only data */
    .rodata ALIGN(4K) :
    {
        *(.rodata*)
    }

    /* Initialized data */
    .data ALIGN(4K) :
    {
        *(.data*)
    }

    /* Uninitialized data (BSS) */
    .bss ALIGN(4K) :
    {
        *(COMMON)
        *(.bss*)
        *(COMMON)
    }

    /* Align end to 4K boundary */
    . = ALIGN(4K);
}
