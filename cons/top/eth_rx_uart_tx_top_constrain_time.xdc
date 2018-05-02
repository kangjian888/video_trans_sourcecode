create_clock -period 40.000 -name PHY_RX_CLK -waveform {0.000 20.000} -add [get_ports PHY_RX_CLK]
set_clock_groups -asynchronous -group [get_clocks PHY_RX_CLK] -group [get_clocks SYSCLK_P]








