# MicroPi

An attempt at making the smallest bootable Raspberry Pi kernel. The kernel
should print a "Hello World!" to the debug UART (UART0).

## Building

    ./fetch_toolchain.sh
    make

## Running

Qemu can emulate the kernel by using the kernel.elf binary. Install with:

    sudo apt-get install qemu-system-arm qemu-img

Run with

    make run

## Results

    total 196
    drwxrwxr-x  4 zoreno zoreno  4096 maj  4 23:28 .
    drwxr-x--- 22 zoreno zoreno  4096 maj  4 19:57 ..
    -rw-rw-r--  1 zoreno zoreno 33764 maj  4 23:28 boot.o
    -rw-rw-r--  1 zoreno zoreno   862 maj  4 23:06 boot.S
    drwxrwxr-x  6 zoreno zoreno  4096 maj  4 23:27 cross-cc
    -rwxrwxr-x  1 zoreno zoreno   386 maj  4 23:29 fetch_toolchain.sh
    drwxrwxr-x  8 zoreno zoreno  4096 maj  4 23:30 .git
    -rw-rw-r--  1 zoreno zoreno    40 maj  4 22:57 .gitignore
    -rwxrwxr-x  1 zoreno zoreno 32932 maj  4 23:28 kernel7.img
    -rw-rw-r--  1 zoreno zoreno  2808 maj  4 23:06 kernel.c
    -rwxrwxr-x  1 zoreno zoreno 66072 maj  4 23:28 kernel.elf
    -rwxrwxr-x  1 zoreno zoreno 66948 maj  4 23:28 kernel.elf.temp
    -rw-rw-r--  1 zoreno zoreno  1156 maj  4 23:28 kernel.o
    -rw-rw-r--  1 zoreno zoreno   560 maj  4 23:11 linker.ld
    -rw-rw-r--  1 zoreno zoreno  1061 maj  4 23:18 Makefile
