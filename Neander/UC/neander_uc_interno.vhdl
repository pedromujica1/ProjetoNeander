-- neander módulo secundario UC-PC ==================================
library IEEE;
use IEEE.std_logic_1164.all;

entity moduloPC is
	port(
        rst, clk   : in  std_logic;
        PC_nrw     : in  std_logic;
        nbarrINC   : in    std_logic;
        barramento : in  std_logic_vector(7 downto 0);
	    endereco   : out std_logic_vector(7 downto 0)
	);
end entity moduloPC;

architecture dopointstuff of moduloPC is

    -- componente regPC
    component regcarga8bits is
        port(
            d : in std_logic_vector (7 downto 0);
            clk : in std_logic;
            pr, cl : in std_logic;
            nrw : in std_logic;
            s : out std_logic_vector (7 downto 0)
            
        );
    end component;

    --Componente somador
    component Somador8bits is
        port(
            --Entradas e saídas do Somador
            x : in std_logic_vector (7 downto 0);
            y : in std_logic_vector (7 downto 0);
            Cin : in std_logic; --Representa o Cin do Somador
            s : out std_logic_vector (7 downto 0); --Saída
            Cout_geral : out std_logic
        );
    end component Somador8bits;

    --Componente Multiplexador 2x8
    component mux2x8 is
        port (
            --Canais de 8 MUX 2x1 
            canal0: in std_logic_vector (7 downto 0);
            canal1 : in std_logic_vector (7 downto 0);
            seletor: in std_logic;
            Zc : out std_logic_vector (7 downto 0)
        ); 
    end component mux2x8;

    signal sendereco, s_mux2pc : std_logic_vector(7 downto 0) := (others => 'Z');
    signal sadd, saddc, x, y   : std_logic_vector(7 downto 0) := (others => 'Z');
    signal s_um : std_logic_vector(7 downto 0) := "00000001";
    signal Cout_geral : std_logic;

begin
    -- mux2x8
    u_mux2x8 : mux2x8 port map(barramento, sadd, nbarrINC , s_mux2pc );
    
    -- registrador PC
    u_regcarga8: regcarga8bits port map (s_mux2pc,clk,'1',rst,PC_nrw,sendereco);
    endereco <= sendereco;

    -- incrementador
    x <= sendereco;
    y <= s_um;

    -- ADDER
    u_somador : Somador8bits port map (x,y,'0', sadd,COut_geral );


end architecture dopointstuff;
