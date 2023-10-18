library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hierachie_2 is
    Port ( sel : in STD_LOGIC;
           and_3 : in STD_LOGIC;
           or_3 : in STD_LOGIC;
           out1 : out STD_LOGIC;
           sel_out : out STD_LOGIC);
end hierachie_2;

architecture Behavioral of hierachie_2 is

begin
    sel_out <= sel;
    WITH sel SELECT
        out1 <= and_3 when '0',
                or_3 when '1';
        
end Behavioral;
