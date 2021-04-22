--  
--  M9 Uebung 1.2 - Aufgabe 1 - Carry Select mit Verzoegerung
-- 

library ieee;
use ieee.std_logic_1164.all;

entity m9_carry_select_delayed is
    generic (tpd      :  time := 100 ns);
    port (cin : in std_logic;
          a, b : in std_logic;
          sum : out std_logic;
          cout : out std_logic);
    end m9_carry_select_delayed;

    architecture gatelevel of m9_carry_select_delayed is
        component m9_fulladd
            port (a, b, cin : in  std_logic;
                  sum, cout : out std_logic);
        end component;

        signal sum1, sum2, cout1, cout2 : std_logic;
        signal a_d, b_d, sum_d, cout_d : std_logic;

        begin

            a_d <= transport a after tpd;
            b_d <= transport b after tpd;

            full_add_one : m9_fulladd
            port map(a => a_d, b => b_d, cin => '0', sum => sum1, cout => cout1);
            full_add_two : m9_fulladd
            port map(a => a_d, b => b_d, cin => '1', sum => sum2, cout => cout2);

            sum_d <= sum1 when (cin = '0') else sum2;
            cout_d <= cout1 when (cin = '0') else cout2;

            sum <= transport sum_d after tpd;
            cout <= transport cout_d after tpd;

    end gatelevel;