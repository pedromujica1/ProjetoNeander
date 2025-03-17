library ieee;
use ieee.std_logic_1164.all;

entity mux5x8 is
    port (
        --Canais de 8 MUX 2x1 
        canal0: in std_logic_vector(7 downto 0); 
        canal1: in std_logic_vector(7 downto 0); 
        canal2: in std_logic_vector(7 downto 0); 
        canal3: in std_logic_vector(7 downto 0);
        canal4: in std_logic_vector(7 downto 0); 
        seletor: in std_logic_vector(2 downto 0); 
        --1 saída Z para 8 MUX2x1
        Zc : out std_logic_vector(7 downto 0)
    ); 
end entity mux5x8;

architecture comutacao of mux5x8 is

    begin
        
        Zc <= canal0 when seletor = "000" 
        else canal1 when seletor = "001" 
        else canal2 when seletor = "010" 
        else canal3 when seletor = "011" 
        else canal4 when seletor = "100"
        else (others =>'Z');
end architecture;