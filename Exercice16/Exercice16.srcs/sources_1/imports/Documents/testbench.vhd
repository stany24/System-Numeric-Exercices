LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE structure OF testbench IS

--Declaration du composant UUT (Unit Under Test)
COMPONENT Arch 
		Port ( clk : in std_logic;
            reset_n : in std_logic;
            serin : in std_logic;
            enable: in std_logic;
            dout : out std_logic_vector(15 downto 0));
END COMPONENT;

--Signaux locaux pour instanciation composant UUT
--Inputs
SIGNAL reset_n : std_logic;
SIGNAL enable : std_logic;
SIGNAL serin : std_logic;
SIGNAL clk : std_logic;
--Outputs
SIGNAL dout : std_logic_vector(15 downto 0);

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
				enable => enable,
				reset_n => reset_n,
				serin => serin,
				dout => dout
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
  	enable <= '1';
  	reset_n <= '0';
  	serin <= '1';
  END init;

 --********** PROCEDURE "test_vecteur" **********
  PROCEDURE test_vecteur(signal_test, value: IN std_logic_vector(15 DOWNTO 0); erreur : IN integer) IS 
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
	sim_cycle(2);
	test_vecteur(dout,"0000000000000000",1);
	sim_cycle(1);
	reset_n <= '1';
	sim_cycle(1);
	test_vecteur(dout,"1000000000000000",2);
	sim_cycle(1);
	test_vecteur(dout,"1100000000000000",3);
	sim_cycle(1);
	test_vecteur(dout,"1110000000000000",4);
	sim_cycle(1);
	serin <= '0';
	sim_cycle(1);
	test_vecteur(dout,"0111100000000000",5);
	sim_cycle(1);
	test_vecteur(dout,"0011110000000000",6);
	sim_cycle(1);
	enable <= '0';
	sim_cycle(1);
	test_vecteur(dout,"0011110000000000",7);
	sim_cycle(1);
	test_vecteur(dout,"0011110000000000",8);
    sim_cycle(1);
    reset_n <= '0';
    test_vecteur(dout,"0000000000000000",9);
    		
	sim_end <= TRUE;
	wait;

END PROCESS;

END;

