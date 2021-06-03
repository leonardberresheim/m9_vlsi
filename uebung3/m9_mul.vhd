library ieee;
use ieee.std_logic_1164.all;

entity m9_mul is
    generic (width : positive := 4);
    port (clk, reset : in std_logic;
          a, b : in std_logic_vector(width - 1 downto 0);
          y : out std_logic_vector((2 * width) - 1 downto 0));
end m9_mul;

architecture behavioural of m9_mul is
    component m9_pp
        generic (width_opa_in : positive := width;          -- 4 
            width_opb_in : positive := (2 * width) - 1;     -- 7
            width_prod_in : positive := (2 * width) - 1;    -- 7
            width_opa_out : positive := width;              -- 4
            width_opb_out : positive := (2 * width) - 1;    -- 7
            width_prod_out : positive := (2 * width));       -- 8
        port (clk : in std_logic;
            reset : in std_logic;
            a_in : in std_logic_vector(width_opa_in - 1 downto 0);
            b_in : in std_logic_vector(width_opb_in - 1 downto 0);
            y_in : in std_logic_vector(width_prod_in - 1 downto 0);
            a_out : out std_logic_vector(width_opa_out - 1 downto 0);
            b_out : out std_logic_vector(width_opb_out - 1 downto 0);
            y_out : out std_logic_vector(width_prod_out - 1 downto 0));
    end component;
    
    type array_short is array(0 to width) of std_logic_vector(width - 1 downto 0);
    type array_venti is array(0 to width) of std_logic_vector((2*width) -2 downto 0);
    type array_grande is array(0 to width) of std_logic_vector((2*width) - 1 downto 0);


    signal s_A : array_short;
    signal s_B : array_venti;
    signal s_Y : array_grande;
begin

    PP_GEN :
    for i in 0 to width - 1 generate
        PP_X : m9_pp
            port map(clk => clk, 
                    reset => reset, 
                    a_in => s_A(i), 
                    b_in => s_B(i),
                    y_in => s_Y(i)((2 * width) - 2 downto 0),
                    a_out => s_A(i+1),
                    b_out => s_B(i+1),
                    y_out => s_Y(i+1));
    end generate;

    s_A(0) <= a;
    s_B(0)(width - 1 downto 0) <= b;
    s_B(0)((2*width) -2 downto width) <= (others => '0');
    s_Y(0) <= (others => '0');
    y <= s_Y(width);
        


end behavioural;