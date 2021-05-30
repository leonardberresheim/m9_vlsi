library ieee;
use ieee.std_logic_1164.all;

entity m9_pp_tb is
    generic (width_opa_in : positive := 4;
        width_opb_in : positive := 7;
        width_prod_in : positive := 7;
        width_opa_out : positive := 4;
        width_opb_out : positive := 7;
        width_prod_out : positive := 8);
end m9_pp_tb;

architecture behavioural of m9_pp_tb is
    component m9_pp is
        generic (width_opa_in : positive := 4;
        width_opb_in : positive := 7;
        width_prod_in : positive := 7;
        width_opa_out : positive := 4;
        width_opb_out : positive := 7;
        width_prod_out : positive := 8);
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
        -- Test 1: 10 * 5 = 50
        s_a_in <= "1010"; s_b_in <= "0000101"; s_y_in <= "0000000"; wait for 20 ns; assert s_a_out = "0101" and s_b_out = "0001010" and s_y_out = "00000000" report "0 failed"; 
        s_a_in <= "0101"; s_b_in <= "0001010"; s_y_in <= "0000000"; wait for 20 ns; assert s_a_out = "0010" and s_b_out = "0010100" and s_y_out = "00001010" report "1 failed"; 
        s_a_in <= "0010"; s_b_in <= "0010100"; s_y_in <= "0001010"; wait for 20 ns; assert s_a_out = "0001" and s_b_out = "0101000" and s_y_out = "00001010" report "2 failed"; 
        s_a_in <= "0001"; s_b_in <= "0101000"; s_y_in <= "0001010"; wait for 20 ns; assert s_a_out = "0000" and s_b_out = "1010000" and s_y_out = "00110010" report "3 failed"; 
        report "Finished Test 1 successfuly";
        -- Test 2: 13 * 10 = 130
        s_a_in <= "1101"; s_b_in <= "0001010"; s_y_in <= "0000000"; wait for 20 ns; assert s_a_out = "0110" and s_b_out = "0010100" and s_y_out = "00001010" report "4 failed"; 
        s_a_in <= "0110"; s_b_in <= "0010100"; s_y_in <= "0001010"; wait for 20 ns; assert s_a_out = "0011" and s_b_out = "0101000" and s_y_out = "00001010" report "5 failed"; 
        s_a_in <= "0011"; s_b_in <= "0101000"; s_y_in <= "0001010"; wait for 20 ns; assert s_a_out = "0001" and s_b_out = "1010000" and s_y_out = "00110010" report "6 failed"; 
        s_a_in <= "0001"; s_b_in <= "1010000"; s_y_in <= "0110010"; wait for 20 ns; assert s_a_out = "0000" and s_b_out = "0100000" and s_y_out = "10000010" report "7 failed"; 
        report "Finished Test 2 successfuly";
        -- Test 3 : 15 * 15 = 225
        s_a_in <= "1111"; s_b_in <= "0001111"; s_y_in <= "0000000"; wait for 20 ns; assert s_a_out = "0111" and s_b_out = "0011110" and s_y_out = "00001111" report "8 failed"; 
        s_a_in <= "0111"; s_b_in <= "0011110"; s_y_in <= "0001111"; wait for 20 ns; assert s_a_out = "0011" and s_b_out = "0111100" and s_y_out = "00101101" report "9 failed"; 
        s_a_in <= "0011"; s_b_in <= "0111100"; s_y_in <= "0101101"; wait for 20 ns; assert s_a_out = "0001" and s_b_out = "1111000" and s_y_out = "01101001" report "10 failed"; 
        s_a_in <= "0001"; s_b_in <= "1111000"; s_y_in <= "1101001"; wait for 20 ns; assert s_a_out = "0000" and s_b_out = "1110000" and s_y_out = "11100001" report "11 failed"; 
        report "Finished Test 3 successfuly";
        report "Carry Save testbench finished";
        wait;       
    end process;    

end behavioural;