library ieee;
use ieee.std_logic_1164.all;

entity m9_cordic is
    port (reset : in std_logic;
          clk : in std_logic;
          valid_in : in std_logic;
          theta : in std_logic_vector(31 downto 0);
          valid_out : out std_logic;
          cos_theta : out std_logic_vector(31 downto 0);
          sin_theta : out std_logic_vector(31 downto 0));
end m9_cordic;

architecture mealy_a of m9_cordic is
    component m9_ce is
        port (m : in std_logic;
          sigma : in std_logic;
          i : in std_logic_vector(4 downto 0);
          x_in, y_in, z_in : in std_logic_vector(31 downto 0);
          x_out, y_out, z_out : out std_logic_vector(31 downto 0));
    end component;


    type state_type is (idle, do, fin);
    signal current_state, next_state : state_type;
    signal z, x, y : std_logic_vector(31 downto 0);
    signal sigma : std_logic;
    signal s_x_in, s_y_in, s_z_in, s_x_out, s_y_out, s_z_out : std_logic_vector(31 downto 0);
    signal s_sigma : std_logic;
    signal s_i : std_logic_vector(4 downto 0);
    
    type array26_32 is array(1 to 26) of std_logic_vector(31 downto 0);
    type array26_5 is array(1 to 26) of std_logic_vector(4 downto 0);
    signal a_z, a_x, a_y : array26_32;
    signal a_i : array26_5;

    variable n : integer;

begin

    uut: m9_ce
        port map(m => '0', sigma => s_sigma, i => s_i, x_in => s_x_in, y_in => s_y_in, z_in => s_z_in, x_out => s_x_out, y_out => s_y_out, z_out => s_z_out);

    Q: process(clk, reset)
    begin
        if reset='1' then
            current_state <= idle;
        elsif clk'event and clk='1' then
            current_state <= next_state;
        end if;
    end process Q;

    f: process(current_state, z, n, valid_in)
    begin
        case current_state is
            when idle =>
                if valid_in = '0' then
                    next_state <= idle;
                else
                    next_state <= do;
                end if;
            when do =>
                if n <= 24 then
                    next_state <= do;
                else
                    next_state <= fin;
                end if;
            when fin =>
                next_state <= idle;
        end case;
    end process f;  
    
    g: process(current_state) 
    begin
        case current_state is
            when idle =>
                n := 1;
                a_x(n) <= "00000001"&"000000000000000000000000";
                a_y(n) <= "00000000"&"000000000000000000000000";
                a_z(n) <= theta;
                valid_out <= '0';
            when do =>
                s_sigma <= a_z(n)(31);
                s_i <= std_logic_vector(n-1);
                s_x_in <= a_x(n);
                s_y_in <= a_y(n);
                s_z_in <= a_z(n);
                n := n+1;
                a_x(n) <= s_x_out;
                a_y(n) <= s_y_out;
                a_z(n) <= s_z_out;
            when fin =>
                cos_theta <= a_x(n);
                sin_theta <= a_y(n);
                valid_out <= '1';
        end case;
    end process g;

end mealy_a;