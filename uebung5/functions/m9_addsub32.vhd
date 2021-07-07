library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity m9_addsub32 is
    port (a, b : in std_logic_vector(31 downto 0);
          ans : in std_logic;
          y : out std_logic_vector(31 downto 0));
end m9_addsub32;


architecture structure of m9_addsub32 is
    component m9_csa is 
        generic (width : positive := 32);
        port (a, b, c : in std_logic_vector (width - 1 downto 0);
                s : out std_logic_vector (width downto 0);
                cout : out std_logic);
    end component;

    signal csa_a, csa_b, csa_cin : std_logic_vector (31 downto 0);
    signal csa_s : std_logic_vector (32 downto 0);
    signal csa_cout : std_logic;

begin
    csa : m9_csa
        port map(a => csa_a, b => csa_b, c => csa_cin, s => csa_s, cout => csa_cout);

    csa_a <= a;
    csa_b <= b when ans = '1' else
            not b;
    csa_cin <= (others => '0') when ans = '1' else
            "00000000000000000000000000000001";
    y <= csa_s(31 downto 0);

end structure;