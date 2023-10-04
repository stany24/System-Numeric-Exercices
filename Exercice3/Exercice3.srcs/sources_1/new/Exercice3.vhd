library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.bcd7seg.all;

entity Exercice3 is
Port ( BCD : in std_logic_vector(3 downto 0);
       Aff : out std_logic_vector(6 downto 0);
       Aff_enable : out STD_LOGIC);
end Exercice3;

architecture Behavioral of Exercice3 is

begin
    Aff_enable <= '1';
    with BCD select 
        Aff <= one_aff when one,
           "0111111" when "0000",
           "1011011" when "0010",
           "1001111" when "0011",
           "1100110" when "0100",
           "1101101" when "0101",
           "1111101" when "0110",
           "0000111" when "0111",
           "1111111" when "1000",
           "1101111" when "1001",
           "0101101" when OTHERS;

end Behavioral;
