-- Engineer: Gouvernon Stan

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port ( In1 : in STD_LOGIC_VECTOR (2 downto 0);
           In2 : in STD_LOGIC_VECTOR (2 downto 0);
           Mux : out STD_LOGIC_VECTOR (2 downto 0);
           sel : in STD_LOGIC);
end mux;

architecture Behavioral of mux is

begin
    Mux <= In1 WHEN sel = '0' ELSE
        In2 WHEN sel = '1';

end Behavioral;
