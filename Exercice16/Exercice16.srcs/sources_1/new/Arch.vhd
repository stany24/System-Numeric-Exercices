library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Arch is
    Port ( clk : in std_logic;
        reset_n : in std_logic;
        serin : in std_logic;
        enable: in std_logic;
        dout : out std_logic_vector(15 downto 0));
end Arch;

architecture Behavioral of Arch is

signal reg: std_logic_vector(15 downto 0);

begin

process(clk, reset_n)
begin
    if reset_n = '0' then
        reg <= (OTHERS => '0');
    elsif clk'EVENT and clk ='1' then
        if enable ='1' then
            reg <= serin & reg(15 downto 1);
        end if;
    end if;
end process;
dout <= reg;
end Behavioral;
