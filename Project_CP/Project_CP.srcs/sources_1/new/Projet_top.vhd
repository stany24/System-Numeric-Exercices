-- Engineer: Gouvernon Stan

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Projet_top is
    Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
           B : in STD_LOGIC_VECTOR (1 downto 0);
           C : in STD_LOGIC_VECTOR (1 downto 0);
           sel : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (2 downto 0));
end Projet_top;

architecture STRUCTURAL of Projet_top is
    SIGNAL Z_to_In1 : STD_LOGIC_VECTOR (2 downto 0);
    SIGNAL Z_to_In2 : STD_LOGIC_VECTOR (2 downto 0);

    COMPONENT mux
    PORT (
       In1 : in STD_LOGIC_VECTOR (2 downto 0);
       In2 : in STD_LOGIC_VECTOR (2 downto 0);
       Mux : out STD_LOGIC_VECTOR (2 downto 0);
       sel : in STD_LOGIC);
    END COMPONENT;
    
    COMPONENT comp
    PORT (
       A : in STD_LOGIC_VECTOR (1 downto 0);
       B : in STD_LOGIC_VECTOR (1 downto 0);
       Z : out STD_LOGIC_VECTOR (2 downto 0));
    END COMPONENT;

begin
    comp1: comp
    port map(
        A => A,
        B => B,
        Z => Z_to_In1
        );
    comp2: comp
    port map(
        A => A,
        B => B,
        Z => Z_to_In2);
    mux2:mux
    port map(
        In1 =>Z_to_In1,
        In2 =>Z_to_In2,
        sel =>sel,
        mux =>S
    );
end STRUCTURAL;
