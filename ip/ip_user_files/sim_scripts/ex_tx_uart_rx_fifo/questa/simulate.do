onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ex_tx_uart_rx_fifo_opt

do {wave.do}

view wave
view structure
view signals

do {ex_tx_uart_rx_fifo.udo}

run -all

quit -force
