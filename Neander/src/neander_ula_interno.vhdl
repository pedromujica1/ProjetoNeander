-- neander módulo interno ULA =================================================
library IEEE;
use IEEE.std_logic_1164.all;

entity moduloULAinterno is
	port(
        x, y        : in  std_logic_vector(7 downto 0);
        ula_op      : in  std_logic_vector(2 downto 0);
        flags_nz    : out std_logic_vector(1 downto 0);
        s           : out std_logic_vector(7 downto 0)
	);
end entity;

architecture domathstuff of moduloULAinterno is
    
    --Compoenent para realizar operações Lógicas (AND/NOT/OR)
    component OpLogicos8bits is
        port(
            x : in std_logic_vector(7 downto 0);
            y : in std_logic_vector(7 downto 0);
            saida_and : out std_logic_vector(7 downto 0);
            saida_or : out std_logic_vector(7 downto 0);
            saida_not : out std_logic_vector(7 downto 0)
        );
    end component OpLogicos8bits; 
    
    --Componente Somador 8 bits
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
    
    --Component MUX5x8
    component mux5x8 is
        port (
            --Canais de 8 MUX 2x1 
            canal0: in std_logic_vector(7 downto 0); 
            canal1: in std_logic_vector(7 downto 0); 
            canal2: in std_logic_vector(7 downto 0); 
            canal3: in std_logic_vector(7 downto 0);
            canal4: in std_logic_vector(7 downto 0); 
            seletor: in std_logic_vector (2 downto 0); 
            --1 saída Z para 8 MUX2x1
            Zc : out std_logic_vector(7 downto 0)
        ); 
    end component;

    signal sand, sor, snot, slda, ssMux : std_logic_vector(7 downto 0);
    signal sadd, saddc, sCout: std_logic_vector(7 downto 0);
    signal cout_adder : std_logic;
    signal s_nz : std_logic_vector(2 downto 0);
    signal s_ulaOp : std_logic_vector (2 downto 0 );

begin

    -- AND e OR e NOT
    u_operacoesLogicas : OpLogicos8bits port map(x,y,sand,sor,snot);
   
    -- LDA
    slda<=y; --MEM_DATA
    
    -- ADDER
    u_somador8bits : somador8bits port map(x,y,'0',sadd,cout_adder);

    -- MUX
    u_mux5x8 : mux5x8 port map (
    canal0  => slda, 
    canal1  => sadd, 
    canal2  => sor, 
    canal3  => sand, 
    canal4  => snot, 
    seletor => ula_op, 
    Zc      => ssMux);
    
    -- FLAGS NZ
    flags_nz <= "10" when ssMux(7) = '1' else
    "01" when (ssMux = "00000000") else "00";

    s <= ssMux;

end architecture domathstuff;
