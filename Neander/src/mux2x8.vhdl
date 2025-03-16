library ieee;
use ieee.std_logic_1164.all;

entity mux2x8 is
    port (
        --Canais de 8 MUX 2x1 
        canal0: in std_logic_vector (7 downto 0);
        canal1 : in std_logic_vector (7 downto 0);
        seletor: in std_logic;
        Zc : out std_logic_vector (7 downto 0)
    ); 
end entity mux2x8;

architecture comutacao of mux2x8 is
    begin
        --Comportamento do Multiplexado
        Zc <= canal0 when seletor = '0' else canal1;
end architecture;