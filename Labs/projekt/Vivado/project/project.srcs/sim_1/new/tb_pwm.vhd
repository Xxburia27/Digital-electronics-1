library IEEE;
use IEEE.STD_LOGIC_1164.ALL;




use IEEE.NUMERIC_STD.ALL;



entity tb_pwm is

end tb_pwm;

architecture Behavioral of tb_pwm is

    constant c_CLK_100MHZ_PERIOD : time := 10ns;

    
    signal s_sound : std_logic;
    signal s_clock : std_logic;
    signal s_reset : std_logic;
    signal s_echo_count_i : unsigned(16-1 downto 0);
   

begin

uut : entity work.pwm

port map(  
           sound    => s_sound,
           clock    => s_clock,
           echo_count_i => s_echo_count_i,
           reset    => s_reset
);
p_clk_gen : process
begin
    while now < 100000 us loop
        s_clock <= '0';
        wait for c_CLK_100MHZ_PERIOD / 2;
        s_clock <= '1';
        wait for c_CLK_100MHZ_PERIOD / 2;
    end loop;
    wait;
end process p_clk_gen;    
                
p_stimulus : process
begin
    s_reset <= '1';
    wait for 300 us;
    
    s_reset<= '0';
    wait for 4ms ;
    
    s_echo_count_i <= b"0000_0000_0011_0111";
    wait for 5ms;

    s_echo_count_i <= b"0000_0000_0000_1111";
    wait for 5ms;

    s_echo_count_i <= b"0000_0000_0101_0100";
    wait for 5ms;
    
    s_echo_count_i <= b"0000_0000_0000_0110";
    wait for 5ms;
    
    s_echo_count_i <= b"0000_0000_0011_0011";
    wait for 5ms;

    s_echo_count_i <= b"0000_0000_0000_1100";
    wait for 5ms;

    s_echo_count_i <= b"0000_0000_0111_0100";
    
    wait;
    
end process p_stimulus;

end Behavioral;

