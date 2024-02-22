-- Engineer: Gouvernon Stan

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comp is
    Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
           B : in STD_LOGIC_VECTOR (1 downto 0);
           Z : out STD_LOGIC_VECTOR (2 downto 0));
end comp;

architecture Behavioral of comp is

begin
    Z <= "100" WHEN A < B ELSE
        "010" WHEN A = B ELSE
        "001" WHEN A > B ELSE "---";

end Behavioral;
