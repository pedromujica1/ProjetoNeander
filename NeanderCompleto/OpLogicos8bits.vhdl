library ieee;
use ieee.std_logic_1164.all;

entity OpLogicos8bits is
    port(
        x : in std_logic_vector(7 downto 0);
        y : in std_logic_vector(7 downto 0);
        saida_and : out std_logic_vector(7 downto 0);
        saida_or : out std_logic_vector(7 downto 0);
        saida_not : out std_logic_vector(7 downto 0)
    );
end entity OpLogicos8bits; 

architecture comportamento of OpLogicos8bits is
    begin
        saida_and <= x and y;
        saida_or <= x or y;
        saida_not <= not(x);
end architecture comportamento;