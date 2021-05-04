library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_LED_bargraph is

end tb_LED_bargraph;

architecture Behavioral of tb_LED_bargraph is
    constant c_CLK_4kHZ_PERIOD : time := 10ns;
   signal s_clk          : std_logic;
   signal s_reset        : std_logic;
   signal s_led_o        : std_logic_vector(4 downto 0);
   signal s_echo_count_i : unsigned(16 - 1 downto 0);

begin

uut_ledky : entity work.LED_bargraph
    port map(
        led_o           => s_led_o,
        reset           => s_reset,
        clk             => s_clk,
        echo_count_i    => s_echo_count_i
        );

p_clk_gen : process
    begin
        while now < 200 ms loop   -- 10 usec of simulation
            s_clk <= '0';
            wait for c_CLK_4kHZ_PERIOD / 2;
            s_clk <= '1';
            wait for c_CLK_4kHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

p_led : process
begin
    s_echo_count_i <= b"0000_1011_1011_1000";--count = 3000
    wait for 25us;                           -- led = (11100) - 3 LEDs are ON
    assert (s_led_o = "11100") report "Error for count 3000" severity error;  
     
    s_echo_count_i <= b"0001_0011_1000_1000";--count = 5000
    wait for 25us;                           -- led = (10000) - 1 LEDs are ON
    assert (s_led_o = "10000") report "Error for count 5000" severity error;
    
    s_echo_count_i <= b"0000_0111_1101_0000";--count = 2000
    wait for 25us;                           -- led = (11110) - 4 LEDs are ON
    assert (s_led_o = "11110") report "Error for count 2000" severity error;
    
    s_echo_count_i <= b"0000_0000_0000_1111";-- count = 15
    wait for 25us;                           -- led = (11111) - 5 LEDs are ON
    assert (s_led_o = "11111") report "Error for count 15" severity error;
    
    s_echo_count_i <= b"0000_1111_1010_0000";-- count = 4000
    wait for 25us;                           -- led = (11000) - 2 LEDs are ON
    assert (s_led_o = "11000") report "Error for count 4000" severity error;
    
    s_echo_count_i <= b"0000_0000_0000_0000";-- count = 0
    wait ;                                   -- led = (00000) - 0 LEDs are ON
    assert (s_led_o = "00000") report "Error for count 0" severity error;
    end process p_led;
end Behavioral;
