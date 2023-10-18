library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.bcd7seg.all;

entity Exercice3 is
Port ( BCD : in std_logic_vector(3 downto 0);
       Aff : out std_logic_vector(6 downto 0);
       Aff_enable : out STD_LOGIC);
end Exercice3;

architecture Behavioral of Exercice3 is

begin
    Aff_enable <= '1';
    
    proc:
    PROCESS(BCD)
    BEGIN
        --CASE BCD IS
        --    WHEN "0000" => Aff <= "0111111";
        --    WHEN "0001" => Aff <= "0000110";
        --    WHEN "0010" => Aff <= "1011011";
        --    WHEN "0011" => Aff <= "1001111";
        --    WHEN "0100" => Aff <= "1100110";
        --    WHEN "0101" => Aff <= "1101101";
        --    WHEN "0110" => Aff <= "1111101";
        --    WHEN "0111" => Aff <= "0000111";
        --    WHEN "1000" => Aff <= "1111111";
        --    WHEN "1001" => Aff <= "1101111";
        --    WHEN OTHERS => Aff <= "0000000";
        --END CASE;
        
        IF BCD = "0000" THEN Aff <="0111111";
        ELSIF BCD = "0001" THEN Aff <="0000110";
        ELSIF BCD = "0010" THEN Aff <="1011011";
        ELSIF BCD = "0011" THEN Aff <="1001111";
        ELSIF BCD = "0100" THEN Aff <="1100110";
        ELSIF BCD = "0101" THEN Aff <="1101101";
        ELSIF BCD = "0110" THEN Aff <="1111101";
        ELSIF BCD = "0111" THEN Aff <="0000111";
        ELSIF BCD = "1000" THEN Aff <="1111111";
        ELSIF BCD = "1001" THEN Aff <="1101111";
        END IF;
    END PROCESS;

end Behavioral;
