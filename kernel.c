typedef unsigned int uint32_t;
typedef int int32_t;
typedef unsigned int size_t;

// Memory-Mapped I/O output
static inline void mmio_write(uint32_t reg, uint32_t data)
{
	*(volatile uint32_t*)(reg) = data;
}
 
// Memory-Mapped I/O input
static inline uint32_t mmio_read(uint32_t reg)
{
	return *(volatile uint32_t*)(reg);
}
 
enum
{
    // The offsets for reach register.
    GPIO_BASE = 0x3F200000,
 
    // Controls actuation of pull up/down to ALL GPIO pins.
    GPPUD = (GPIO_BASE + 0x94),
 
    // Controls actuation of pull up/down for specific GPIO pin.
    GPPUDCLK0 = (GPIO_BASE + 0x98),
 
    // The base address for UART.
    UART0_BASE = (GPIO_BASE + 0x1000), // for raspi4 0xFE201000, raspi2 & 3 0x3F201000, and 0x20201000 for raspi1
 
    // The offsets for reach register for the UART.
    UART0_DR     = (UART0_BASE + 0x00),
    UART0_RSRECR = (UART0_BASE + 0x04),
    UART0_FR     = (UART0_BASE + 0x18),
    UART0_ILPR   = (UART0_BASE + 0x20),
    UART0_IBRD   = (UART0_BASE + 0x24),
    UART0_FBRD   = (UART0_BASE + 0x28),
    UART0_LCRH   = (UART0_BASE + 0x2C),
    UART0_CR     = (UART0_BASE + 0x30),
    UART0_IFLS   = (UART0_BASE + 0x34),
    UART0_IMSC   = (UART0_BASE + 0x38),
    UART0_RIS    = (UART0_BASE + 0x3C),
    UART0_MIS    = (UART0_BASE + 0x40),
    UART0_ICR    = (UART0_BASE + 0x44),
    UART0_DMACR  = (UART0_BASE + 0x48),
    UART0_ITCR   = (UART0_BASE + 0x80),
    UART0_ITIP   = (UART0_BASE + 0x84),
    UART0_ITOP   = (UART0_BASE + 0x88),
    UART0_TDR    = (UART0_BASE + 0x8C),

};
 
void uart_init()
{
    // Configure GPIO
	mmio_write(UART0_CR, 0x00000000); // Disable UART0.	
	mmio_write(GPPUD, 0x00000000); // Disable pull up/down for all GPIO pins & delay for 150 cycles.
	mmio_write(GPPUDCLK0, (1 << 14) | (1 << 15)); // Disable pull up/down for pin 14,15 & delay for 150 cycles.
	mmio_write(GPPUDCLK0, 0x00000000); // Write 0 to GPPUDCLK0 to make it take effect.
	mmio_write(UART0_ICR, 0x7FF); // Clear pending interrupts.
 
	// Setup UART0
	mmio_write(UART0_IBRD, 1); // Divider = 3000000 / (16 * 115200) = 1.627 = ~1.
	mmio_write(UART0_FBRD, 40); // Fractional part register = (.627 * 64) + 0.5 = 40.6 = ~40.
	mmio_write(UART0_LCRH, (1 << 4) | (1 << 5) | (1 << 6)); 	// Enable FIFO & 8 bit data transmission (1 stop bit, no parity).
	mmio_write(UART0_IMSC, (1 << 1) | (1 << 4) | (1 << 5) | (1 << 6) | (1 << 7) | (1 << 8) | (1 << 9) | (1 << 10)); // Mask all interrupts.
	mmio_write(UART0_CR, (1 << 0) | (1 << 8) | (1 << 9)); // Enable UART0, receive & transfer part of UART.
}
 
void uart_putc(unsigned char c)
{
	// Wait for UART to become ready to transmit.
	while ( mmio_read(UART0_FR) & (1 << 5) );
	mmio_write(UART0_DR, c);
}

void uart_puts(const char* str)
{
	for (size_t i = 0; str[i] != '\0'; i ++)
		uart_putc((unsigned char)str[i]);
}

void kernel_main(uint32_t r0, uint32_t r1, uint32_t atags)
{
	// initialize UART for Raspi2
	uart_init(2);
	uart_puts("Hello World!");
}