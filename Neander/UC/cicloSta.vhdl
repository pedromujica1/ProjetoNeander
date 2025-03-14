library ieee;
use ieee.std_logic_1164.all;

entity cicloSta is
    port(
        counter : in std_logic_vector(2 downto 0);
        s : out std_logic_vector(10 downto 0);
        );
end entity cicloSta;

architecture arch of cicloSta is

begin
    s(10) <=  '1'; --barrINC mantem em 1
    s(9) <= not(counter(2)) or counter(1) or not(counter(0))  --barrPC

    s(8 downto 6) <= "000"; --ULA_OP mantem 000
    s(5) <= not(counter(1))  and (counter(2) xor counter(0));--PC_NRW mesmo que LDA
    s(4) <= '0';--AC_NRW mantem em 0
    -- 
    s(3)<=  counter(1) and not(counter(0)) and counter(2);--MEM_NRW
    s(2)<= (not(counter(1)) and (not(counter(2)) xnor not(counter(1)))) or (counter(0) and counter(1) and not counter(2))--rem_nrw
    s(1)<= not(counter(1)) and (counter(2) xor counter(2))--RDM_NRW --n
    --aaaa 
    s(0) <= not counter(0) and counter(1) and not counter(2); --RI_NRW mantem igual
end arch;