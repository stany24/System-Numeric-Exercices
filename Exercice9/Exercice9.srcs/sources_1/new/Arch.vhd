library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Arch is
    Port ( ina : in STD_LOGIC_VECTOR (7 downto 0);
           inb : in STD_LOGIC_VECTOR (7 downto 0);
           ebl : in STD_LOGIC;
           PP : out STD_LOGIC;
           EG : out STD_LOGIC;
           PG : out STD_LOGIC);
end Arch;

architecture Behavioral of Arch is

begin
    PP <= '1' when ina < inb and ebl = '1' else 'Z';
    EG <= '1' when ina = inb and ebl = '1' else 'Z';
    PG <= '1' when ina > inb and ebl = '1' else 'Z';


end Behavioral;
