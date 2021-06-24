library ieee;
use ieee.std_logic_1164.all;

entity m9_ce is
    port (m : in std_logic;
          sigma : in std_logic;
          i : in std_logic_vector(4 downto 0);
          x_in, y_in, z_in : in std_logic_vector(31 downto 0);
          x_out, y_out, z_out : out std_logic_vector(31 downto 0));
end m9_ce;

architecture behaviour of m9_ce is
    component m9_barrel32
        port (x : in std_logic_vector(31 downto 0);
              pos : in std_logic_vector(4 downto 0);
              y : out std_logic_vector(31 downto 0));
    end component;

    component m9_addsub32
        port (a, b : in std_logic_vector(31 downto 0);
              ans : in std_logic;
              y : out std_logic_vector(31 downto 0));
    end component;

    component m9_artan_rom
        port (i : in std_logic_vector(4 downto 0);
              d : out std_logic_vector(31 downto 0));
    end component;

    signal x_shift_out, y_shift_out, x_addsub_out, y_add_sub_out, z_add_sub_out, rom_out : std_logic_vector(31 downto 0);
    signal not_sigma : std_logic;
begin
    not_sigma <= not sigma;
    rom : m9_artan_rom
        port map(i => i, d => rom_out);
    
    x_shift : m9_barrel32
        port map(x => x_in, pos => i, y => x_shift_out);

    y_shift : m9_barrel32
        port map(x => y_in, pos => i, y => y_shift_out);

    x_addsub : m9_addsub32
        port map(a => x_in, b => y_shift_out, ans => (not_sigma), y => x_out);

    y_addsub : m9_addsub32
        port map(a => y_in, b => x_shift_out, ans => sigma, y => y_out);

    z_addsub : m9_addsub32
        port map(a => z_in, b => rom_out, ans => (not_sigma), y => z_out);
end behaviour;