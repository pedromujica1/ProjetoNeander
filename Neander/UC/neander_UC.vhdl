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
    component moduloContador is
	    port(
            rst, clk : in  std_logic;
	        counter  : out std_logic_vector(2 downto 0)
	    );
    end component;

    component contador is
        port(
            clock_cont, reset_cont, pr_cont: in std_logic;        
            q_cont : out std_logic_vector(2 downto 0)
    
        );
    end component;

    component cicloLda is 
        port(
            counter : in std_logic_vector(2 downto 0);
            s : out std_logic_vector(10 downto 0)
            --signal b_ctrl 
        );
    end component cicloLda;
    

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

    -- Unidade de Controle
    s_bctrl <= slda when s_dec2uc = "00100000000" ; --todas as outras instruções;

    u_lda : cicloLda port map (s_ciclo,sLDA);

    --arquivo LDA
    

    -- s(0) <=  '1'; --barrINC
    -- s(1) <= not c(2) or c(2) or not c(9); --barrPC
    -- s(4 downto 2) <= "000"; --ULA_OP
    -- s(5) <= not (c(1))  and (c(2) xor c(0)); --PC_NRW
    -- s(6) <= c(2) or c(1) or c(0); --AC_NRW
    -- s(7) <= '0'; --MEM_NRW
    -- s(8) <= (not c(1) and (c(2) xnor c(0))) or (not(c(2) and c(1) and c(0))) --rem_nrw
    -- s(9) <= (c(2) and not (c(0)) or (not(c(2)) and not(c(1)) and c(0)))
    -- s(10) <= not c(2) and c(1) and not c(0);

    s_bctrl <= b_nop when sel_op = "10000000000" else
    b_sta when sel_op = "01000000000" else
    b_hlt when sel_op = "00000000001" else
    (others => 'Z');

end architecture docontrolstuff;