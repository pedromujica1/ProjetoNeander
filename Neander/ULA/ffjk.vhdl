library ieee;
use ieee.std_logic_1164.all;
entity ffjk is
port(
    j, k : in std_logic;
    clock : in std_logic;
    pr, cl : in std_logic;
    q, nq : out std_logic
);
end ffjk;
architecture ff of ffjk is
    signal s_snj , s_snk : std_logic;
    signal s_sns , s_snr : std_logic;
    signal s_sns2, s_snr2 : std_logic;
    signal s_eloS, s_eloR : std_logic;
    signal s_eloQ, s_elonQ: std_logic;
    signal s_nClock : std_logic;
begin
    s_nClock <= not(clock);
    -- envio de saídas de NAND para Q e NQ
    
    -- s_snj <+ not(X and Y and Z)
    s_snj <=(not(j and clock and s_elonQ));
    -- NAND de 3 entradas? Faça not( X and Y and Z)
    
    -- s_snk
    s_snk <= (not(clock and k and s_eloQ));
    
    -- s_sns
    s_sns<= (not(pr and s_snj and s_eloR));

    s_snr <= (not(cl and s_snk and s_eloS));

    --Ligação entre o elo e o sinal
    s_eloS <= s_sns;
    s_eloR <= s_snr;

    --quinta NAND
    s_sns2 <= not(s_sns and s_nClock);

    --SEXTO NAND
    s_snr2 <= not(s_snr and s_nClock);

    --setimo NAND
    s_eloQ <= not(pr and s_sns2 and s_elonQ);

    --oitavo e ultimo nand
    s_elonQ <= not(cl and s_snr2 and s_eloQ);

    --Interligação  entre elo e saìda
    q<= s_eloQ;
    nq <= s_elonQ;
    -- s_snr
    -- s_sns2
    -- s_snr2
    -- s_eloS
    -- s_eloR
    -- s_eloQ
    -- s_elonQ
end architecture ff;