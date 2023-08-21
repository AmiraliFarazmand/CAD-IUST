SetActiveLib -work
comp -include "$dsn\src\32More.vhd" 
comp -include "$dsn\src\TestBench\module_moore_TB.vhd" 
asim +access +r TESTBENCH_FOR_module_moore 
wave 
wave -noreg input
wave -noreg reset
wave -noreg clk
wave -noreg output
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\module_moore_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_module_moore 
