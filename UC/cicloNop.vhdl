library ieee;
use ieee.std_logic_1164.all;

entity cicloNop is
    port(
        counter : in std_logic_vector(2 downto 0);
        s : out std_logic_vector(10 downto 0)
        );
end entity cicloNop;

architecture arch of cicloNop is

begin

    s(10) <=  '1'; --barrINC
    s(9) <= '1'; --barrPC
    s(8 downto 6) <= "000";
    s(5) <= not(counter(1)) and not(counter(2)) and counter(0); --PC_NRW
    s(4) <= '0'; --AC_NRW é nula
    s(3) <= '0'; --MEM_NRW é nula
    s(2) <= not(counter(1)) and not(counter(2)) and not(counter(0)); --rem_nrw tem um valor 1 
    s(1) <= not(counter(1)) and not(counter(2)) and counter(0);  --RDM_NRW mesma tabela que PC
    s(0) <= not(counter(2)) and not(counter(0)) and counter(1); --RI_NRW tem 1
end arch;