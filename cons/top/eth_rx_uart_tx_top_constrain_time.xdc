create_clock -period 40.000 -name PHY_RX_CLK -waveform {0.000 20.000} -add [get_ports PHY_RX_CLK]
set_clock_groups -asynchronous -group [get_clocks PHY_RX_CLK] -group [get_clocks SYSCLK_P]






create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list PHY_RX_CLK_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 48 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {ethernet_recieve_inst/board_mac[0]} {ethernet_recieve_inst/board_mac[1]} {ethernet_recieve_inst/board_mac[2]} {ethernet_recieve_inst/board_mac[3]} {ethernet_recieve_inst/board_mac[4]} {ethernet_recieve_inst/board_mac[5]} {ethernet_recieve_inst/board_mac[6]} {ethernet_recieve_inst/board_mac[7]} {ethernet_recieve_inst/board_mac[8]} {ethernet_recieve_inst/board_mac[9]} {ethernet_recieve_inst/board_mac[10]} {ethernet_recieve_inst/board_mac[11]} {ethernet_recieve_inst/board_mac[12]} {ethernet_recieve_inst/board_mac[13]} {ethernet_recieve_inst/board_mac[14]} {ethernet_recieve_inst/board_mac[15]} {ethernet_recieve_inst/board_mac[16]} {ethernet_recieve_inst/board_mac[17]} {ethernet_recieve_inst/board_mac[18]} {ethernet_recieve_inst/board_mac[19]} {ethernet_recieve_inst/board_mac[20]} {ethernet_recieve_inst/board_mac[21]} {ethernet_recieve_inst/board_mac[22]} {ethernet_recieve_inst/board_mac[23]} {ethernet_recieve_inst/board_mac[24]} {ethernet_recieve_inst/board_mac[25]} {ethernet_recieve_inst/board_mac[26]} {ethernet_recieve_inst/board_mac[27]} {ethernet_recieve_inst/board_mac[28]} {ethernet_recieve_inst/board_mac[29]} {ethernet_recieve_inst/board_mac[30]} {ethernet_recieve_inst/board_mac[31]} {ethernet_recieve_inst/board_mac[32]} {ethernet_recieve_inst/board_mac[33]} {ethernet_recieve_inst/board_mac[34]} {ethernet_recieve_inst/board_mac[35]} {ethernet_recieve_inst/board_mac[36]} {ethernet_recieve_inst/board_mac[37]} {ethernet_recieve_inst/board_mac[38]} {ethernet_recieve_inst/board_mac[39]} {ethernet_recieve_inst/board_mac[40]} {ethernet_recieve_inst/board_mac[41]} {ethernet_recieve_inst/board_mac[42]} {ethernet_recieve_inst/board_mac[43]} {ethernet_recieve_inst/board_mac[44]} {ethernet_recieve_inst/board_mac[45]} {ethernet_recieve_inst/board_mac[46]} {ethernet_recieve_inst/board_mac[47]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 8 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {ethernet_recieve_inst/bytedate[0]} {ethernet_recieve_inst/bytedate[1]} {ethernet_recieve_inst/bytedate[2]} {ethernet_recieve_inst/bytedate[3]} {ethernet_recieve_inst/bytedate[4]} {ethernet_recieve_inst/bytedate[5]} {ethernet_recieve_inst/bytedate[6]} {ethernet_recieve_inst/bytedate[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 23 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {status[0]} {status[1]} {status[2]} {status[3]} {status[4]} {status[5]} {status[6]} {status[7]} {status[8]} {status[9]} {status[10]} {status[11]} {status[12]} {status[13]} {status[14]} {status[15]} {status[16]} {status[17]} {status[18]} {status[19]} {status[20]} {status[21]} {status[22]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 48 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {ethernet_recieve_inst/pc_mac[0]} {ethernet_recieve_inst/pc_mac[1]} {ethernet_recieve_inst/pc_mac[2]} {ethernet_recieve_inst/pc_mac[3]} {ethernet_recieve_inst/pc_mac[4]} {ethernet_recieve_inst/pc_mac[5]} {ethernet_recieve_inst/pc_mac[6]} {ethernet_recieve_inst/pc_mac[7]} {ethernet_recieve_inst/pc_mac[8]} {ethernet_recieve_inst/pc_mac[9]} {ethernet_recieve_inst/pc_mac[10]} {ethernet_recieve_inst/pc_mac[11]} {ethernet_recieve_inst/pc_mac[12]} {ethernet_recieve_inst/pc_mac[13]} {ethernet_recieve_inst/pc_mac[14]} {ethernet_recieve_inst/pc_mac[15]} {ethernet_recieve_inst/pc_mac[16]} {ethernet_recieve_inst/pc_mac[17]} {ethernet_recieve_inst/pc_mac[18]} {ethernet_recieve_inst/pc_mac[19]} {ethernet_recieve_inst/pc_mac[20]} {ethernet_recieve_inst/pc_mac[21]} {ethernet_recieve_inst/pc_mac[22]} {ethernet_recieve_inst/pc_mac[23]} {ethernet_recieve_inst/pc_mac[24]} {ethernet_recieve_inst/pc_mac[25]} {ethernet_recieve_inst/pc_mac[26]} {ethernet_recieve_inst/pc_mac[27]} {ethernet_recieve_inst/pc_mac[28]} {ethernet_recieve_inst/pc_mac[29]} {ethernet_recieve_inst/pc_mac[30]} {ethernet_recieve_inst/pc_mac[31]} {ethernet_recieve_inst/pc_mac[32]} {ethernet_recieve_inst/pc_mac[33]} {ethernet_recieve_inst/pc_mac[34]} {ethernet_recieve_inst/pc_mac[35]} {ethernet_recieve_inst/pc_mac[36]} {ethernet_recieve_inst/pc_mac[37]} {ethernet_recieve_inst/pc_mac[38]} {ethernet_recieve_inst/pc_mac[39]} {ethernet_recieve_inst/pc_mac[40]} {ethernet_recieve_inst/pc_mac[41]} {ethernet_recieve_inst/pc_mac[42]} {ethernet_recieve_inst/pc_mac[43]} {ethernet_recieve_inst/pc_mac[44]} {ethernet_recieve_inst/pc_mac[45]} {ethernet_recieve_inst/pc_mac[46]} {ethernet_recieve_inst/pc_mac[47]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 8 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {rx_data_out[0]} {rx_data_out[1]} {rx_data_out[2]} {rx_data_out[3]} {rx_data_out[4]} {rx_data_out[5]} {rx_data_out[6]} {rx_data_out[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list byte_rxdv]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list data_out_valid]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets PHY_RX_CLK_IBUF_BUFG]
