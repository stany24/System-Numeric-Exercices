LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE structure OF testbench IS

--Declaration du composant UUT (Unit Under Test)
COMPONENT Arch 
		PORT(
			clk : in STD_LOGIC;
           reset_n : in STD_LOGIC;
           d : in STD_LOGIC;
           q : out STD_LOGIC;
           enable : in STD_LOGIC
			);
END COMPONENT;

--Signaux locaux pour instanciation composant UUT
--Inputs
SIGNAL clk : std_logic;
SIGNAL reset_n : std_logic;
SIGNAL d : std_logic;
--Outputs
SIGNAL enable : std_logic;
SIGNAL q : std_logic;

--signaux propres au testbench
SIGNAL sim_end      : BOOLEAN   := FALSE;
SIGNAL mark_error   : std_logic := '0';
SIGNAL error_number : INTEGER   := 0;
SIGNAL clk_gen      : std_logic := '0';

BEGIN

--Intanciation du composant UUT
uut: Arch 
		PORT MAP(
		        clk => clk,
		        reset_n =>reset_n,
				d => d, 
				enable => enable,
				q => q
				);

--********** PROCESS "clk_gengen" **********
clk_gengen: PROCESS
  BEGIN
  IF sim_end = FALSE THEN
    clk_gen <= '1', '0' AFTER 1 ns;
    clk     <= '1', '0' AFTER 5 ns, '1' AFTER 17 ns; --commenter si  on teste une fonction combinatoire (pas de clock)
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
    reset_n <= '0';
    enable <= '1';
    d <= '1';
  				
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

BEGIN --debut de la simulation temps t=0ns

	init;  --appel procdure init
	ASSERT FALSE REPORT "la simulation est en cours" SEVERITY NOTE;
	--debut des tests
    sim_cycle(2);
    test_signal(q,'0',1);
    sim_cycle(1);
    
    reset_n <= '1';
    sim_cycle(1);
    test_signal(q,'1',2);
    sim_cycle(1);
    test_signal(q,'0',2);
    enable <= '0';
    sim_cycle(1);
    test_signal(q,'0',2);
	sim_end <= TRUE;
	wait;

END PROCESS;

END;

