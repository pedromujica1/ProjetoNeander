library ieee;
use ieee.std_logic_1164.all;

entity ffjkD is
port(
    d : in std_logic;
    clockD : in std_logic;
    prD, clD : in std_logic;
    qD, nqD : out std_logic
);
end ffjkD;
architecture ffD of ffjkD is
    
    --Componente ffjk
    component ffjk is
        port(
            j, k : in std_logic;
            clock : in std_logic;
            pr, cl : in std_logic;
            q, nq : out std_logic
        );
    end component;
    --Sinais de saída
    signal s_notd: std_logic; --Sinal para D negado
    signal q_ffjkD : std_logic;
    signal nq_ffjkD : std_logic;
    
    begin
        s_notd <= not d;
        u_ffjkD : ffjk port map(d,s_notD,clockD,prD,clD,q_ffjkD,nq_ffjkD);
        qD <= q_ffjkD;
        nqD <= nq_ffjkD;
    end architecture;


