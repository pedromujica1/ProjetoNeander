-- neander módulo principal ULA ===============================
library IEEE;
use IEEE.std_logic_1164.all;

entity moduloULA is
	port(
        rst, clk    : in    std_logic;
        AC_nrw      : in    std_logic;
        ula_op      : in    std_logic_vector(2 downto 0);
        MEM_nrw     : in    std_logic;
        flags_nz    : out   std_logic_vector(1 downto 0);
		barramento  : inout std_logic_vector(7 downto 0)
	);
end entity moduloULA;

architecture domathstuff of moduloULA is
    -- componente regAC
    component regcarga8bits is
        port(
        
            d : in std_logic_vector (7 downto 0);
            clk : in std_logic;
            pr, cl : in std_logic;
            nrw : in std_logic;
            s : out std_logic_vector (7 downto 0)
        );
    end component;
    
    -- componente regFLAGS
    component regcarga2bits is
        port(
        
            d : in std_logic_vector (1 downto 0);
            clk : in std_logic;
            pr, cl : in std_logic;
            nrw : in std_logic;
            s : out std_logic_vector (1 downto 0)
        );
    end component;

    -- componente ULAinterno
    component moduloULAinterno is
        port(
            x, y        : in  std_logic_vector(7 downto 0);
            ula_op      : in  std_logic_vector(2 downto 0);
            flags_nz    : out std_logic_vector(1 downto 0);
            s           : out std_logic_vector(7 downto 0)
        );
    end component;  

    signal s_ac2ula, s_ula2ac : std_logic_vector(7 downto 0);
    signal s_ula2flags        : std_logic_vector(1 downto 0);

begin

    -- registrador AC
    u_registradorAC : regcarga8bits port map(s_ula2ac,clk,'1',rst,AC_nrw,s_ac2ula);

    -- modulo ULA interno
    u_ULAinterno : moduloULAinterno port map(s_ac2ula,barramento,ula_op,s_ula2flags,s_ula2ac);

    -- registrador FLAGS
    u_registradorFLAGS : regcarga2bits port map(s_ula2flags,clk,'1',rst,AC_nrw,flags_nz);
        
    barramento <= s_ac2ula when MEM_nrw='1' else (others => 'Z');--mux2x8z especial
    
end architecture domathstuff;

