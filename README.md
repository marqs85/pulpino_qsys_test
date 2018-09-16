Pulpino Qsys integration example
==============

Overview
--------------------------
This is an example project demonstrating integration of Pulpino zero-riscy RISC-V core into Altera Platform Designer platform (formerly called Qsys or SOPC). HW integration code/scripts are on its own submodule under ip subdirectory, and sw subdirectory contains an example application that prints "Hello World" and lights up a few LEDs using other Altera platform IP (jtag_uart and pio). The code is targeted for DE2-115 development board, but it can be simulated on Modelsim-Altera without real HW or easily ported to other Altera FPGAs. The instructions below are mainly made with *nix systems in mind but everthing should work with Cygwin on Windows as well.

Prequisites
--------------------------
* [Quartus Lite](http://fpgasoftware.intel.com/?edition=lite) including Cyclone IV device support, Nios II EDS and ModelSim-Intel FPGA Edition.
* [RISC-V GNU Compiler Toolchain](https://github.com/riscv/riscv-gnu-toolchain)
* (Optional) [DE2-115](http://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=139&No=502) development board

SW build procedure
--------------------------
1. Download, configure, build and install RISC-V toolchain with Newlib + multilib support:
~~~~
git clone --recursive https://github.com/riscv/riscv-gnu-toolchain
cd riscv-gnu-toolchain
./configure --prefix=/opt/riscv --enable-multilib
make
make install
~~~~
2. Compile custom binary to IHEX converter:
~~~~
cd pulpino_qsys_test
gcc tools/bin2hex.c -o tools/bin2hex
~~~~
3. Compile example application image
~~~~
cd sw
make
~~~~

RTL (bitstream) buid procedure
--------------------------
1. Load the project (pulpino_qsys_test.qpf) in Quartus
2. Generate QSYS output files
    * Open Platform Designer (Tools -> Platform Designer)
    * Load platform configuration (sys.qsys)
    * Generate output (Generate -> Generate HDL, Generate)
    * Close Platform Designer
3. Generate FPGA bitstream (Processing -> Start Compilation)


Run testbench on simulator
--------------------------
1. Tools -> Run Simulation Tool -> RTL Simulation
2. Check that "Hello World" is printed on simulator console and "led" on waveform window changes into "11110000"

Run test on DE2-115
--------------------------
1. Program bitstream (output_files/pulpino_qsys_test.sof) on the board
2. Ensure that LEDG[7:4] are turned on
3. Open nios2-terminal and check that "Hello World" is printed out

Reprogram RISC-V dynamically (on DE2-115)
--------------------------
1. Modify sw/hello.c (e.g. change LED output from 0xf0 to 0xff)
2. Run "make rv-reprogram" on sw subdirectory
3. Ensure that board is reset and updated LED pattern is shown
4. (Optional) If you want to update bitstream with the new RISC-V code (no RTL changes), just run "Processing->Update Memory Initialization File" and "Processing->Start->Start Assembler" in Quartus
