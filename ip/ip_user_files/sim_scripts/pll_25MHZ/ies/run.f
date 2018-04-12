-makelib ies_lib/xil_defaultlib -sv \
  "F:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "F:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "F:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../pll_25MHZ/pll_25MHZ_clk_wiz.v" \
  "../../../../pll_25MHZ/pll_25MHZ.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

