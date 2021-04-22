--  
--  M9 Uebung 1 - Aufgabe 1 - Adder
-- 

library ieee;
use ieee.std_logic_1164.all;

entity m9_adder is
    generic (width : positive := 5);
    port (cin : in std_logic;
          a, b : in std_logic_vector (width - 1 downto 0);
          sum : out std_logic_vector (width - 1 downto 0);
          cout : out std_logic);
    end m9_adder;

    architecture gatelevel of m9_adder is
        component m9_carry_select 
            port (cin : in std_logic;
                  a, b : in std_logic;
                  sum : out std_logic;
                  cout : out std_logic);
            end component;

        signal carry : std_logic_vector (width downto 0);

    begin
        carry(0) <= cin;
        GEN_ADD : 
        for i in 0 to width - 1 generate
            CARRY_SELECT_X : m9_carry_select
                port map(a => a(i), b => b(i), cin => carry(i), sum => sum(i), cout => carry(i+1));
        end generate;
        cout <= carry(width);
    end gatelevel;