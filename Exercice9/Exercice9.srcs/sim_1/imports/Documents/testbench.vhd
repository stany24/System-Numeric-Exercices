LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE structure OF testbench IS

--Declaration du composant UUT (Unit Under Test)
COMPONENT Arch 
		PORT(
			ina : in STD_LOGIC_VECTOR (7 downto 0);
            inb : in STD_LOGIC_VECTOR (7 downto 0);
            ebl : in STD_LOGIC;
            PP : out STD_LOGIC;
            EG : out STD_LOGIC;
            PG : out STD_LOGIC
			);
END COMPONENT;

--Signaux locaux pour instanciation composant UUT
--Inputs
SIGNAL ina : std_logic_vector(7 downto 0);
SIGNAL inb : std_logic_vector(7 downto 0);
SIGNAL ebl : std_logic;
--Outputs
SIGNAL PP : std_logic;
SIGNAL EG : std_logic;
SIGNAL PG : std_logic;

--signaux propres au testbench
SIGNAL sim_end      : BOOLEAN   := FALSE;
SIGNAL mark_error   : std_logic := '0';
SIGNAL error_number : INTEGER   := 0;
SIGNAL clk_gen      : std_logic := '0';

BEGIN

--Intanciation du composant UUT
uut: Arch 
		PORT MAP(
				ina => ina,
				inb => inb,
				ebl => ebl,
				PP => PP,
				EG => EG,
				PG => PG
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
  	 ina <= "00000000";
  	 inb <= "00000000";
  	 ebl <= '0';
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
	test_signal(PP,'Z',1);
	test_signal(PG,'Z',2);
	test_signal(EG,'Z',3);
	sim_cycle(1);
	
	ebl <= '1';
	sim_cycle(1);
	test_signal(PP,'Z',4);
	test_signal(PG,'Z',5);
	test_signal(EG,'1',6);
	sim_cycle(1);
	
	ina <= "00001111";
	sim_cycle(1);
	test_signal(PP,'Z',7);
	test_signal(PG,'1',8);
	test_signal(EG,'Z',9);
	sim_cycle(1);
	
	inb <= "11110000";
	sim_cycle(1);
	test_signal(PP,'1',10);
	test_signal(PG,'Z',11);
	test_signal(EG,'Z',12);
	sim_cycle(1);
    		
	sim_end <= TRUE;
	wait;

END PROCESS;

END;

