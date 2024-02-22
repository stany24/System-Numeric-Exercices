LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM_Moore is
    Port (	
		clk       : in     std_logic;
        reset_n   : in     std_logic;
        cnt_ebl   : out    std_logic;
        Cnt_value : in     std_logic_vector(7 downto 0);
        capteur   : in     std_logic;
        feuxP1    : out    std_logic_vector(1 downto 0);
        feuxP2    : out    std_logic_vector(1 downto 0);
        feuxS     : out    std_logic_vector(1 downto 0);
        ebl_1Hz   : in     std_logic);
end FSM_Moore;

architecture Behavioral of FSM_Moore is

-- Declare type, subtype

  subtype t_feux_state is	std_logic_vector(2 DOWNTO 0);

-- Declare constants

  constant c_PRVSECR	: t_feux_state	:= "000";
  constant c_PROSECR	: t_feux_state	:= "001";
  constant c_PRRSECR	: t_feux_state	:= "010";
  constant c_PRRSECV	: t_feux_state	:= "011";
  constant c_PRRSECO	: t_feux_state	:= "100";
  constant c_PRRSECR2	: t_feux_state	:= "101";
 
SIGNAL state :	t_feux_state;

BEGIN

P1:PROCESS(clk, reset_n) BEGIN
	IF reset_n = '0' THEN
		state 	<= c_PRVSECR;
	ELSIF (clk'EVENT AND clk = '1') THEN
	    if ebl_1Hz = '1' then
	       CASE state IS
                WHEN c_PRVSECR =>
                    IF capteur = '1' THEN 
                        state <= c_PROSECR;
                    ELSE
                        state <= c_PRVSECR;
                    END IF;
    
                WHEN c_PROSECR =>
                    state <= c_PRRSECR;
                    
                WHEN c_PRRSECR =>
                    cnt_ebl <= '1';
                    state <= c_PRRSECV;
                    
                WHEN c_PRRSECV =>
                    IF Cnt_value = "00001111" THEN 
                        cnt_ebl <= '0';
                        state <= c_PRRSECO;
                    ELSE
                        state <= c_PRRSECV;
                    END IF;
                    
                WHEN c_PRRSECO =>
                    state <= c_PRRSECR2;
                    
                WHEN c_PRRSECR2 =>
                    state <= c_PRVSECR;
            
                WHEN OTHERS =>
                    state <= c_PRVSECR;
            END CASE;
	    end if;
	END IF;
END PROCESS;

--assignation combinatoire des sorties en fonction de l'état courant
--Leds bicolores du kit Xilinx, bit(1) = rouge, bit(0) = vert
feuxP1 <= 	"01" WHEN state = c_PRVSECR ELSE 
			"11" WHEN state = c_PROSECR ELSE 
			"10";
feuxP2 <= 	"01" WHEN state = c_PRVSECR ELSE 
			"11" WHEN state = c_PROSECR ELSE 
			"10";  
feuxS <= 	"01" WHEN state = c_PRRSECV ELSE 
			"11" WHEN state = c_PRRSECO ELSE 
			"10";
	   
end Behavioral;
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   

