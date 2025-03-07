library ieee;
use ieee.std_logic_1164.all;

entity contador is
    port(
        clock_cont, reset_cont, pr_cont: in std_logic;        
        q_cont : out std_logic_vector(2 downto 0)

    );
end entity;

architecture contar of contador is
    component controler is
        port(
            q : in std_logic_vector (2 downto 0);
            j,k : out std_logic_vector (2 downto 0)
            
        );
    end component;
    component ffjk is
        port(
            j, k : in std_logic;
            clock : in std_logic;
            pr, cl : in std_logic;
            q, nq : out std_logic
        );
    end component;

    signal sj,sk: std_logic_vector (2 downto 0);
    signal sq, s_notq: std_logic_vector (2 downto 0);

    begin

        u_controle : controler port map(sq, sj, sk);

        -- Instanciando os Flip-Flops JK
        u_ffjk0 : ffjk port map(sj(0), sk(0), clock_cont, reset_cont, pr_cont, sq(0),s_notq(0) );
        u_ffjk1 : ffjk port map(sj(1), sk(1), clock_cont, pr_cont, reset_cont, sq(1),s_notq(1) );
        u_ffjk2 : ffjk port map(sj(2), sk(2), clock_cont, pr_cont, reset_cont, sq(2),s_notq(2) );

        q_cont <= sq;

end architecture;
