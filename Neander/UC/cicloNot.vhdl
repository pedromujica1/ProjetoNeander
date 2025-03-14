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
    s(10) <=  '1'; --barrINc fica o mesmo
    s(9) <= '1' --barrPc fica o mesmo
    s(8 downto 6) <= "100"; --ULA_OP altera pra 100
    s(5) <= not(counter(1)) and not(counter(2)) and c(0); --Pc_NRW fica o mesmo do nop
    s(4) <= counter(1) and counter(0) and counter(2); --Ac_NRW fica com '1'
    s(3) <= '0'; --MEM_NRW fica nulo
    s(2) <= not(counter(1)) and not(counter(2)) and not(counter(0)) --rem_nrw fica igual o nop
    s(1) <= not(counter(1)) and not(c(2)) and c(0);  --RDM_NRW igual o nop
    s(0) <= not(counter(2)) and not(counter(0)) and counter(1); --RI_NRW igual o nop 

end arch;