library ieee;
use ieee.std_logic_1164.all;
entity ffjk is
port(
    j, k : in std_logic;
    clk : in std_logic;
    pr, cl : in std_logic;
    q, nq : out std_logic
);
end ffjk;

architecture ff of ffjk is
    signal sq  : std_logic := '0';
    signal snq : std_logic := '1';
begin

    q  <= sq;
    nq <= snq;

    u_ff : process (clk, pr, cl)
    begin
        if (pr = '0') and (cl = '0') then
            sq  <= 'X';
            snq <= 'X';
            elsif (pr = '1') and (cl = '0') then
                sq  <= '0';
                snq <= '1';
                elsif (pr = '0') and (cl = '1') then
                    sq  <= '1';
                    snq <= '0';
                    elsif (pr = '1') and (cl = '1') then
                        if falling_edge(clk) then
                            if    (j = '0') and (k = '0') then
                                sq  <= sq;
                                snq <= snq;
                            elsif (j = '0') and (k = '1') then
                                sq  <= '0';
                                snq <= '1';
                            elsif (j = '1') and (k = '0') then
                                sq  <= '1';
                                snq <= '0';
                            elsif (j = '1') and (k = '1') then
                                sq  <= not(sq);
                                snq <= not(snq);
                            else
                                sq  <= 'U';
                                snq <= 'U';
                            end if;
                        end if;
            else
                sq  <= 'X';
                snq <= 'X';
        end if;
    end process;

end architecture;