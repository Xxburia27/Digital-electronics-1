library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity LED_bargraph is
Port ( 
    clk          : in  std_logic;
    reset        : in  std_logic;
    led_o        : out std_logic_vector(4 downto 0);
    echo_count_i : in unsigned(16 - 1 downto 0)
);
end LED_bargraph;

architecture Behavioral of LED_bargraph is

signal s_echo_count : unsigned(16-1 downto 0);
signal s_en         : std_logic;

begin

clk_en0 : entity work.clock_enable
        generic map(
           g_MAX =>  100      
        )
        port map(
            clk   => clk,
            reset => reset,
            ce_o  => s_en
        );

p_decide : process(clk)
begin

 if(echo_count_i > 0 and echo_count_i < 1166) then 
     led_o (4 downto 0 ) <= "11111";
 elsif(echo_count_i > 1166 and echo_count_i < 2332)then 
    led_o (4 downto 0 ) <= "11110"; 
 elsif(echo_count_i > 2332 and echo_count_i < 3499) then
    led_o (4 downto 0 ) <= "11100";
 elsif(echo_count_i > 3499 and echo_count_i < 4664)then 
    led_o (4 downto 0 ) <= "11000";
 elsif(echo_count_i > 4664 and echo_count_i < 5831)then   
    led_o (4 downto 0 ) <= "10000";
 else   
    led_o (4 downto 0 ) <= "00000";
 end if;
end process p_decide; 
end Behavioral;
