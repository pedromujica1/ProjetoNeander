library ieee;
use ieee.std_logic_1164.all;

entity cicloNot is
    port(
        counter : in std_logic_vector(2 downto 0);
        s : out std_logic_vector(10 downto 0);
        );
end entity cicloNot;

architecture arch of cicloNot is

begin
    --parecido com o nop
    s(10) <=  '1'; --barrINC fica o mesmo
    s(9) <= '1' --barrPC fica o mesmo
    s(8 downto 6) <= "100"; --ULA_OP altera pra 100
    s(5) <= not(c(1)) and not(c(2)) and c(0); --PC_NRW fica o mesmo do nop
    s(4) <= c(1) and c(0) and c(2); --AC_NRW fica com '1'
    s(3) <= '0'; --MEM_NRW fica nulo
    s(2) <= not(c(1)) and not(c(2)) and not(c(0)) --rem_nrw fica igual o nop
    s(1) <= not(c(1)) and not(c(2)) and c(0);  --RDM_NRW igual o nop
    s(0) <= not(c(2)) and not(c(0)) and c(1); --RI_NRW igual o nop 

end arch;