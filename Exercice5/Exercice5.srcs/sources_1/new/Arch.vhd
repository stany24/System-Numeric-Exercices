library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Arch is
    Port ( ina : in STD_LOGIC_VECTOR (3 downto 0);
           inb : in STD_LOGIC_VECTOR (3 downto 0);
           inc : in STD_LOGIC_VECTOR (3 downto 0);
           ind : in STD_LOGIC_VECTOR (3 downto 0);
           sel : in std_logic_VECTOR (1 downto 0);
           mux : out STD_LOGIC_VECTOR (3 downto 0));
end Arch;

architecture Behavioral of Arch is

begin
    WITH sel SELECT
        mux <= ina when "00",
               inb when "01",
               inc when "10",
               ind when "11",
               "0000" when OTHERS;


end Behavioral;
