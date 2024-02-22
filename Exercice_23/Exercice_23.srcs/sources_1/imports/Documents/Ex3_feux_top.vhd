library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Ex3_feux_top is
  port (
    capteur : in     std_logic;
    feuxP1  : out    std_logic_vector(1 downto 0);
    feuxP2  : out    std_logic_vector(1 downto 0);
    feuxS   : out    std_logic_vector(1 downto 0);
    test    : in     std_logic;
    clk     : in     std_logic;
    reset_n : in     std_logic);
end entity Ex3_feux_top;

--------------------------------------------------------------------------------
-- Object        : Architecture design.Ex3_feux_top.structure
-- Last modified : Wed Dec  6 11:02:44 2023
--------------------------------------------------------------------------------

architecture structure of Ex3_feux_top is

  signal Cnt_value : std_logic_vector(7 downto 0);
  signal cnt_ebl   : std_logic;
  signal ebl_1Hz   : std_logic;

  component FSM_Moore
    port (
      clk       : in     std_logic;
      reset_n   : in     std_logic;
      cnt_ebl   : out    std_logic;
      Cnt_value : in     std_logic_vector(7 downto 0);
      capteur   : in     std_logic;
      feuxP1    : out    std_logic_vector(1 downto 0);
      feuxP2    : out    std_logic_vector(1 downto 0);
      feuxS     : out    std_logic_vector(1 downto 0);
      ebl_1Hz   : in     std_logic);
  end component FSM_Moore;

  component Counter8
    port (
      clk       : in     std_logic;
      reset_n   : in     std_logic;
      Cnt_value : out    std_logic_vector(7 downto 0);
      cnt_ebl   : in     std_logic;
      ebl_1Hz   : in     std_logic);
  end component Counter8;

  component Divisor
    port (
      clk     : in     std_logic;
      reset_n : in     std_logic;
      ebl_1Hz : out    std_logic;
      test    : in     std_logic);
  end component Divisor;

begin

  u0: FSM_Moore
    port map(
      clk       => clk,
      reset_n   => reset_n,
      cnt_ebl   => cnt_ebl,
      Cnt_value => Cnt_value,
      capteur   => capteur,
      feuxP1    => feuxP1,
      feuxP2    => feuxP2,
      feuxS     => feuxS,
      ebl_1Hz   => ebl_1Hz);

  u1: Counter8
    port map(
      clk       => clk,
      reset_n   => reset_n,
      Cnt_value => Cnt_value,
      cnt_ebl   => cnt_ebl,
      ebl_1Hz   => ebl_1Hz);

  u2: Divisor
    port map(
      clk     => clk,
      reset_n => reset_n,
      ebl_1Hz => ebl_1Hz,
      test    => test);

end architecture structure ; -- of Ex3_feux_top

