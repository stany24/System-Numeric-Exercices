library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Counter8 is
	port (
      clk       : in     std_logic;
      reset_n   : in     std_logic;
      Cnt_value : out    std_logic_vector(7 downto 0);
      cnt_ebl   : in     std_logic;
      ebl_1Hz   : in     std_logic);
end Counter8;
architecture behavioral of Counter8 is
SIGNAL counter : std_logic_vector(7 DOWNTO 0); --Signal interne pour compteur
BEGIN
PROCESS (clk, reset_n)
BEGIN
	IF reset_n = '0' THEN --remise a zero asynchrone
		counter <= (OTHERS => '0');
	END IF;
    IF clk'EVENT AND clk = '1' THEN
        if ebl_1Hz = '1' then
            if cnt_ebl = '1' then
                counter <= STD_LOGIC_VECTOR(UNSIGNED(counter) + 1);
            else
                counter <= "00000000";
            end if;
        end if;
	END IF;
END PROCESS;
Cnt_value <=counter;
end behavioral;