LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY divfreq IS
	PORT (
      clk : IN std_logic;
	  divider:IN std_logic_vector(7 downto 0);  
      reset_n : IN std_logic;
	  div : OUT std_logic);
END divfreq;

ARCHITECTURE behavioral OF divfreq IS

SIGNAL counter : std_logic_vector(7 downto 0);

BEGIN

PROCESS(clk, reset_n)
BEGIN
	IF reset_n = '0' THEN
		counter <= divider;
		div <= '0';
	ELSIF clk'EVENT AND clk = '1' THEN
		IF UNSIGNED(counter) = 0 THEN
			counter <= divider;
			div <= '1';
		ELSE
			counter <= STD_LOGIC_VECTOR(UNSIGNED(counter) - 1);
			div <= '0';
		END IF;
	END IF;
END PROCESS;

END behavioral;