`timescale 1ns/10ps

module tbench();

reg clk50;
reg reset_n;

wire [7:0] led;

pulpino_qsys_test dut(
    .CLK(clk50),
    .RESET_N(reset_n),
    .LEDG(led)
);

initial begin
    reset_n = 1'b0;
    #10ns reset_n = 1'b1;
end

initial begin
    clk50 = 0;

    forever begin
        #10ns clk50 = ~clk50;
    end
end

endmodule
