library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
    port (
        --Canais de 8 MUX 2x1 
        canal0: in std_logic;
        seletor: in std_logic;
        canal1: in std_logic;
        Zc : out std_logic
    ); 
end entity mux2x1;

architecture comutacao of mux2x1 is
    begin
        --Comportamento do Multiplexado
        Zc <= canal0 when seletor = '0' else canal1;
end architecture;