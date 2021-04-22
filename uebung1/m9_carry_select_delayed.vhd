--  
--  M9 Uebung 1.2 - Aufgabe 1 - Carry Select mit Verzoegerung
-- 

library ieee;
use ieee.std_logic_1164.all;

entity m9_carry_select_delayed is
<<<<<<< HEAD
    generic (tpd      :  time := 100 ns);
=======
    generic (delay_cycles : positive := 4);
>>>>>>> ffa06a2bc4c37d67f984e92c9589f601473cb248
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
<<<<<<< HEAD
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
=======

        signal a_vec_d, b_vec_d, sum_vec_d, cout_vec_d: std_logic_vector( delay_cycles - 1 downto 0 )

        signal a_d, b_d, sum_d, cout_d : std_logic;
        

        begin

            input_delay : process(clk)
            begin
                if rising_edge(clk) then
                    a_vec_d <= a_vec_d(store'high-1 downto 0) & a;
                    b_vec_d <= b_vec_d(store'high-1 downto 0) & b;

                    a_d <= a_vec_d(a_vec_d'high);
                    b_d <= b_vec_d(b_vec_d'high);
                end if;
            end process input_delay
            
            process
            begin
                wait on a_d, b_d;

                full_add_one : m9_fulladd
                port map(a => a_d, b => b_d, cin => '0', sum => sum1, cout => cout1);
                full_add_two : m9_fulladd
                port map(a => a_d, b => b_d, cin => '1', sum => sum2, cout => cout2);

                sum_d <= sum1 when (cin = '0') else sum2;
                cout_d <= cout1 when (cin = '0') else cout2;
            end process

            output_delay : process(clk)
            begin
                wait on sum_d, cout_d;

                if rising_edge(clk) then
                    sum_vec_d <= sum_vec_d(store'high-1 downto 0) & sum;
                    cout_vec_d <= cout_vec_d(store'high-1 downto 0) & cout;

                    sum <= sum_vec_d(sum_vec_d'high);
                    cout <= cout_vec_d(cout_vec_d'high);
                end if;
            end process output_delay
>>>>>>> ffa06a2bc4c37d67f984e92c9589f601473cb248

    end gatelevel;