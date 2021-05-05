--  
--  M9 Uebung 2 - Aufgabe 1.1 - Carry Save Addierer
-- 


library ieee;
use ieee.std_logic_1164.all;

entity m9_csa is
    generic (width : positive := 5);
    port (a, b, c : in  std_logic_vector (width - 1 downto 0);
            s       : out std_logic_vector (width - 1 downto 0);
            cout    : out std_logic);
end m9_csa;

architecture gatelevel of m9_csa is
    component m9_fulladd
        port (cin : in std_logic;
              a, b : in std_logic;
              sum : out std_logic;
              cout : out std_logic);
        end component;

    signal c_fa : std_logic_vector(width - 1 downto 0);
    signal s_fa : std_logic_vector(width downto 0);

    signal s_rca : std_logic_vector(width - 1 downto 0);

    signal cout_rca : std_logic_vector(width downto 0);

begin

    s_fa(width) <= '0';
    s_rca(0) <= s_fa(0);
    cout_rca(0) <= '0';

    RCA_GEN :
    for i in 0 to width - 1 generate
        RIPPLE_CARRY_X : m9_fulladd
            port map(a=>c_fa(i), b=>s_fa(i+1), sum=>s_fa(i+1), cout=>cout_rca(i+1), cin=>cout_rca(i));
    end generate;

    FA_GEN:
    for i in 0 to width - 1 generate
        FULLADD_X : m9_fulladd
            port map(a=>a(i), b=>b(i), cin=>c(i), cout=>c_fa(i), sum=>s_fa(i));
    end generate;

    s <= s_fa(width - 1 downto 0);
    cout <= s_fa(width);

end gatelevel;