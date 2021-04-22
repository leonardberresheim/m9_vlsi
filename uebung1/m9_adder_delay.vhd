--  
--  M9 Uebung 1 - Aufgabe 1.2 - Addierer Delay
-- 

library ieee;
use ieee.std_logic_1164.all;

entity m9_adder_delay is
    generic(
        width : positive := 5;
        tpd : time := 100 ns);
    port (cin : in std_logic;
          a, b : in std_logic_vector (width - 1 downto 0);
          sum : out std_logic_vector (width - 1 downto 0);
          cout : out std_logic);
    end m9_adder_delay;

    architecture gatelevel of m9_adder_delay is
        component m9_carry_select 
            port (cin : in std_logic;
                  a, b : in std_logic;
                  sum : out std_logic;
                  cout : out std_logic);
            end component;

        signal carry : std_logic_vector (width downto 0);
        signal a_d, b_d, sum_d : std_logic_vector (width - 1 downto 0);

    begin

        a_d <= transport a after tpd;
        b_d <= transport b after tpd;

        carry(0) <= cin;
        GEN_ADD : 
        for i in 0 to width - 1 generate
            CARRY_SELECT_X : m9_carry_select
                port map(a => a_d(i), b => b_d(i), cin => carry(i), sum => sum_d(i), cout => carry(i+1));
        end generate;

        sum <= transport sum_d after tpd;
        cout <= transport carry(width) after tpd;


    end gatelevel;