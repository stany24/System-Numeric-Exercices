library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Arch is
    Port ( ADR : in STD_LOGIC_VECTOR (15 downto 0);
           CS_RAM : out STD_LOGIC;
           CS_FLASH : out STD_LOGIC;
           CS_EEPROM : out STD_LOGIC);
end Arch;

architecture Behavioral of Arch is

begin
    CS_RAM <= '0' when ADR <= X"3FFF" else '1';
    CS_FLASH <= '0' when ADR >= X"4000" and ADR <= X"CFFF" else '1';
    CS_EEPROM <= '0' when ADR >= X"E800" and ADR <= X"EBFF" else '1';

end Behavioral;
