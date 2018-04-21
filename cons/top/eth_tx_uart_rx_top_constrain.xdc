#system clock constrain
set_property IOSTANDARD LVDS_25 [get_ports SYSCLK_P]
set_property PACKAGE_PIN P3 [get_ports SYSCLK_N]
set_property PACKAGE_PIN R3 [get_ports SYSCLK_P]
set_property IOSTANDARD LVDS_25 [get_ports SYSCLK_N]
#globle reset constrain, GPIO_SW_C BUTTON
set_property PACKAGE_PIN U6 [get_ports reset]
set_property IOSTANDARD SSTL15 [get_ports reset]

#VOLTAGE CONSTRAIN
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
#observing the data recieved from uart interface
#set_property PACKAGE_PIN P26 [get_ports {dout_out[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dout_out[0]}]
#set_property PACKAGE_PIN T22 [get_ports {dout_out[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dout_out[1]}]
#set_property PACKAGE_PIN R22 [get_ports {dout_out[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dout_out[2]}]
#set_property PACKAGE_PIN T23 [get_ports {dout_out[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dout_out[3]}]
#
#set_property PACKAGE_PIN L22 [get_ports {dout_out[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dout_out[4]}]
#set_property PACKAGE_PIN M24 [get_ports {dout_out[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dout_out[5]}]
#set_property PACKAGE_PIN L20 [get_ports {dout_out[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dout_out[6]}]
#set_property PACKAGE_PIN L23 [get_ports {dout_out[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {dout_out[7]}]
#
#set_property PACKAGE_PIN M25 [get_ports rx_done_signal_out]
#set_property IOSTANDARD LVCMOS33 [get_ports rx_done_signal_out]

