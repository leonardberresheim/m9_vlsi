library ieee;
use ieee.std_logic_1164.all;

entity m9_ce_tb is
end m9_ce_tb;

architecture behavioural of m9_ce_tb is

    component m9_ce is
        port (m : in std_logic;
          sigma : in std_logic;
          i : in std_logic_vector(4 downto 0);
          x_in, y_in, z_in : in std_logic_vector(31 downto 0);
          x_out, y_out, z_out : out std_logic_vector(31 downto 0));
    end component;

    signal x_in, y_in, z_in, x_out, y_out, z_out : std_logic_vector(31 downto 0);
    signal i : std_logic_vector(4 downto 0);
    signal m, sigma : std_logic;
begin
    uut: m9_ce
        port map(m => m, sigma => sigma, i => i, x_in => x_in, y_in => y_in, z_in => z_in, x_out => x_out, y_out => y_out, z_out => z_out);

    stim_proc: process
    begin
        m <= '0';
        sigma <= '0'; i <= "00000"; x_in <= "00000001000000000000000000000000"; y_in <= "00000000000000000000000000000000"; z_in <= "01011010000000000000000000000000"; 
        wait for 20 ns;
        assert x_out = "00000001000000000000000000000000" and y_out = "00000001000000000000000000000000" and z_out = "00101101000000000000000000000000" report "1 failed";

        sigma <= '0'; i <= "00001"; x_in <= "00000001000000000000000000000000"; y_in <= "00000001000000000000000000000000"; z_in <= "00101101000000000000000000000000"; 
        wait for 20 ns;
        assert x_out = "00000000100000000000000000000000" report "2 - x failed";
        assert y_out = "00000001100000000000000000000000" report "2 - y failed";
        assert z_out = "00010010011011110101100011001111" report "2 - z failed";

        sigma <= '0'; i <= "00010"; x_in <= "00000000100000000000000000000000"; y_in <= "00000001100000000000000000000000"; z_in <= "00010010011011110101100011001111"; 
        wait for 20 ns;
        assert x_out = "00000000001000000000000000000000" report "3 - x failed";
        assert y_out = "00000001101000000000000000000000" report "3 - y failed";
        assert z_out = "00000100011001100001000110001111" report "3 - z failed";

        sigma <= '0'; i <= "00011"; x_in <= "00000000001000000000000000000000"; y_in <= "00000001101000000000000000000000"; z_in <= "00000100011001100001000110010000"; 
        wait for 20 ns;
        assert x_out = "11111111111011000000000000000000" report "4 - x failed";
        assert y_out = "00000001101001000000000000000000" report "4 - y failed";
        assert z_out = "11111101010001100001000001111110" report "4 - z failed";

        sigma <= '1'; i <= "00100"; x_in <= "11111111111011000000000000000000"; y_in <= "00000001101001000000000000000000"; z_in <= "11111101010001100001000001111110"; 
        wait for 20 ns;
        assert x_out = "00000000000001100100000000000000" report "5 - x failed";
        assert y_out = "00000001101001010100000000000000" report "5 - y failed";
        assert z_out = "00000000110110011001101100100100" report "5 - z failed";

        sigma <= '0'; i <= "00101"; x_in <= "00000000000001100100000000000000"; y_in <= "00000001101001010100000000000000"; z_in <= "00000000110110011001101100100100"; 
        wait for 20 ns;
        assert x_out = "11111111111110010001011000000000" report "6 - x failed";
        assert y_out = "00000001101001010111001000000000" report "6 - y failed";
        assert z_out = "11111111000011110110001110010000" report "6 - z failed";
        

        report "m9_ce testbench finished!";
        wait;    

    end process;

end behavioural;