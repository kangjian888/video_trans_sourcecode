#system clock constrain
set_property IOSTANDARD LVDS_25 [get_ports SYSCLK_P]
set_property PACKAGE_PIN P3 [get_ports SYSCLK_N]
set_property PACKAGE_PIN R3 [get_ports SYSCLK_P]
set_property IOSTANDARD LVDS_25 [get_ports SYSCLK_N]
#globle reset constrain, GPIO_SW_C BUTTON
set_property PACKAGE_PIN U6 [get_ports reset]
set_property IOSTANDARD SSTL15 [get_ports reset]
#for debug, using PMOD_0 to observe data_out_valid_signal
#set_property PACKAGE_PIN P26 [get_ports data_out_valid_debug]
#set_property IOSTANDARD LVCMOS33 [get_ports data_out_valid_debug]
#for debug, using PMOD_1 to observe full from fifo
set_property PACKAGE_PIN T22 [get_ports full]
set_property IOSTANDARD LVCMOS33 [get_ports full]

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

