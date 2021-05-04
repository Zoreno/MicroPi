// To keep this in the first portion of the binary.
.section ".text.boot"
 
.org 0x7000
__start_lower:
	// Shut off extra cores
	mrc p15, 0, r5, c0, c0, 5
	and r5, r5, #3
	cmp r5, #0
	bne halt
 
	// Setup the stack.
	ldr r5, =_start
	mov sp, r5
 
clear_bss:
	ldr r4, =__bss_start
	ldr r9, =__bss_end
	mov r5, #0
	mov r6, #0
	mov r7, #0
	mov r8, #0
 
clear_bss_loop:
	cmp r4, r9
	bhs _done          // Check if we are past bss
	stmia r4!, {r5-r8} // store multiple at r4.
    bl clear_bss_loop

_done:
	ldr r3, =kernel_main // Call kernel_main
	blx r3
 
halt:
	wfe
	b halt

.globl _start
 
// Entry point for the kernel.
// r15 -> should begin execution at 0x8000.
// r0 -> 0x00000000
// r1 -> 0x00000C42 - machine id
// r2 -> 0x00000100 - start of ATAGS
// preserve these registers as argument for kernel_main
_start:
        .org 0x8000
        b __start_lower 