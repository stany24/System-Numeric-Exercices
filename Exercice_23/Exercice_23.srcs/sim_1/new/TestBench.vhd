LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE structure OF testbench IS

--Declaration du composant UUT (Unit Under Test)
component FSM_Moore
port (
  clk       : in     std_logic;
  reset_n   : in     std_logic;
  cnt_ebl   : out    std_logic;
  Cnt_value : in     std_logic_vector(7 downto 0);
  capteur   : in     std_logic;
  feuxP1    : out    std_logic_vector(1 downto 0);
  feuxP2    : out    std_logic_vector(1 downto 0);
  feuxS     : out    std_logic_vector(1 downto 0);
  ebl_1Hz   : in     std_logic);
end component FSM_Moore;

component Counter8
port (
  clk       : in     std_logic;
  reset_n   : in     std_logic;
  Cnt_value : out    std_logic_vector(7 downto 0);
  cnt_ebl   : in     std_logic;
  ebl_1Hz   : in     std_logic);
end component Counter8;

component Divisor
port (
  clk     : in     std_logic;
  reset_n : in     std_logic;
  ebl_1Hz : out    std_logic;
  test    : in     std_logic);
end component Divisor;

--Signaux locaux pour instanciation composant UUT
--Inputs
SIGNAL BCD : std_logic_vector(3 downto 0);
--Outputs
SIGNAL aff_enable : std_logic;
SIGNAL aff : std_logic_vector(6 downto 0);

--signaux propres au testbench
SIGNAL sim_end      : BOOLEAN   := FALSE;
SIGNAL mark_error   : std_logic := '0';
SIGNAL error_number : INTEGER   := 0;
SIGNAL clk_gen      : std_logic := '0';

BEGIN

--Intanciation du composant UUT
uut: bcd7seg 
		PORT MAP(
				BCD => BCD, 
				aff_enable => aff_enable,
				aff => aff
				);

--********** PROCESS "clk_gengen" **********
clk_gengen: PROCESS
  BEGIN
  IF sim_end = FALSE THEN
    clk_gen <= '1', '0' AFTER 1 ns;
    --clk     <= '1', '0' AFTER 5 ns, '1' AFTER 17 ns; --commenter si  on teste une fonction combinatoire (pas de clock)
    wait for 25 ns;
  ELSE
    wait;
  END IF;
END PROCESS;

--********** PROCESS "run" **********
run: PROCESS

  PROCEDURE sim_cycle(num : IN integer) IS
  BEGIN
    FOR index IN 1 TO num LOOP
      wait until clk_gen'EVENT AND clk_gen = '1';
    END LOOP;
  END sim_cycle;

  --********** PROCEDURE "init" **********
  --fixer toutes les entrees du module à tester (DUT) sauf clk
  PROCEDURE init IS
  BEGIN
  				
  END init;

  --********** PROCEDURE "test_signal" **********
  PROCEDURE test_signal(signal_test, value: IN std_logic; erreur : IN integer) IS 
	BEGIN
	   IF signal_test/= value THEN
         	mark_error <= '1', '0' AFTER 1 ns;
         	error_number <= erreur;
         	ASSERT FALSE REPORT "Etat du signal non correct" SEVERITY WARNING;
	   END IF;
  END test_signal;

 --********** PROCEDURE "test_vecteur" **********
  PROCEDURE test_vecteur(signal_test, value: IN std_logic_vector(7 DOWNTO 0); erreur : IN integer) IS 
	BEGIN
	   IF signal_test/= value THEN
         	mark_error <= '1', '0' AFTER 1 ns;
         	error_number <= erreur;
         	ASSERT FALSE REPORT "Etat du signal non correct" SEVERITY WARNING;
	   END IF;
  END test_vecteur;


BEGIN --debut de la simulation temps t=0ns

	init;  --appel procdure init
	ASSERT FALSE REPORT "la simulation est en cours" SEVERITY NOTE;
	--debut des tests
    		
	sim_end <= TRUE;
	wait;

END PROCESS;

END;