library ieee;
use ieee.std_logic_1164.all;

entity cicloLda is
    port(
        counter : in std_logic_vector(2 downto 0);
        s : out std_logic_vector(10 downto 0);
        );
end entity cicloLda;

architecture arch of cicloLda is

begin
    s(10) <=  '1'; --barrINC
    s(9) <= not(counter(2)) or counter(1) or not(counter(0)); --barrPC
    s(8 downto 6) <= "000"; --ULA_OP
    s(5) <= not (counter(1))  and (counter(2) xor counter(0)); --PC_NRW
    s(4) <= counter(2) and counter(1) and counter(0); --AC_NRW
    s(3) <= '0'; --MEM_NRW
    s(2) <= ( not(counter(1)) and (counter(2) xnor counter(0)) ) or (not(c(2) and c(1) and c(0))) --rem_nrw
    s(1) <= ( counter(2) and not(counter(0)) ) or ( not(counter(2)) and not(counter(1)) and counter(0) )  --RDM_NRW
    s(0) <= not(counter(2)) and counter(1) and not(counter(0)); --RI_NRW

end arch ;