### Clocks ###

create_clock -period 50MHz -name clk50 [get_ports CLK]

#derive_pll_clocks
create_generated_clock -master_clock clk50 -source {pll0|altpll_component|auto_generated|pll1|inclk[0]} -divide_by 2 -duty_cycle 50.00 -name clk25 {pll0|altpll_component|auto_generated|pll1|clk[0]}
derive_clock_uncertainty


### IO ###

set_false_path -from [get_ports RESET_N]
set_false_path -to [get_ports LEDG*]


### JTAG Signal Constraints ###

#constrain the TCK port
#create_clock -name tck -period "10MHz" [get_ports altera_reserved_tck]
#cut all paths to and from tck
set_clock_groups -exclusive -group [get_clocks altera_reserved_tck]
#constrain the TDI port
set_input_delay -clock altera_reserved_tck 20 [get_ports altera_reserved_tdi]
#constrain the TMS port
set_input_delay -clock altera_reserved_tck 20 [get_ports altera_reserved_tms]
#constrain the TDO port
set_output_delay -clock altera_reserved_tck 20 [get_ports altera_reserved_tdo]
