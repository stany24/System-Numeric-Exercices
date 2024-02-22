LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
ENTITY Divisor IS
	PORT ( clk : IN std_logic;
		Reset_n : IN std_logic;
		ebl_1Hz : out    std_logic;
        test    : in     std_logic);
END Divisor;
ARCHITECTURE behavioral OF Divisor IS
SIGNAL counter : std_logic_vector(26 downto 0);
BEGIN
PROCESS(clk, reset_n)
BEGIN
	IF reset_n = '0' THEN
	   if test = '0' then
		  counter <= "101111101011110000100000000";
	   else
	       counter <= "00000000000000000000001010";
	   end if;
	   ebl_1Hz <= '0';
	ELSIF clk'EVENT AND clk = '1' THEN
		IF UNSIGNED(counter) = 0 THEN
			if test = '0' then
              counter <= "101111101011110000100000000";
           else
               counter <= "00000000000000000000001010";
           end if;
		   ebl_1Hz <= '1';
		ELSE
			counter <= STD_LOGIC_VECTOR(UNSIGNED(counter) - 1);
			ebl_1Hz <= '0';
		END IF;
	END IF;
END PROCESS;
END behavioral;