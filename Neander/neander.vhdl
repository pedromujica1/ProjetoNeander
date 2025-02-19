library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity NEANDER is
        port (
            rst: in std_logic;
            clk: in std_logic
        );
end entity;

architecture docomputingstuff of NEANDER is

    --MODULO ULA
    component moduloULA is
        port(
            rst, clk    : in    std_logic;
            AC_nrw      : in    std_logic;
            ula_op      : in    std_logic_vector(2 downto 0);
            MEM_nrw     : in    std_logic;
            flags_nz    : out   std_logic_vector(1 downto 0);
            barramento  : inout std_logic_vector(7 downto 0)
        );
    end component moduloULA;

    --modulo memoria
    component moduloMEM is
        port(
            rst, clk   : in    std_logic;
            nbarrPC    : in    std_logic;
            REM_nrw    : in    std_logic;
            MEM_nrw    : in    std_logic;
            RDM_nrw    : in    std_logic;
            end_PC     : in    std_logic_vector(7 downto 0);       
            end_Barr   : in    std_logic_vector(7 downto 0);
            barramento : inout std_logic_vector(7 downto 0)
        );
    end component moduloMEM;
    signal barramento : std_logic_vector(7 downto 0);
    signal s_endPC, s_endBarr : std_logic_vector(7 downto 0);
    signal flagsNZ : std_logic_vector(1 downto 0);
    begin
        u_ULA : moduloULA port map(rst, clk, AC_nrw,ula_op, MEM_nrw, flags_nz, barramento);
        u_MEMORIA : moduloMEM port map( nbarrPC, REM_nrw,MEM_nrw,RDM_nrw, RDM_nrw, s_endPC, s_endBarr <= barramento);

    --component moduloULA is 
end architecture;
