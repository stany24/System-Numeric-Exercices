library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Main2 is
    Port ( Input : in STD_LOGIC_VECTOR (3 downto 0);
           Y5 : out STD_LOGIC;
           Y7 : out STD_LOGIC);
end Main2;

architecture Behavioral of Main2 is

begin
    Y5 <= '0' when Input = "1101" ELSE '1';
    Y7 <= '0' when Input = "1111" ELSE '1';
    

end Behavioral;
