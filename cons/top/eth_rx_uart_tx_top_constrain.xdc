#system clock constrain
set_property IOSTANDARD LVDS_25 [get_ports SYSCLK_P]
set_property PACKAGE_PIN P3 [get_ports SYSCLK_N]
set_property PACKAGE_PIN R3 [get_ports SYSCLK_P]
set_property IOSTANDARD LVDS_25 [get_ports SYSCLK_N]
#globle reset constrain, GPIO_SW_C BUTTON
set_property PACKAGE_PIN U6 [get_ports reset]
set_property IOSTANDARD SSTL15 [get_ports reset]