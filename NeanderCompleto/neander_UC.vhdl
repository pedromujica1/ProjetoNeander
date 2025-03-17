-- neander módulo principal UC ===============================================
library IEEE;
use IEEE.std_logic_1164.all;

entity moduloUC is
	port(
        rst, clk   : in  std_logic;
        barramento : in  std_logic_vector(7 downto 0);
        RI_nrw     : in  std_logic;
        flags_nz   : in  std_logic_vector(1 downto 0);
	    bctrl      : out std_logic_vector(10 downto 0)
	);
end entity moduloUC;

architecture docontrolstuff of moduloUC is
    -- componente regRI
    component regcarga8bits is
        port(
            d : in std_logic_vector (7 downto 0);
            clk : in std_logic;
            pr, cl : in std_logic;
            nrw : in std_logic;
            s : out std_logic_vector (7 downto 0)
            
        );
    end component;
    -- componente DECODE
    -- on code!
    
    -- componente Contador0-7
    component contador is
        port(
            clock_cont, reset_cont, pr_cont: in std_logic;        
            q_cont : out std_logic_vector(2 downto 0)
    
        );
    end component;
    --cicloLDA
    component cicloLda is 
        port(
            counter : in std_logic_vector(2 downto 0);
            s : out std_logic_vector(10 downto 0)
            --signal b_ctrl 
        );
    end component cicloLda;
    --cicloADD
    component cicloAdd is
        port(
            counter : in std_logic_vector(2 downto 0);
            s : out std_logic_vector(10 downto 0)
            );
    end component cicloAdd;
    --CICLOAND
    component cicloAnd is
        port(
            counter : in std_logic_vector(2 downto 0);
            s : out std_logic_vector(10 downto 0)
            );
    end component cicloAnd;

    --CICLO HLT
    component cicloHlt is
    port(
        counter : in std_logic_vector(2 downto 0);
        s : out std_logic_vector(10 downto 0)
        );
    end component cicloHlt;
    --CICLO JMP
    component cicloJmp is
        port(
            counter : in std_logic_vector(2 downto 0);
            s : out std_logic_vector(10 downto 0)
            );
    end component cicloJmp;
    --CICLO JN
    component cicloJn is
        port(
            counter : in std_logic_vector(2 downto 0);
            nz      : in std_logic_vector(1 downto 0);
            s : out std_logic_vector(10 downto 0)
            );
    end component cicloJn;
    --CICLO JZ
    component cicloJz is
        port(
            counter : in std_logic_vector(2 downto 0);
            nz      : in std_logic_vector(1 downto 0);
            s : out std_logic_vector(10 downto 0)
            );
    end component cicloJz;
    --CICLO NOP
    component cicloNop is
        port(
            counter : in std_logic_vector(2 downto 0);
            s : out std_logic_vector(10 downto 0)
            );
    end component cicloNop;
    --CICLO NOT
    component cicloNot is
        port(
            counter : in std_logic_vector(2 downto 0);
            s : out std_logic_vector(10 downto 0)
            );
    end component cicloNot;
    
    --CICLO OR
    component cicloOr is
        port(
            counter : in std_logic_vector(2 downto 0);
            s : out std_logic_vector(10 downto 0)
            );
    end component cicloOr;
    --CICLO STA
    component cicloSta is
        port(
            counter : in std_logic_vector(2 downto 0);
            s : out std_logic_vector(10 downto 0)
            );
    end component cicloSta;
    
    -- componente UC-interno
    component moduloPC is
        port(
            rst, clk   : in  std_logic;
            PC_nrw     : in  std_logic;
            nbarrINC   : in    std_logic;
            barramento : in  std_logic_vector(7 downto 0);
            endereco   : out std_logic_vector(7 downto 0)
        );
    end component moduloPC;

    -- on code!

    -- 3bits de contador
    signal s_ciclo : std_logic_vector(2 downto 0) := (others => 'Z');

    signal s_ri2dec : std_logic_vector(7 downto 0) := (others => 'Z');
    
    -- nop, sta, lda, add, or, and, not, jmp, jn, jz, hlt
    signal s_nop, s_sta, s_lda, s_add, s_or, s_and, s_not, s_jmp, s_jn, s_jz, s_hlt : std_logic_vector(10 downto 0);

    signal s_dec2uc : std_logic_vector(10 downto 0) := (others => 'Z');

    signal s_bctrl  : std_logic_vector(10 downto 0) := (others => 'Z');

    -- observacao
    signal instrucaoAtiva : string(1 to 3);
    signal operacaoULA    : string(1 to 3);
    signal FLAGS          : string(1 to 2);

begin
    -- registrador RI
    u_regRI: regcarga8bits port map(barramento, clk,'1',rst, RI_nrw, s_ri2dec);


    -- decodificador 4 para 11
    s_dec2uc <= "10000000000" when s_ri2dec = "00000000" else --NOP
    "01000000000" when s_ri2dec = "00010000" else -- STA
    "00100000000" when s_ri2dec = "00100000" else -- LDA
    "00010000000" when s_ri2dec = "00110000" else -- ADD
    "00001000000" when s_ri2dec = "01000000" else -- OR
    "00000100000" when s_ri2dec = "01010000" else -- AND
    "00000010000" when s_ri2dec = "01100000" else -- NOT
    "00000001000" when s_ri2dec = "10000000" else -- JMP
    "00000000100" when s_ri2dec = "10010000" else -- JN
    "00000000010" when s_ri2dec = "10100000" else -- JZ
    "00000000001" when s_ri2dec = "11110000"; -- HLT

    -- contador
    u_contador: contador port map(clk,rst,'1',s_ciclo);

    --Ciclos das instruções
    u_nop : cicloNop port map (s_ciclo,s_nop);
    u_sta : cicloSta port map (s_ciclo,s_sta);
    u_lda : cicloLda port map (s_ciclo,s_lda);
    u_add : cicloAdd port map (s_ciclo,s_add);
    u_and : cicloAnd port map (s_ciclo,s_and);
    u_or : cicloOr port map (s_ciclo,s_or);
    u_not : cicloNot port map (s_ciclo,s_not);
    u_jmp : cicloJmp port map (s_ciclo,s_jmp);
    u_jn : cicloJn port map (s_ciclo, flags_nz,s_jn);
    u_jz : cicloJz port map (s_ciclo, flags_nz,s_jz);
    u_hlt : cicloHlt port map (s_ciclo,s_hlt);

    -- Unidade de Controle    
    s_bctrl <=  s_nop when s_dec2uc = "10000000000" else
                s_sta when s_dec2uc = "01000000000" else
                s_lda when s_dec2uc = "00100000000" else
                s_add when s_dec2uc = "00010000000" else
                s_or  when s_dec2uc = "00001000000" else
                s_and when s_dec2uc = "00000100000" else
                s_not when s_dec2uc = "00000010000" else
                s_jmp when s_dec2uc = "00000001000" else
                s_jn  when s_dec2uc = "00000000100" else
                s_jz  when s_dec2uc = "00000000010" else
                s_hlt when s_dec2uc = "00000000001" else
                (others => 'Z');
    bctrl <= s_bctrl; 

end architecture docontrolstuff;