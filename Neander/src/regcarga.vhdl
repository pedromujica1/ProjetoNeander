library ieee;
use ieee.std_logic_1164.all;

entity regcarga is
port(

    d : in std_logic;
    clk : in std_logic;
    pr, cl : in std_logic;
    nrw : in std_logic;
    s : out std_logic
);
end entity;
architecture reg1bit of regcarga is
component ffjkD is
port(
    d : in std_logic;
    clockD : in std_logic;
    prD, clD : in std_logic;
    qD, nqD : out std_logic
);
end component;
--Componente MUX 2x1
component mux2x1 is
    port(
        canal0: in std_logic;
        seletor: in std_logic;
        --Saída de Y negado
        canal1: in std_logic;
        --1 saída Z para 8 MUX2x1
        Zc : out std_logic
    );
end component;


signal datain, dataout: std_logic;
begin
    -- instância do registrador
    u_reg : ffjkD port map(datain,clk,pr,cl,dataout);
    u_mux2x1 : mux2x1 port map(dataout,nrw,d,datain);
    s<=dataout;
    
end architecture;