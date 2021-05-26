entity m9_pp is
    generic (width_opa_in : positive;
    width_opb_in : positive;
    width_prod_in : positive;
    width_opa_out : positive;
    width_opb_out : positive;
    width_prod_out : positive);
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
    component m9_fulladd
    port (cin : in std_logic;
          a, b : in std_logic;
          sum : out std_logic;
          cout : out std_logic);
    end component;

    signal reg_a_out: std_logic_vector(width_opa_in - 1 downto 0);
    signal reg_b_out: std_logic_vector(width_opb_in - 1 downto 0);
    signal a_shift_out: std_logic_vector(width_opa_out - 1 downto 0);
    signal b_shift_out: std_logic_vector(width_opb_out - 1 downto 0);
    signal a_lsb: std_logic;
    signal add_out: std_logic_vector(width_prod_out - 1 downto 0));
    signal mux_out: std_logic_vector(width_prod_out - 1 downto 0));  
    signal reg_y_out: std_logic_vector(width_prod_out - 1 downto 0)); 
begin

    -- Register definition --
    registerA: process(clk)
    variable tmp: std_logic_vector(width_opa_in - 1 downto 0);
    begin
        if(clk = '1' and clk'event) then
            if(reset = '1') then
                tmp:='0';
            else
                tmp:= a_in;
            end if;
        end if;
    reg_a_out <= tmp;
    end;
    registerB: process(clk)
    variable tmp: std_logic_vector(width_opb_in - 1 downto 0);
    begin
        if(clk = '1' and clk'event) then
            if(reset = '1') then
                tmp:='0';
            else
                tmp:= a_in;
            end if;
        end if;
    reg_b_out <= tmp;
    end;
    registerY: process(clk)
    variable tmp: std_logic_vector(width_prod_out - 1 downto 0);
    begin
        if(clk = '1' and clk'event) then
            if(reset = '1') then
                tmp:='0';
            else
                tmp:= a_in;
            end if;
        end if;
    reg_y_out <= tmp;
    end;


end behavioural;