LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE structure OF testbench IS

--Declaration du composant UUT (Unit Under Test)
COMPONENT Exercice3 
		PORT(
			BCD : IN std_logic_vector(3 downto 0);
			Aff_enable : OUT std_logic;
			Aff : OUT std_logic_vector(6 downto 0)
			);
END COMPONENT;

--Signaux locaux pour instanciation composant UUT
--Inputs
SIGNAL BCD : std_logic_vector(3 downto 0);
--Outputs
SIGNAL Aff_enable : std_logic;
SIGNAL Aff : std_logic_vector(6 downto 0);

--signaux propres au testbench
SIGNAL sim_end      : BOOLEAN   := FALSE;
SIGNAL mark_error   : std_logic := '0';
SIGNAL error_number : INTEGER   := 0;
SIGNAL clk_gen      : std_logic := '0';

BEGIN

--Intanciation du composant UUT
uut: Exercice3 
		PORT MAP(
				BCD => BCD, 
				Aff_enable => aff_enable,
				Aff => aff
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
    BCD <= "0000";
  				
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
  PROCEDURE test_vecteur(signal_test, value: IN std_logic_vector(6 DOWNTO 0); erreur : IN integer) IS 
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
    test_signal(Aff_Enable,'1',1);
    test_vecteur(Aff,"0111111",2);
    sim_cycle(1);
    
    BCD <= "0001";
    sim_cycle(1);
    test_signal(Aff_Enable,'1',3);
    test_vecteur(Aff,"0000110",4);
    sim_cycle(1);
    
    BCD <= "0010";
    sim_cycle(1);
    test_signal(Aff_Enable,'1',5);
    test_vecteur(Aff,"1011011",6);
    sim_cycle(1);
    
    BCD <= "0011";
    sim_cycle(1);
    test_signal(Aff_Enable,'1',7);
    test_vecteur(Aff,"1001111",8);
    sim_cycle(1);
    
    BCD <= "0100";
    sim_cycle(1);
    test_signal(Aff_Enable,'1',9);
    test_vecteur(Aff,"1100110",10);
    sim_cycle(1);
    
    BCD <= "0101";
    sim_cycle(1);
    test_signal(Aff_Enable,'1',11);
    test_vecteur(Aff,"1101101",12);
    sim_cycle(1);
    
    BCD <= "0110";
    sim_cycle(1);
    test_signal(Aff_Enable,'1',13);
    test_vecteur(Aff,"1111101",14);
    sim_cycle(1);
    
    BCD <= "0111";
    sim_cycle(1);
    test_signal(Aff_Enable,'1',15);
    test_vecteur(Aff,"0000111",16);
    sim_cycle(1);
    
    BCD <= "1000";
    sim_cycle(1);
    test_signal(Aff_Enable,'1',17);
    test_vecteur(Aff,"1111111",18);
    sim_cycle(1);
    
    BCD <= "1001";
    sim_cycle(1);
    test_signal(Aff_Enable,'1',19);
    test_vecteur(Aff,"1101111",20);
    sim_cycle(1);
    
	sim_end <= TRUE;
	wait;

END PROCESS;

END;

