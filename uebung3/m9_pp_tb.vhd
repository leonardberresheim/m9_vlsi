library ieee;
use ieee.std_logic_1164.all;

entity m9_pp_tb is
    generic (width_opa_in : positive := 4;
        width_opb_in : positive := 4;
        width_prod_in : positive := 5;
        width_opa_out : positive := 4;
        width_opb_out : positive := 4;
        width_prod_out : positive := 6);
end m9_pp_tb;

architecture behavioural of m9_pp_tb is
    component m9_pp is
        generic (width_opa_in : positive := 4;
        width_opb_in : positive := 4;
        width_prod_in : positive := 5;
        width_opa_out : positive := 4;
        width_opb_out : positive := 4;
        width_prod_out : positive := 6);
        port (clk : in std_logic;
            reset : in std_logic;
            a_in : in std_logic_vector(width_opa_in - 1 downto 0);
            b_in : in std_logic_vector(width_opb_in - 1 downto 0);
            y_in : in std_logic_vector(width_prod_in - 1 downto 0);
            a_out : out std_logic_vector(width_opa_out - 1 downto 0);
            b_out : out std_logic_vector(width_opb_out - 1 downto 0);
            y_out : out std_logic_vector(width_prod_out - 1 downto 0)); 
    end component;
    signal clk : std_logic := '0';
    signal rst : std_logic;
    signal s_a_in : std_logic_vector(width_opa_in - 1 downto 0);
    signal s_b_in : std_logic_vector(width_opb_in - 1 downto 0);
    signal s_y_in : std_logic_vector(width_prod_in - 1 downto 0);
    signal s_a_out : std_logic_vector(width_opa_out - 1 downto 0);
    signal s_b_out : std_logic_vector(width_opb_out - 1 downto 0);
    signal s_y_out : std_logic_vector(width_prod_out - 1 downto 0); 
begin
    uut: m9_pp port map(
        clk => clk,
        reset => rst,
        a_in => s_a_in, 
        b_in => s_b_in,
        y_in => s_y_in,
        a_out => s_a_out,
        b_out => s_b_out,
        y_out => s_y_out);

    CLOCK:
    clk <=  '1' after 1 ns when clk = '0' else
            '0' after 1 ns when clk = '1';

    stim_proc: process
    begin
        rst <= '1'; wait for 1 ns; 
        rst <= '0'; wait for 1 ns; 
        s_a_in <= "1010"; s_b_in <= "0101"; s_y_in <= "00000"; wait for 20 ns; assert s_a_out = "0101" and s_b_out = "1010" and s_y_out = "000000" report "0 failed"; 
        s_a_in <= "0101"; s_b_in <= "1010"; s_y_in <= "00000"; wait for 20 ns; assert s_a_out = "0010" and s_b_out = "0100" and s_y_out = "001010" report "1 failed"; 
        s_a_in <= "0010"; s_b_in <= "0100"; s_y_in <= "01010"; wait for 20 ns; assert s_a_out = "0001" and s_b_out = "1000" and s_y_out = "001010" report "2 failed"; 
        s_a_in <= "0001"; s_b_in <= "1000"; s_y_in <= "01010"; wait for 20 ns; assert s_a_out = "0000" and s_b_out = "0000" and s_y_out = "010010" report "3 failed"; 
        report "Carry Save testbench finished";
        wait;
    end process;    

end behavioural;