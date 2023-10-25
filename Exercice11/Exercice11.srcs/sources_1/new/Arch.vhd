library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Arch is
    Port ( clk : in STD_LOGIC;
           reset_n : in STD_LOGIC;
           d : in STD_LOGIC;
           q : out STD_LOGIC;
           enable : in STD_LOGIC);
end Arch;

architecture Behavioral of Arch is

begin
p1:PROCESS (clk, reset_n) BEGIN
    IF reset_n = '0' THEN q <= '0';
    ELSIF rising_edge(clk) and enable = '1' THEN q <= d;
    END IF;
END PROCESS;

end Behavioral;
