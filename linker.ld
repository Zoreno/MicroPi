ENTRY(_start)
 
SECTIONS
{
    /DISCARD/ :
    {
        *(.text)
        *(.got*)
    }

    . = 0x8000;
    __start = .;
    __text_start = .;
    .text.boot :
    {
        KEEP(*(.text.boot))
    }
    __text_end = .;
 
    __rodata_start = .;
    .rodata :
    {
        *(.rodata)
    }
    __rodata_end = .;
 
    __data_start = .;
    .data :
    {
        *(.data)
    }
    __data_end = .;
 
    __bss_start = .;
    .bss :
    {
        bss = .;
        *(.bss)
    }
    __bss_end = .;
    __bss_size = __bss_end - __bss_start;
    __end = .;
}