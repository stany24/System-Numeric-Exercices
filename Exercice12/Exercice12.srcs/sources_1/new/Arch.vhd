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
SIGNAL temp_q : std_logic;

begin
    q <= temp_q;
    p1:PROCESS (clk, reset_n) BEGIN
        IF reset_n = '0' THEN temp_q <= '0';
        ELSIF rising_edge(clk) THEN 
            IF enable = '1' THEN temp_q <= not(temp_q);
            END IF;
        END IF;
    END PROCESS;

end Behavioral;
