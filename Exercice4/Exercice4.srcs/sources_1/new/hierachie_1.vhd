library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hierachie_1 is
    Port ( input1 : in STD_LOGIC;
           input2 : in STD_LOGIC;
           input3 : in STD_LOGIC;
           and_3 : out STD_LOGIC;
           or_3 : out STD_LOGIC);
end hierachie_1;

architecture Behavioral of hierachie_1 is

begin
    and_3 <= (input1 and input2 and input3);
    or_3 <= (input1 or input2 or input3);

end Behavioral;
