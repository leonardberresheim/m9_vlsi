library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;


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

    signal s_sigma : std_logic;
    signal i : std_logic_vector(4 downto 0);

    signal x_0, y_0, z_0, x_n, y_n, z_n : std_logic_vector(31 downto 0);
    
    
    signal reg_x_in, reg_y_in, reg_z_in, reg_x_out, reg_y_out, reg_z_out : std_logic_vector(31 downto 0);
    
    signal s_state : std_logic_vector(1 downto 0);

    signal s_valid_out : std_logic := '0';
begin
    ---------------------------------------------------
    -- Register --
    ---------------------------------------------------
    registerX: process(clk)
        variable tmp: std_logic_vector(31 downto 0);
    begin
        if(clk = '1' and clk'event and s_valid_out = '0') then
            if(reset = '1') then
                tmp:=(others => '0') ;
            else
                tmp:= reg_x_in;
            end if;
        end if;
        reg_x_out <= tmp;
    end process;
    registerY: process(clk)
        variable tmp: std_logic_vector(31 downto 0);
    begin
        if(clk = '1' and clk'event and s_valid_out = '0') then
            if(reset = '1') then
                tmp:=(others => '0') ;
            else
                tmp:= reg_y_in;
            end if;
        end if;
        reg_y_out <= tmp;
    end process;
    registerZ: process(clk)
        variable tmp: std_logic_vector(31 downto 0);
    begin
        if(clk = '1' and clk'event and s_valid_out = '0') then
            if(reset = '1') then
                tmp:=(others => '0') ;
            else
                tmp:= reg_z_in;
            end if;
        end if;
        reg_z_out <= tmp;
    end process;
    ---------------------------------------------------
    -- Multiplexer
    ---------------------------------------------------
    reg_x_in <= x_0 when i = "11111" else x_n;
    reg_y_in <= y_0 when i = "11111" else y_n;
    reg_z_in <= z_0 when i = "11111" else z_n;
    ---------------------------------------------------
    -- CORDIC
    ---------------------------------------------------           
    uut: m9_ce
        port map(m => '0', sigma => s_sigma, i => i, x_in => reg_x_out, y_in => reg_y_out, z_in => reg_z_out, x_out => x_n, y_out => y_n, z_out => z_n);

    ---------------------------------------------------
    -- Automat
    ---------------------------------------------------
    Q: process(clk, reset)
    begin
        if reset='1' then
            current_state <= idle;
        elsif clk'event and clk='1' then
            current_state <= next_state;
        end if;
    end process Q;

    f: process(current_state, i, valid_in)
    begin
        case current_state is
            when idle =>
                if valid_in = '0' then
                    next_state <= idle;
                else
                    next_state <= do;
                end if;
                s_state <= "00";
            when do =>
                if i = "10111" then
                    next_state <= fin;
                    s_state <= "10";
                else
                    next_state <= do;
                    s_state <= "01";
                end if;
            when fin =>
                next_state <= fin;
                s_state <= "11";
        end case;
    end process f;  
    
    g: process(current_state, clk) 
    begin
        if(clk = '1' and clk'event) then
            case current_state is
                when idle =>
                    i <= "11111";
                    cos_theta <= (others => '0');
                    sin_theta <= (others => '0');
                    s_valid_out <= '0';
                when do =>
                    i <= std_logic_vector( unsigned(i) + 1 );
                when fin =>
                    cos_theta <= x_n;
                    sin_theta <= y_n;
                    s_valid_out <= '1';
            end case;
        end if;
    end process g;
    ---------------------------------------------------

    ---------------------------------------------------
    x_0 <= "00000001"&"000000000000000000000000";
    y_0 <= "00000000"&"000000000000000000000000";
    z_0 <= theta;
    valid_out <= s_valid_out;
    s_sigma <= reg_z_out(31);
end mealy_a;