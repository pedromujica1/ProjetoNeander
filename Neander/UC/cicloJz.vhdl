library ieee;
use ieee.std_logic_1164.all;

entity cicloJz is
    port(
        counter : in std_logic_vector(2 downto 0);
        s : out std_logic_vector(10 downto 0);
        );
end entity cicloJz;

architecture arch of cicloJz is

begin

    s(10) <=  '0'; --barrINC
    s(9) <= '0' --barrPC
    s(8 downto 6) <= "000"; --ULA_OP altera pra 
    s(5) <= '0'; --PC_NRW
    s(4) <= '0'; --AC_NRW
    s(3) <= '0'; --MEM_NRW
    s(2) <= '0' --rem_nrw
    s(1) <= '0'  --RDM_NRW
    s(0) <= '0'; --RI_NRW
    

end arch;