library ieee;
use ieee.std_logic_1164.all;

entity cicloJz is
    port(
        counter : in std_logic_vector(2 downto 0);
        nz      : in std_logic_vector(1 downto 0);
        s : out std_logic_vector(10 downto 0)
        );
end entity cicloJz;

architecture arch of cicloJz is
    component cicloJmp is
        port(
            counter : in std_logic_vector(2 downto 0);
            s : out std_logic_vector(10 downto 0)
            );
    end component cicloJmp;
    signal  jmpTrue, jmpFalse : std_logic_vector(10 downto 0);

begin

    
    

    jmpFalse(10) <=  '1'; --barrINC
    jmpFalse(9) <= '1'; --barrPC
    jmpFalse(8 downto 6) <= "000"; --ULA_OP altera pra 
    jmpFalse(5) <= not(counter(2)) and counter(0); --PC_NRW
    jmpFalse(4) <= '0'; --AC_NRW
    jmpFalse(3) <= '0'; --MEM_NRW

    jmpFalse(2) <= not(counter(0)) and not(counter(1)) and not(counter(2)); --rem_nrw
    jmpFalse(1) <=  counter(0) and not(counter(1)) and not(counter(2)); --RDM_NRW
    jmpFalse(0) <= counter(1) and not(counter(0)) and not(counter(2)); --RI_NRW
    
    u_jmp : cicloJmp port map(counter,jmpTrue);
    s <= jmpTrue when nz(1) = '1' else jmpFalse when nz(0) = '0';
    


end arch;