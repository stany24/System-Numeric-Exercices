library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity counter8 is
	Port ( clk : in std_logic;
		reset_n : in std_logic;
		inc : in std_logic;
		sw : in std_logic_vector(7 DOWNTO 0);
		enable : in std_logic;
		load : in std_logic;
		led : out std_logic_vector(7 DOWNTO 0)
		);
end counter8;
architecture behavioral of counter8 is
SIGNAL counter : std_logic_vector(7 DOWNTO 0); --Signal interne pour compteur
BEGIN
PROCESS (clk, reset_n)
BEGIN
	IF reset_n = '0' THEN --remise a zero asynchrone
		counter <= (OTHERS => '0');
		ELSIF clk'EVENT AND clk = '1' THEN
			IF load = '1' THEN --préréglage synchrone du compteur
				counter <= sw;
			ELSIF enable = '1' THEN
			    IF inc = '1' THEN --autorisation synchrone de compter
				    counter <= STD_LOGIC_VECTOR(UNSIGNED(counter) + 1);
				ELSE
				    counter <= STD_LOGIC_VECTOR(UNSIGNED(counter) - 1);
				END IF;
		END IF;
	END IF;
END PROCESS;
--Assignation du compteur sur les leds en sortie pour visualisation
led <= counter;
end behavioral;