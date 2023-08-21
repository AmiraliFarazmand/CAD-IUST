library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY tb_RAM_VHDL IS
END tb_RAM_VHDL;
 
ARCHITECTURE behavior OF tb_RAM_VHDL IS
 
    -- Component Declaration for the single-port RAM in VHDL
    COMPONENT Single_port_RAM_VHDL
    PORT (
        RAM_ADDR : IN  std_logic_vector(6 downto 0);
        RAM_DATA_IN : IN  std_logic_vector(7 downto 0);
        RAM_WR : IN  std_logic;
        RAM_CLOCK : IN  std_logic;
        RAM_DATA_OUT : OUT  std_logic_vector(7 downto 0);
        timer : IN unsigned(7 downto 0);
        infinityFlag : IN std_logic
    );
    END COMPONENT;

    --Inputs
    signal RAM_ADDR : std_logic_vector(6 downto 0) := (others => '0');
    signal RAM_DATA_IN : std_logic_vector(7 downto 0) := (others => '0');
    signal RAM_WR : std_logic := '0';
    signal RAM_CLOCK : std_logic := '0';
    signal timer : unsigned(7 downto 0) := (others => '0');
    signal infinityFlag : std_logic := '0';

    --Outputs
    signal RAM_DATA_OUT : std_logic_vector(7 downto 0);

    -- Clock period definitions
    constant RAM_CLOCK_period : time := 10 ns;
 
BEGIN
 
    -- Instantiate the single-port RAM in VHDL
    uut: Single_port_RAM_VHDL PORT MAP (
        RAM_ADDR => RAM_ADDR,
        RAM_DATA_IN => RAM_DATA_IN,
        RAM_WR => RAM_WR,
        RAM_CLOCK => RAM_CLOCK,
        RAM_DATA_OUT => RAM_DATA_OUT,
        timer => timer,
        infinityFlag => infinityFlag
    );

    -- Clock process definitions
    RAM_CLOCK_process : process
    begin
        RAM_CLOCK <= '0';
        wait for RAM_CLOCK_period/2;
        RAM_CLOCK <= '1';
        wait for RAM_CLOCK_period/2;
    end process;

    stim_proc: process
    begin  
        RAM_WR <= '0'; 
        RAM_ADDR <= "0000000";
        RAM_DATA_IN <= x"FF";
        timer <= to_unsigned(2, 8);  -- Set timer value
        infinityFlag <= '0';  -- Set infinity flag to false


        
        -- Start reading data from RAM 
        for i in 0 to 5 loop
            RAM_ADDR <= std_logic_vector(unsigned(RAM_ADDR) + 1);
            wait for RAM_CLOCK_period * 5;
        end loop;

        RAM_ADDR <= "0000000";
        RAM_WR <= '1';
		
		wait for 50 ns;  
		infinityFlag <= '1';  -- Set infinity flag to true	  
		wait for 30 ns;  
		infinityFlag <= '0';  -- Set infinity flag to true	
		wait for 20 ns;  
		infinityFlag <= '0';  -- Set infinity flag to true
        -- Start writing to RAM
        wait for 100 ns; 

        for i in 0 to 5 loop
            RAM_ADDR <= std_logic_vector(unsigned(RAM_ADDR) + 1);
            RAM_DATA_IN <= std_logic_vector(unsigned(RAM_DATA_IN) - 1);
            timer <= to_unsigned(5, 8);  -- Set timer value
            infinityFlag <= '0';  -- Set infinity flag to false
            wait for RAM_CLOCK_period * 5;
        end loop;

        RAM_WR <= '0';
        
        wait;
    end process;

END;
