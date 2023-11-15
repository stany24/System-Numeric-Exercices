library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Arch is
	Port ( clk : in std_logic;
		reset_n : in std_logic;
		reset_s : in std_logic;
		enable :in std_logic;
		d : in std_logic_vector(7 downto 0);  
		q : out std_logic_vector(7 downto 0));
end Arch;
architecture behavioral of Arch is
BEGIN
p1:PROCESS (clk, reset_n) BEGIN
	IF reset_n = '0' THEN --reset asynchrone actif bas
		q <= (OTHERS => '0');
	ELSIF rising_edge(clk) THEN
	   IF reset_s = '1' THEN
	       q <= (OTHERS => '0');
	   ELSIF enable = '1' THEN
	       q <= d;
	   END IF;
	END IF;
END PROCESS;
end behavioral;