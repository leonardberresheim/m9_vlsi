library ieee;
use ieee.std_logic_1164.all;

entity m9_barrel32_tb is
end m9_barrel32_tb;

architecture behavioural of m9_barrel32_tb is

    component m9_barrel32 is
        port (x : in std_logic_vector(31 downto 0);
              pos : in std_logic_vector(4 downto 0);
              y : out std_logic_vector(31 downto 0));
    end component;
    signal x,y : std_logic_vector(31 downto 0);
    signal pos : std_logic_vector(4 downto 0);
begin
    uut: m9_barrel32
        port map(x => x, pos => pos, y => y);

    stim_proc: process
    begin

        x <= "00000000000000000000000000000001"; pos <= "00001"; wait for 20 ns; assert y = "10000000000000000000000000000000" report "0 failed"; 
        x <= "00000000000000000000000000000001"; pos <= "00100"; wait for 20 ns; assert y = "00010000000000000000000000000000" report "1 failed"; 
        x <= "00000000000000000000000000000001"; pos <= "11111"; wait for 20 ns; assert y = "00000000000000000000000000000010" report "2 failed"; 


        report "Barrel32 testbench finished";
        wait;    

    end process;

end behavioural;