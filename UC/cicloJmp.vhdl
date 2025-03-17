library ieee;
use ieee.std_logic_1164.all;

entity cicloJmp is
    port(
        counter : in std_logic_vector(2 downto 0);
        s : out std_logic_vector(10 downto 0)
        );
end entity cicloJmp;

architecture arch of cicloJmp is

begin

    s(10) <=  not(counter(2)) or counter(1) or not(counter(0)); --barrINC
    s(9) <= '1'; --barrPC
    s(8 downto 6) <= "000"; --ULA_OP altera pra 
    s(5) <= not(counter(1)) and counter(0); --PC_NRW

    ---verificar
    s(4) <= '0'; --AC_NRW fica negado
    s(3) <= '0'; --MEM_NRW fica negado

    s(2) <= (not counter(0) and not counter(2) and not counter(1)) or (not counter(2) and counter(1) and counter(0));--rem_nrw

    s(1) <= not(counter(1)) and (counter(2) xor counter(2));  --RDM_NRW
    s(0) <= counter(1) and not(counter(2)) and not(counter(0)); --RI_NRW com 1

end arch;