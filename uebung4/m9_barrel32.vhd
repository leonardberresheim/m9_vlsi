library ieee;
use ieee.std_logic_1164.all;

entity m9_barrel32 is
    port (x : in std_logic_vector(31 downto 0);
          pos : in std_logic_vector(4 downto 0);
          y : out std_logic_vector(31 downto 0));
end m9_barrel32;

architecture behavioural of m9_barrel32 is

begin
    with pos select y <=
    x when "00000",
    x(0) & x(31 downto 1) when "00001",
    x(1 downto 0) & x(31 downto 2) when "00010",
    x(2 downto 0) & x(31 downto 3) when "00011",
    x(3 downto 0) & x(31 downto 4) when "00100",
    x(4 downto 0) & x(31 downto 5) when "00101",
    x(5 downto 0) & x(31 downto 6) when "00110",
    x(6 downto 0) & x(31 downto 7) when "00111",
    x(7 downto 0) & x(31 downto 8) when "01000",
    x(8 downto 0) & x(31 downto 9) when "01001",
    x(9 downto 0) & x(31 downto 10) when "01010",
    x(10 downto 0) & x(31 downto 11) when "01011",
    x(11 downto 0) & x(31 downto 12) when "01100",
    x(12 downto 0) & x(31 downto 13) when "01101",
    x(13 downto 0) & x(31 downto 14) when "01110",
    x(14 downto 0) & x(31 downto 15) when "01111",
    x(15 downto 0) & x(31 downto 16) when "10000",
    x(16 downto 0) & x(31 downto 17) when "10001",
    x(17 downto 0) & x(31 downto 18) when "10010",
    x(18 downto 0) & x(31 downto 19) when "10011",
    x(19 downto 0) & x(31 downto 20) when "10100",
    x(20 downto 0) & x(31 downto 21) when "10101",
    x(21 downto 0) & x(31 downto 22) when "10110",
    x(22 downto 0) & x(31 downto 23) when "10111",
    x(23 downto 0) & x(31 downto 24) when "11000",
    x(24 downto 0) & x(31 downto 25) when "11001",
    x(25 downto 0) & x(31 downto 26) when "11010",
    x(26 downto 0) & x(31 downto 27) when "11011",
    x(27 downto 0) & x(31 downto 28) when "11100",
    x(28 downto 0) & x(31 downto 29) when "11101",
    x(29 downto 0) & x(31 downto 30) when "11110",
    x(30 downto 0) & x(31) when others;

end behavioural;