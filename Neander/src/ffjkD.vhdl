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

architecture ffd of ffjkD is
    component ffjk is
        port(
            j, k   : in std_logic;
            clk    : in std_logic;
            pr, cl : in std_logic;
            q, nq  : out std_logic
        );
    end component;

    signal sq  : std_logic := '0'; -- opcional -> valor inicial
    signal snq : std_logic := '1';
    signal nj  : std_logic;
begin

    u_td : ffjk port map(d, nj, clockD, prD, clD, qD, nqD);
    nj <= not(d);

end architecture;
