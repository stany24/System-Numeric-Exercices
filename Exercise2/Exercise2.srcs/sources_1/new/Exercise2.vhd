

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Exercise2 is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           D : in STD_LOGIC;
           Ya : out STD_LOGIC;
           Yb : out STD_LOGIC;
           Yc : out STD_LOGIC;
           Yd : out STD_LOGIC;
           Ye : out STD_LOGIC;
           Yf : out STD_LOGIC;
           Yg : out STD_LOGIC;
           Aff_enable : out STD_LOGIC);
end Exercise2;

architecture Behavioral of Exercise2 is

begin
Aff_enable <= '1';

-- Ya
Ya <= ((not A) and (not B) and (not C)) or (A and (not B) and C) or (A and B and C) or (A and B and (not C));

-- Yb
Yb <= ((not A) and (not B) and (not C)) or ((not A) and (not B) and D) or ((not A) and B);

-- Yc
Yc <= ((not A) and B and D) or ((not A) and B);

-- Yd
Yd <= ((not A) and (not B) and C) or (A and B);

-- Ye
Ye <= ((not B) and (not C)) or ((not A) and B) or (A and (not B)) or (A and B);

-- Yf
Yf <= ((not A) and (not B) and C) or ((not A) and (not B) and D);

-- Yg
Yg <= (B and (not C)) or ((not A) and (not B) and D) or (A and B and D);

end Behavioral;
