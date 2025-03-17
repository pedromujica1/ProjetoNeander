library ieee;
use ieee.std_logic_1164.all;

entity Somador8bits is
    port(
        --Entradas e saídas do Somador
        x : in std_logic_vector (7 downto 0);
        y : in std_logic_vector (7 downto 0);
        Cin : in std_logic; --Representa o Cin do Somador
        s : out std_logic_vector (7 downto 0); --Saída
        Cout_geral : out std_logic
    );
end entity Somador8bits;

architecture comportamento of Somador8bits is
    --Componente Somador completo
    component somadorCompleto is
        port (x,y,Cin : in std_logic;
        s,cout : out std_logic);
    end component;

   --SINAIS SOMADOR 8 BITS
    signal s_carry : std_logic_vector (7 downto 0);
    
    begin   
        --Realiza Soma de 8 bits
        u_somador0: somadorCompleto port map (x(0), y(0),Cin,s(0),s_carry(0));
        u_somador1: somadorCompleto port map (x(1), y(1), s_carry(0), s(1), s_carry(1));
        u_somador2: somadorCompleto port map (x(2), y(2), s_carry(1), s(2), s_carry(2));
        u_somador3: somadorCompleto port map (x(3), y(3), s_carry(2), s(3), s_carry(3));
        u_somador4: somadorCompleto port map (x(4), y(4), s_carry(3), s(4), s_carry(4));
        u_somador5: somadorCompleto port map (x(5), y(5), s_carry(4), s(5), s_carry(5));
        u_somador6: somadorCompleto port map (x(6), y(6), s_carry(5), s(6), s_carry(6));
        u_somador7: somadorCompleto port map (x(7), y(7), s_carry(6), s(7), Cout_geral);
end architecture;