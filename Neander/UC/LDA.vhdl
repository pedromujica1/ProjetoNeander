library ieee;
use ieee.std_logic_1164.all;

entity LDA is
    port(
        counter : in std_logic_vector(2 downto 0);
        s : out std_logic_vector(7 downto 0);
        );
end entity LDA;

architecture arch of LDA is

    s(0) <=  '1'; --barrINC
    s(1) <= not c(2) or c(2) or not c(9); --barrPC
    s(4 downto 2) <= "000"; --ULA_OP
    s(5) <= not (c(1))  and (c(2) xor c(0)); --PC_NRW
    s(6) <= c(2) or c(1) or c(0); --AC_NRW
    s(7) <= '0'; --MEM_NRW
    s(8) <= (not c(1) and (c(2) xnor c(0))) or (not(c(2) and c(1) and c(0))) --rem_nrw
    s(9) <= (c(2) and not (c(0)) or (not(c(2)) and not(c(1)) and c(0)))
    s(10) <= not c(2) and c(1) and not c(0);



    signal 

begin

end arch ; -- arch