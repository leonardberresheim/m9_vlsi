library ieee;
use ieee.std_logic_1164.all;

entity m9_cordic_tb is
end m9_cordic_tb;

architecture behavioural of m9_cordic_tb is

    component m9_cordic is
        port (reset : in std_logic;
          clk : in std_logic;
          valid_in : in std_logic;
          theta : in std_logic_vector(31 downto 0);
          valid_out : out std_logic;
          cos_theta : out std_logic_vector(31 downto 0);
          sin_theta : out std_logic_vector(31 downto 0));
    end component;

    signal clk, reset : std_logic := '0';
    signal theta, cos_theta, sin_theta : std_logic_vector(31 downto 0);
    signal valid_in, valid_out : std_logic := '0';
begin
    uut: m9_cordic
        port map(reset => reset, clk => clk, valid_in => valid_in, theta => theta, valid_out => valid_out, cos_theta => cos_theta, sin_theta => sin_theta);

    CLOCK:
    clk <=  '1' after 1 ns when clk = '0' else
            '0' after 1 ns when clk = '1';
    
    stim_proc: process
    begin

        reset <= '1';
        wait for 20 ns;
        reset <= '0';
            -- 90 grad
        theta <= "01011010000000000000000000000000";
        wait for 20 ns;
        valid_in <= '1';
        wait for 100 ns;
        assert valid_out = '1' report "valid out failed";
        assert cos_theta = "00000000000000000000000000000001" report "cos failed";
        assert sin_theta = "00000001101001011001001000011000" report "sin failed";
        
        

        report "m9_cordic testbench finished!";
        wait;    

    end process;

end behavioural;