library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity module_moore_tb is
end module_moore_tb;

architecture TB_ARCHITECTURE of module_moore_tb is
	-- Component declaration of the tested unit
	component module_moore
	port(
		input : in STD_LOGIC;
		reset : in STD_LOGIC;
		clk : in STD_LOGIC;
		output : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal input : STD_LOGIC;
	signal reset : STD_LOGIC;
	signal clk : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal output : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : module_moore
		port map (
			input => input,
			reset => reset,
			clk => clk,
			output => output
		);
		clk_process : process
        begin
            clk <= '0';
            wait for 10 ns;
            -- wait for clk_period/2;
            clk <= '1';
            wait for 10 ns;
            -- wait for clk_period/2;
        end process;
		input <= '1' after 20 ns, '0' after 40 ns, '1' after 60 ns, '0' after 80 ns,
		'1' after 100 ns, '0' after 120 ns, '1' after 140 ns, '0' after 160 ns;	 
		reset <= '0' after 100 ns, '1' after 165 ns;
	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_module_moore of module_moore_tb is
	for TB_ARCHITECTURE
		for UUT : module_moore
			use entity work.module_moore(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_module_moore;

