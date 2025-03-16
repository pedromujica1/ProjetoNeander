library IEEE;
use IEEE.std_logic_1164.all;

entity moduloMEM is
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
end entity moduloMEM;

architecture dostoragestuff of moduloMEM is
    -- componente regREM e regRDM
    component regcarga8bits is
        port(
            d : in std_logic_vector (7 downto 0);
            clk : in std_logic;
            pr, cl : in std_logic;
            nrw : in std_logic;
            s : out std_logic_vector (7 downto 0)
            
        );
    end component;

    -- componente MEMORIA
    component as_ram is
	    port(
		    addr  : in    std_logic_vector(7 downto 0);
		    data  : inout std_logic_vector(7 downto 0);
		    notrw : in    std_logic;
		    reset : in    std_logic
	    );
    end component as_ram;

    component mux2x8 is
        port (
            --Canais de 8 MUX 2x1 
            canal0: in std_logic_vector (7 downto 0);
            canal1 : in std_logic_vector (7 downto 0);
            seletor: in std_logic;
            Zc : out std_logic_vector (7 downto 0)
        ); 
    end component mux2x8;

    signal s_mux2rem, s_rem2mem, s_mem2rdm : std_logic_vector(7 downto 0) := (others => 'Z');
    signal s_rdm2barr : std_logic_vector(7 downto 0) := (others => 'Z');
begin

    -- mux2x8
    u_mux2x8 : mux2x8 port map(end_PC,end_Barr,nbarrPC,s_mux2rem );

    -- registrador REM
    --present e clear (d/clk/pr/cl/nrw/saida)
    u_regREM: regcarga8bits port map(s_mux2rem,clk,'1',rst,REM_nrw,s_rem2mem);
    
    --Memória (addr/data//notrw/reset)
    u_memory : as_ram port map(s_mux2rem,s_mem2rdm,MEM_nrw,rst);

    --registrador RDM
    u_regRDM: regcarga8bits port map(s_mem2rdm,clk,'1',rst,RDM_nrw,s_rdm2barr);
   
    -- trap killer!
    barramento <= s_rdm2barr when MEM_nrw = '0' else (others => 'Z');
    s_mem2rdm  <= barramento when MEM_nrw = '1' else (others => 'Z');


end architecture;