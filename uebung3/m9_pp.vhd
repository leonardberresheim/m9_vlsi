library ieee;
use ieee.std_logic_1164.all;

entity m9_pp is                       -- Example
    generic (width_opa_in : positive; -- 4 
    width_opb_in : positive;          -- 5
    width_prod_in : positive;         -- 1
    width_opa_out : positive;         -- 4
    width_opb_out : positive;         -- 5
    width_prod_out : positive);       -- 6
    port (clk : in std_logic;
    reset : in std_logic;
    a_in : in std_logic_vector(width_opa_in - 1 downto 0);
    b_in : in std_logic_vector(width_opb_in - 1 downto 0);
    y_in : in std_logic_vector(width_prod_in - 1 downto 0);
    a_out : out std_logic_vector(width_opa_out - 1 downto 0);
    b_out : out std_logic_vector(width_opb_out - 1 downto 0);
    y_out : out std_logic_vector(width_prod_out - 1 downto 0)); 
    end m9_pp;

architecture behavioural of m9_pp is
    component m9_csa is
        generic (width : positive := width_prod_in);
        port (a, b, c : in  std_logic_vector (width - 1 downto 0); 
                s       : out std_logic_vector (width downto 0);
                cout    : out std_logic);
    end component;
    signal s_s : std_logic_vector (width_prod_in downto 0);    
    signal s_cout : std_logic; 
    signal reg_a_out: std_logic_vector(width_opa_in - 1 downto 0);
    signal reg_b_out: std_logic_vector(width_opb_in - 1 downto 0);
    signal a_shift_out: std_logic_vector(width_opa_out - 1 downto 0);
    signal b_shift_out: std_logic_vector(width_opb_out - 1 downto 0);
    signal b_add_in: std_logic_vector(width_prod_in - 1 downto 0); -- Is added with y_in so it need to be the same size
    signal add_out: std_logic_vector(width_prod_out - 1 downto 0);
    signal mux_out: std_logic_vector(width_prod_out - 1 downto 0);  
    signal reg_y_out: std_logic_vector(width_prod_out - 1 downto 0); 
begin

    -- Register definition --
    registerA: process(clk)
        variable tmp: std_logic_vector(width_opa_in - 1 downto 0);
    begin
        if(clk = '1' and clk'event) then
            if(reset = '1') then
                tmp:= (others => '0') ;
            else
                tmp:= a_in;
            end if;
        end if;
        reg_a_out <= tmp;
    end process;

    registerB: process(clk)
        variable tmp: std_logic_vector(width_opb_in - 1 downto 0);
    begin
        if(clk = '1' and clk'event) then
            if(reset = '1') then
                tmp:=(others => '0') ;
            else
                tmp:= b_in;
            end if;
        end if;
        reg_b_out <= tmp;
    end process;

    registerY: process(clk)
        variable tmp: std_logic_vector(width_prod_out - 1 downto 0);
    begin
        if(clk = '1' and clk'event) then
            if(reset = '1') then
                tmp:=(others => '0') ;
            else
                tmp:= mux_out;
            end if;
        end if;
        reg_y_out <= tmp;
    end process;
    --------------------------------
    -- Shift Operation --
    -- Right Shift --
    a_shift_out(width_opa_out - 1) <= '0';
    a_shift_out(width_opa_out - 2 downto 0) <= reg_a_out(width_opa_in - 1 downto 1);
    -- Left Shift --
    b_shift_out(0) <= '0';
    b_shift_out(width_opb_out - 1 downto 1) <= reg_b_out(width_opb_in - 2 downto 0);
    --------------------------------
    -- Addition --
    add1: m9_csa port map(c => (others => '0'),
                          a => b_add_in,
                          b => y_in, 
                          s => s_s, 
                          cout => s_cout);
    b_add_in(width_opb_in - 1 downto 0) <= reg_b_out;
    b_add_in(width_prod_in - 1 downto width_opb_in) <= (others => '0');
    --------------------------------
    -- Multiplexer
    mux_out <= add_out when (reg_a_out(0) = '1') else '0' & y_in;           

    a_out <= a_shift_out;
    b_out <= b_shift_out;
    y_out <= reg_y_out;

    ------
    add_out <= s_s;


end behavioural;