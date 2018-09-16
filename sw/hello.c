#include <stdio.h>
#include <string.h>

volatile int *gpio_addr = (int*)0x100000;
volatile int *jtag_uart_data = (int*)0x100010;
volatile int *jtag_uart_ctrl = (int*)0x100014;

const char msg[] = "Hello World!\n";

int main(int argc, char **argv)
{
    int i;

    for (i=0; i<strlen(msg); i++) {
        while ((*jtag_uart_ctrl >> 16) == 0) ;
        
        *jtag_uart_data = msg[i];
    }

    *gpio_addr = 0xf0;

    while (1) ;

    return 0;
}
