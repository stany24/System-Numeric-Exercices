library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Exercice1 is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           S : out STD_LOGIC;
           Y : out STD_LOGIC);
end Exercice1;

architecture Behavioral of Exercice1 is

begin

S <= (A or not(B)) and (A and not(C));
Y <= (not(A) and B and C) or (A and B and C) or (A and B and not(C));

end Behavioral;
