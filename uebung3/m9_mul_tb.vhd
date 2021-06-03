library ieee;
use ieee.std_logic_1164.all;

entity m9_mul_tb is
    generic (width : positive := 4);
end m9_mul_tb;

architecture behavioural of m9_mul_tb is
    component m9_mul
        generic (width : positive := 4);
        port (clk, reset : in std_logic;
              a, b : in std_logic_vector(width - 1 downto 0);
              y : out std_logic_vector((2 * width) - 1 downto 0));
    end component;
    signal s_a, s_b : std_logic_vector(width - 1 downto 0);
    signal s_y : std_logic_vector((2 * width) - 1 downto 0);
    signal reset: std_logic;
    signal clk : std_logic := '0';
begin

    uut : m9_mul
        port map(clk => clk,
                reset => reset,
                a => s_a,
                b => s_b, 
                y => s_y);

    CLOCK:
    clk <=  '1' after 1 ns when clk = '0' else
            '0' after 1 ns when clk = '1'; 

    stim_proc: process
    begin
        reset <= '1'; wait for 1 ns; 
        reset <= '0'; wait for 1 ns; 
        s_a <= "1010"; s_b <= "0101"; wait for 50 ns; assert s_y = "00110010" report "0 failed";
        s_a <= "1101"; s_b <= "1010"; wait for 50 ns; assert s_y = "10000010" report "1 failed";
        s_a <= "1111"; s_b <= "1111"; wait for 50 ns; assert s_y = "11100001" report "2 failed";
        report "Mul testbench finished";
        wait;
    end process;
end behavioural;