library ieee;
use ieee.std_logic_1164.all;

entity m9_adder_tb is
    generic (width : positive := 5);
end m9_adder_tb;

architecture behavior of m9_adder_tb is
    component m9_adder is
        
        port (cin : in std_logic;
          a, b : in std_logic_vector (width - 1 downto 0);
          sum : out std_logic_vector (width - 1 downto 0);
          cout : out std_logic);
    end component;

    signal a,b,sum  : std_logic_vector(width - 1 downto 0);
    signal cout, cin : std_logic;

begin
    uut: m9_adder port map (
        cin => cin,
        a => a,
        b => b,
        sum => sum,
        cout => cout
    );

    stim_proc: process
    begin
        a <= "00000"; b <= "00000"; cin <= '0'; wait for 10 ns; assert sum = "00000" and cout = '0' report "0 failed";
        a <= "00000"; b <= "00001"; cin <= '0'; wait for 10 ns; assert sum = "00001" and cout = '0' report "1 failed";
        a <= "00101"; b <= "00101"; cin <= '0'; wait for 10 ns; assert sum = "01010" and cout = '0' report "2 failed";
        a <= "10000"; b <= "10000"; cin <= '0'; wait for 10 ns; assert sum = "00000" and cout = '1' report "3 failed";
        a <= "00001"; b <= "11111"; cin <= '0'; wait for 10 ns; assert sum = "00000" and cout = '1' report "4 failed";
        a <= "01100"; b <= "01001"; cin <= '0'; wait for 10 ns; assert sum = "10101" and cout = '0' report "5 failed";
        a <= "00101"; b <= "00001"; cin <= '1'; wait for 10 ns; assert sum = "00111" and cout = '0' report "6 failed";
        a <= "11111"; b <= "11111"; cin <= '1'; wait for 10 ns; assert sum = "11111" and cout = '1' report "7 failed";
        

        report "Full adder testbench finished";
        wait;
    end process;
end;