


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity top is
  Port (
           CLK100MHZ : in STD_LOGIC;    --clock
           sw   : in std_logic_vector(0 downto 0);         -- reset switch
           --outputs
           jd : out STD_LOGIC_VECTOR (4 downto 0);  --LEDs
           ja : out std_logic_vector (1 downto 0);  -- ja(0) -> trigger_o;  ja(1) -> sound
           --input (echo_i)
           jc : in std_logic_vector(0 downto 0)     
   );
end top;

architecture Behavioral of top is

signal s_echo_count : unsigned(16 - 1 downto 0);

begin

    state_machine : entity work.state_machine
        port map(
            clk     => CLK100MHZ,
            reset   => sw(0),
            echo_i  => jc,      
            echo_count_o => s_echo_count,
            trigger_o => ja(0)
        );
        
        
     pwm : entity work.pwm
        port map(
           sound  => ja(1),  
           clock  => CLK100MHZ,
           reset  => sw(0),  
           echo_count_i => s_echo_count
        );

    LED_bargraph : entity work.LED_bargraph
        port map(
           clk          => CLK100MHZ, 
           reset        => sw(0), 
           led_o        => jd(4 downto 0),
           echo_count_i => s_echo_count
        );

end Behavioral;
