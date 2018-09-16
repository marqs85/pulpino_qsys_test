module pulpino_qsys_test(
    input CLK,
    input RESET_N,
    output [7:0] LEDG
);

wire clk25;
wire jtag_reset;
wire [7:0] gpio;

assign LEDG = gpio;

pll_sys pll0 (
    .inclk0(CLK),
    .c0(clk25)
);

sys u0 (
    .clk_clk                            (clk25),
    .reset_reset_n                      (RESET_N & ~jtag_reset),
    .master_0_master_reset_reset        (jtag_reset),
    .pulpino_0_config_testmode_i        (1'b0),
    .pulpino_0_config_fetch_enable_i    (1'b1),
    .pulpino_0_config_clock_gating_i    (1'b0),
    .pulpino_0_config_boot_addr_i       (32'h00008000),
    .pio_0_external_connection_export   (gpio)
);

endmodule
