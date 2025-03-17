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
        
    --jj(0) <= '1';
    --	kk(0) <= '1';
	--
	--jj(1) <= qq(0);
	--kk(1) <= qq(0);
	
	--jj(2) <= qq(1) and qq(0);
	--kk(2) <= qq(1) and qq(0);  
        j(0) <= '1';
        k(0) <= '1';

        j(1) <= q(0);
        k(1) <= q(0);

        j(2) <= q(1) and q(0);
        k(2) <= q(1) and q(0);
end architecture;
    
