library ieee;
use ieee.std_logic_1164.all;

entity controler is
    port(
        q : in std_logic_vector (2 downto 0);
        j,k : out std_logic_vector (2 downto 0)
        
    );
end entity;

architecture controlar of controler is
    begin
        
        j(0) <= '1';
        k(0) <= '1';

        j(1) <= q(0);
        k(1) <= q(0);

        j(2) <= q(1) and q(0);
        k(2) <= q(1) and q(0);
end architecture;
    
