LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE structure OF testbench IS

--Declaration du composant UUT (Unit Under Test)
COMPONENT Arch 
		PORT(
            ina : in STD_LOGIC_VECTOR (3 downto 0);
            inb : in STD_LOGIC_VECTOR (3 downto 0);
            inc : in STD_LOGIC_VECTOR (3 downto 0);
            ind : in STD_LOGIC_VECTOR (3 downto 0);
            sel : in std_logic_VECTOR (1 downto 0);
            mux : out STD_LOGIC_VECTOR (3 downto 0)
			);
END COMPONENT;

--Signaux locaux pour instanciation composant UUT
--Inputs
SIGNAL ina : std_logic_vector(3 downto 0);
SIGNAL inb : std_logic_vector(3 downto 0);
SIGNAL inc : std_logic_vector(3 downto 0);
SIGNAL ind : std_logic_vector(3 downto 0);
SIGNAL sel : std_logic_vector(1 downto 0);
--Outputs
SIGNAL mux : std_logic_vector(3 downto 0);

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
				inc => inc, 
				ind => ind,
				sel => sel,
				mux => mux
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
    ina <= "1111";
    inb <= "0011";
    inc <= "1100";
    ind <= "0000";
    sel <= "00";
  				
  END init;

 --********** PROCEDURE "test_vecteur" **********
  PROCEDURE test_vecteur3(signal_test, value: IN std_logic_vector(3 DOWNTO 0); erreur : IN integer) IS 
	BEGIN
	   IF signal_test/= value THEN
         	mark_error <= '1', '0' AFTER 1 ns;
         	error_number <= erreur;
         	ASSERT FALSE REPORT "Etat du signal non correct" SEVERITY WARNING;
	   END IF;
  END test_vecteur3;


BEGIN --debut de la simulation temps t=0ns

	init;  --appel procdure init
	ASSERT FALSE REPORT "la simulation est en cours" SEVERITY NOTE;
	--debut des tests
	sim_cycle(2);
	test_vecteur3(mux,"1111",1);
	sim_cycle(1);
	
	sel <= "01";
	sim_cycle(1);
	test_vecteur3(mux,"0011",2);
	sim_cycle(1);
	
	sel <= "10";
	sim_cycle(1);
	test_vecteur3(mux,"1100",3);
	sim_cycle(1);
	
	sel <= "11";
    sim_cycle(1);
	test_vecteur3(mux,"0000",4);
    		
	sim_end <= TRUE;
	wait;

END PROCESS;

END;

