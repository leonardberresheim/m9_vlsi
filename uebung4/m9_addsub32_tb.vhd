library ieee;
use ieee.std_logic_1164.all;

entity m9_addsub32_tb is
end m9_addsub32_tb;

architecture behavioural of m9_addsub32_tb is
    component m9_addsub32
        port (a, b : in std_logic_vector(31 downto 0);
              ans : in std_logic;
              y : out std_logic_vector(31 downto 0));
    end component;
    signal a, b, y : std_logic_vector(31 downto 0);
    signal ans : std_logic;
begin
    uut : m9_addsub32
        port map(a => a, b => b, ans => ans, y => y);

    stim_proc: process
    begin
        -- 1 + 0 = 1
        a <= "00000000000000000000000000000001"; b <= "00000000000000000000000000000000"; ans <= '1'; wait for 10 ns; assert y = "00000000000000000000000000000001" report "0 failed";
        -- 1 - 1 = 0
        a <= "00000000000000000000000000000001"; b <= "00000000000000000000000000000001"; ans <= '0'; wait for 10 ns; assert y = "00000000000000000000000000000000" report "1 failed";
        -- 0 - 1 = -1
        a <= "00000000000000000000000000000000"; b <= "00000000000000000000000000000001"; ans <= '0'; wait for 10 ns; assert y = "11111111111111111111111111111111" report "2 failed";
        -- -8 + 4 = - 4
        a <= "11111111111111111111111111111000"; b <= "00000000000000000000000000000100"; ans <= '1'; wait for 10 ns; assert y = "11111111111111111111111111111100" report "3 failed";
        report "Add sub 32 testbench finished";
        wait;
    end process;


end behavioural;