library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity moore is 
port(
clk: in std_logic;
reset: in std_logic;
input: in std_logic;
output: out std_logic
);
	end moore;

	
architecture behavioral of moore is
	constant s1: std_logic_vector(5 downto 0) := "000000";
    constant s2: std_logic_vector(5 downto 0) := "000001";
    constant s3: std_logic_vector(5 downto 0) := "000011";
    constant s4: std_logic_vector(5 downto 0) := "000111";
    constant s5: std_logic_vector(5 downto 0) := "001111";
    constant s6: std_logic_vector(5 downto 0) := "011111";
    constant s7: std_logic_vector(5 downto 0) := "111111";
	signal temp : std_logic_vector(5 downto 0) := s1;
	signal present_state: std_logic_vector(5 downto 0) := s1;
	signal m_input : std_logic_vector(5 downto 0);
	--output <= '0';
	begin
		process(clk, reset)
		begin
			-- m_input <= input;
			if reset = '1' then
				present_state <= s1;
			elsif rising_edge(clk) then
				case present_state is
					when s1 =>
						if input = '1' then
							present_state <= s2;   --input_vector(3 downto 0) & '1';
							temp <= temp(4 downto 0) & '1';
							output <= '0';
							-- input <= temp
						elsif input = '0'  then
							present_state <= s2;
							temp <= temp(4 downto 0) & '0';
							output <= '0';
						end if;
					when s2 =>
						if input = '1' then
							present_state <= s3;   --input_vector(3 downto 0) & '1';
							temp <= temp(4 downto 0) & '1';
							-- input <= temp
							output <= '0';

						elsif input = '0'  then
							present_state <= s3;
							temp <= temp(4 downto 0) & '0';
							output <= '0';

						end if;
					when s3 =>
					if input = '1' then
						present_state <= s4;   --input_vector(3 downto 0) & '1';
						temp <= temp(4 downto 0) & '1';
						output <= '0';

						-- input <= temp
					elsif input = '0' then
						present_state <= s4;
						temp <= temp(4 downto 0) & '0';
						output <= '0';

					end if;
					when s4 =>
					if input = '1' then
						present_state <= s5;   --input_vector(3 downto 0) & '1';
						temp <= temp(4 downto 0) & '1';
						-- input <= temp
						output <= '0';

					elsif input = '0'  then
						present_state <= s5;
						temp <= temp(4 downto 0) & '0';
						output <= '0';

					end if;
					when s5 =>
					if input = '1' then
						present_state <= s6;   
						temp <= temp(4 downto 0) & '1';
						-- input <= temp
						output <= '0';

					elsif input = '0' then
						present_state <= s6;
						temp <= temp(4 downto 0) & '0';
						output <= '0';

					end if;
					when s6 =>
					if input = '1' then
						present_state <= s7;   
						temp <= temp(4 downto 0) & '1';
						-- input <= temp
						output <= '0';

					elsif input = '0' then
						present_state <= s7;
						temp <= temp(4 downto 0) & '0';
						output <= '0';

					end if;
					when s7 =>
					if temp(5) = '1' then
						output <= '1';
					elsif input = '1' then
						present_state <= s7;   
						temp <= temp(4 downto 0) & '1';
						-- input <= temp
						output <= '0';

					elsif input = '0'	then
						present_state <= s7;
						temp <= temp(4 downto 0) & '0';
						output <= '0';

					end if;
					when others =>
                    present_state <= s1;
					output <= '0';

				end case;
			end if;
		end process;
	end behavioral;
