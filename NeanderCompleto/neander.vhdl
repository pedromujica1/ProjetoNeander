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

    --MODULO UC
    component moduloUC is
        port(
            rst, clk   : in  std_logic;
            barramento : in  std_logic_vector(7 downto 0);
            RI_nrw     : in  std_logic;
            flags_nz   : in  std_logic_vector(1 downto 0);
            bctrl      : out std_logic_vector(10 downto 0)
        );
    end component moduloUC;

    --MODULO PC
    component moduloPC is
        port(
            rst, clk   : in  std_logic;
            PC_nrw     : in  std_logic;
            nbarrINC   : in    std_logic;
            barramento : in  std_logic_vector(7 downto 0);
            endereco   : out std_logic_vector(7 downto 0)
        );
    end component moduloPC;

    --BARRAMENTO
    signal sbarramento : std_logic_vector(7 downto 0) := (others => '0');
    
    --SAIDA PC
    signal s_endPC, s_endBarr : std_logic_vector(7 downto 0);
    --flagsNZ
    signal flagsNZ : std_logic_vector(1 downto 0);

    signal barramentoControle : std_logic_vector(10 downto 0) := (others => '0');

    signal s_ula_op : std_logic_vector(2 downto 0);

    begin

        u_UC : moduloUC port map (
            rst         => rst,
            clk         => clk,
            barramento  => sbarramento,
            RI_nrw      => barramentoControle(0),
            flags_nz    => flagsNZ,
            bctrl       => barramentoControle
        );
        s_ula_op <= barramentoControle(8 downto 6);

        u_PC : moduloPC port map (
            rst         => rst,
            clk         => clk,
            PC_nrw      => barramentoControle(5),
            nbarrINC    => barramentoControle(10),
            barramento  => sbarramento,
            endereco    => s_endPC
        );

        u_ULA : moduloULA port map (
            rst         => rst,
            clk         => clk,
            AC_nrw      => barramentoControle(4),
            ula_op      => s_ula_op,
            MEM_nrw     => barramentoControle(3),
            flags_nz    => flagsNZ,
            barramento  => sbarramento
        );

        u_MEMORIA : moduloMEM port map (
            rst         => rst,
            clk         => clk,
            nbarrPC     => barramentoControle(9),
            REM_nrw     => barramentoControle(2),
            MEM_nrw     => barramentoControle(3),
            RDM_nrw     => barramentoControle(1),
            end_PC      => s_endPC,
            end_Barr    => sbarramento,
            barramento  => sbarramento
        );
        
end architecture;
