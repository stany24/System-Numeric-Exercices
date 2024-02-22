library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Mealy_Sync_SM is
Port ( clk : in STD_LOGIC;
    reset_n : in STD_LOGIC;
    LEFT : in STD_LOGIC;
    RIGHT : in STD_LOGIC;
    HAZ : in STD_LOGIC;
    l : out STD_LOGIC_VECTOR (3 DOWNTO 0);
    r : out STD_LOGIC_VECTOR (3 DOWNTO 0));
end Mealy_Sync_SM;
architecture Behavioral of Mealy_Sync_SM is
--Declare type, subtype
subtype t_state is std_logic_vector(2 DOWNTO 0);
--Declare constantes
constant c_L1 : t_state := "000";
constant c_L2 : t_state := "001";
constant c_L3 : t_state := "010";
constant c_R1 : t_state := "011";
constant c_R2 : t_state := "100";
constant c_R3 : t_state := "101";
constant c_IDLE : t_state := "110";
constant c_LR3 : t_state := "111";
--Declare signaux
SIGNAL state : t_state;
BEGIN
    P1:PROCESS(clk, reset_n) BEGIN
        IF reset_n = '0' THEN
            state <= c_IDLE;
            sortie <= "0111111";
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE state IS
                WHEN c_ZERO =>
                    IF entree = '1' THEN
                        state <= c_UN_UN;
                        sortie <= "0000110";
                    ELSE
                        state <= c_ZERO;
                    END IF;
                WHEN c_UN_UN =>
                    IF entree = '1' THEN
                        state <= c_DEUX_UN;
                        sortie <= "1011011";
                    ELSE
                        state <= c_ZERO;
                        sortie <= "0111111";
                    END IF;
                WHEN c_TROIS_UN =>
                    IF entree = '1' THEN
                        state <= c_MAX_UN;
                        sortie <= "1010100";
                    ELSE
                        state <= c_ZERO;
                        sortie <= "0111111";
                    END IF;
                WHEN c_MAX_UN =>
                    IF restart = '1' THEN
                        state <= c_ZERO;
                        sortie <= "0111111";
                    ELSE
                        state <= c_MAX_UN;
                    END IF;
                WHEN OTHERS =>
                    state <= c_ZERO;
                    sortie <= "0111111";
            END CASE;
        END IF;
    END PROCESS;
end Behavioral;