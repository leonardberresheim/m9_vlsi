--  
--  M9 Uebung 1 - Aufgabe 1 - Carry Select
-- 

library ieee;
use ieee.std_logic_1164.all;

entity m9_carry_select is
    port (cin : in std_logic;
          a, b : in std_logic;
          sum : out std_logic;
          cout : out std_logic);
    end m9_carry_select;


    architecture gatelevel of m9_carry_select is
        component m9_fulladd   
            port (a, b, cin        : in  std_logic;
                  sum, cout  : out std_logic);
        end component;

        signal sum1, sum2, cout1, cout2 : std_logic;

        begin
            full_add_one : m9_fulladd
                port map(a => a, b => b, cin => '0', sum => sum1, cout => cout1);
            full_add_two : m9_fulladd
                port map(a => a, b => b, cin => '1', sum => sum2, cout => cout2);

            sum <= sum1 when (cin = '0') else sum2;
            cout <= cout1 when (cin = '0') else cout2;

    end gatelevel;