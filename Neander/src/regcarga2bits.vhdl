library ieee;
use ieee.std_logic_1164.all;

entity regcarga2bits is
    port(
    
        d : in std_logic_vector (1 downto 0);
        clk : in std_logic;
        pr, cl : in std_logic;
        nrw : in std_logic;
        s : out std_logic_vector (1 downto 0)
    );
end entity;

architecture reg2bits of regcarga2bits is
    component regcarga is
        port(
        
            d : in std_logic;
            clk : in std_logic;
            pr, cl : in std_logic;
            nrw : in std_logic;
            s : out std_logic
        );
    end component;
    begin 
        -- instâncias de regCarga2bit (2 vezes)
        u_reg0 : regcarga port map(d(0), clk, pr, cl, nrw, s(0));
        u_reg1 : regcarga port map(d(1), clk, pr, cl, nrw, s(1));
    end architecture;