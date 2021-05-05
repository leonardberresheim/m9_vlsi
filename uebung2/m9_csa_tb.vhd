library ieee;
use ieee.std_logic_1164.all;

entity m9_csa_tb is
    generic (width : positive := 5);
end m9_csa_tb;

architecture gatelevel of m9_csa_tb is
    component m9_csa is 
        port (a, b, c : in std_logic_vector (width - 1 downto 0);
                s : out std_logic_vector (width - 1 downto 0);
                cout : out std_logic);
    end component;

    signal a, b, c, s : std_logic_vector(width - 1 downto 0);
    signal cout : std_logic;

begin
    uut: m9_csa port map (
        a => a,
        b => b,
        c => c,
        s => s,
        cout => cout
    );

    stim_proc: process
    begin
        a <= "00000"; b <= "00000"; c <= "00000"; wait for 10 ns; assert s = "00000" and cout = '0' report "0 failed";
        a <= "00000"; b <= "00001"; c <= "00000"; wait for 10 ns; assert s = "00001" and cout = '0' report "1 failed";
        a <= "00101"; b <= "00101"; c <= "00000"; wait for 10 ns; assert s = "01010" and cout = '0' report "2 failed";
        a <= "10000"; b <= "10000"; c <= "00000"; wait for 10 ns; assert s = "00000" and cout = '1' report "3 failed";
        a <= "00001"; b <= "11111"; c <= "00000"; wait for 10 ns; assert s = "00000" and cout = '1' report "4 failed";
        a <= "01100"; b <= "01001"; c <= "00000"; wait for 10 ns; assert s = "10101" and cout = '0' report "5 failed";
        a <= "00101"; b <= "00001"; c <= "00001"; wait for 10 ns; assert s = "00111" and cout = '0' report "6 failed";
        a <= "11111"; b <= "11111"; c <= "00001"; wait for 10 ns; assert s = "11111" and cout = '1' report "7 failed";
        
        report "Carry Save testbench finished";
        wait;
    end process;
end;