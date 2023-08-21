SetActiveLib -work
comp -include "$dsn\src\main.vhd" 
comp -include "$dsn\src\TestBench\single_port_ram_vhdl_TB.vhd" 
asim +access +r TESTBENCH_FOR_single_port_ram_vhdl 
wave 
wave -noreg RAM_ADDR
wave -noreg RAM_DATA_IN
wave -noreg RAM_WR
wave -noreg RAM_CLOCK
wave -noreg RAM_DATA_OUT
wave -noreg timer
wave -noreg infinityFlag
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\single_port_ram_vhdl_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_single_port_ram_vhdl 
