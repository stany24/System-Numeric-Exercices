library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity source is
Port ( BCD : in std_logic_vector(3 downto 0);
       Ya : out STD_LOGIC;
       Yb : out STD_LOGIC;
       Yc : out STD_LOGIC;
       Yd : out STD_LOGIC;
       Ye : out STD_LOGIC;
       Yf : out STD_LOGIC;
       Yg : out STD_LOGIC;
       Aff_enable : out STD_LOGIC);
end source;

architecture Behavioral of source is

begin
Aff_enable <= '1';
Ya <= '0' when BCD = "0001" or BCD = "0100" else '1';
Yb <= '0' when BCD = "0101" or BCD = "0110" else '1';
Yc <= '0' when BCD = "0010" else '1';
Yd <= '0' when BCD = "0001" or BCD = "0100" or BCD = "0111" else '1';
Ye <= '1' when BCD = "0000" or BCD = "0010" or BCD = "0110" or BCD = "1000" else '0';
Yf <= '0' when BCD = "0001" or BCD = "0010" or BCD = "0011" or BCD = "0111" else '1';
Yg <= '0' when BCD = "0000" or BCD = "0001" or BCD = "0111" else '1';
end Behavioral;
