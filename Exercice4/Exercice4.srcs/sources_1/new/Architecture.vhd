library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Arch is
    Port ( sel : in STD_LOGIC;
           input1 : in STD_LOGIC;
           input2 : in STD_LOGIC;
           input3 : in STD_LOGIC;
           sel_out : out STD_LOGIC;
           out1 : out STD_LOGIC);
end Arch;

architecture Behavioral of Arch is
SIGNAL and_3_reporte : std_logic;
SIGNAL or_3_reporte : std_logic;

component HIERACHIE_1
    port (
        input1 : in std_logic;
        input2 : in std_logic;
        input3 : in std_logic;
        and_3 : out std_logic;
        or_3 : out std_logic );
end component;

component HIERACHIE_2
    port (
        sel : in std_logic;
        and_3 : in std_logic;
        or_3 : in std_logic;
        sel_out : out std_logic;
        out1 : out std_logic );
end component;

begin
    part1: HIERACHIE_1
        port map(
            input1 => input1,
            input2 => input2,
            input3 => input3,
            and_3 => and_3_reporte,
            or_3 => or_3_reporte);
    part2: HIERACHIE_2
        port map(
            sel => sel,
            and_3 => and_3_reporte,
            or_3 => or_3_reporte,
            sel_out => sel_out,
            out1 => out1);

end Behavioral;
