ENTRY(_start)
 
SECTIONS
{
    /DISCARD/ :
    {
        *(.text) /* Each function text section is put in a separate section, so we can discard this generic one */
        *(.got*) /* GOT is not used (-fno-plt -fno-pic) */
    }

    . = 0x8000;
    __start = .;
    __text_start = .;
    .text.boot :
    {
        KEEP(*(.text.boot))
    }
    __text_end = .;

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
    __end = .;
}