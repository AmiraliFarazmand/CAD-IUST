library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Single_port_RAM_VHDL is
    port (
        RAM_ADDR: in std_logic_vector(6 downto 0);  -- Address to write/read RAM
        RAM_DATA_IN: in std_logic_vector(7 downto 0);  -- Data to write into RAM
        RAM_WR: in std_logic;  -- Write enable
        RAM_CLOCK: in std_logic;  -- Clock input for RAM
        RAM_DATA_OUT: out std_logic_vector(7 downto 0);  -- Data output of RAM
        timer: in unsigned(7 downto 0);  -- Timer value for the address
        infinityFlag: in std_logic  -- Infinity flag for the address
    );
end Single_port_RAM_VHDL;

architecture Behavioral of Single_port_RAM_VHDL is
    type RAM_ARRAY is array (0 to 127) of std_logic_vector(7 downto 0);
    type TIMER_ARRAY is array (0 to 127) of unsigned(7 downto 0);
    type INFINITY_ARRAY is array (0 to 127) of std_logic;

signal RAM: RAM_ARRAY :=(
   x"55",x"66",x"77",x"67",-- 0x00: 
   x"99",x"00",x"00",x"11",-- 0x04: 
   x"00",x"00",x"00",x"00",-- 0x08: 
   x"00",x"00",x"00",x"00",-- 0x0C: 
   x"00",x"00",x"00",x"00",-- 0x10: 
   x"00",x"00",x"00",x"00",-- 0x14: 
   x"00",x"00",x"00",x"00",-- 0x18: 
   x"00",x"00",x"00",x"00",-- 0x1C: 
   x"00",x"00",x"00",x"00",-- 0x20: 
   x"00",x"00",x"00",x"00",-- 0x24: 
   x"00",x"00",x"00",x"00",-- 0x28: 
   x"00",x"00",x"00",x"00",-- 0x2C: 
   x"00",x"00",x"00",x"00",-- 0x30: 
   x"00",x"00",x"00",x"00",-- 0x34: 
   x"00",x"00",x"00",x"00",-- 0x38: 
   x"00",x"00",x"00",x"00",-- 0x3C: 
   x"00",x"00",x"00",x"00",-- 0x40: 
   x"00",x"00",x"00",x"00",-- 0x44: 
   x"00",x"00",x"00",x"00",-- 0x48: 
   x"00",x"00",x"00",x"00",-- 0x4C: 
   x"00",x"00",x"00",x"00",-- 0x50: 
   x"00",x"00",x"00",x"00",-- 0x54: 
   x"00",x"00",x"00",x"00",-- 0x58: 
   x"00",x"00",x"00",x"00",-- 0x5C: 
   x"00",x"00",x"00",x"00",
   x"00",x"00",x"00",x"00",
   x"00",x"00",x"00",x"00",
   x"00",x"00",x"00",x"00",
   x"00",x"00",x"00",x"00",
   x"00",x"00",x"00",x"00",
   x"00",x"00",x"00",x"00",
   x"00",x"00",x"00",x"00"
   ); 
    signal timers: TIMER_ARRAY := (
        (others => (others => '0'))  -- Initialize all timers to zero
    );
    signal infinityFlags: INFINITY_ARRAY := (
        (others => '0')  -- Initialize all infinity flags to zero
    );

begin
    process (RAM_CLOCK)
    begin
        if rising_edge(RAM_CLOCK) then
            if RAM_WR = '1' then
                RAM(to_integer(unsigned(RAM_ADDR))) <= RAM_DATA_IN;
                timers(to_integer(unsigned(RAM_ADDR))) <= timer;
                infinityFlags(to_integer(unsigned(RAM_ADDR))) <= infinityFlag;
            end if;
            
            for i in timers'range loop
                if timers(i) > 0 and infinityFlags(i) = '0' then
                    timers(i) <= timers(i) - 1;
                elsif timers(i) = 0 then
                    RAM(i) <= (others => '0');  -- Reset data when timer reaches zero
                end if;
            end loop;
        end if;
    end process;

    RAM_DATA_OUT <= RAM(to_integer(unsigned(RAM_ADDR)));

end Behavioral;
