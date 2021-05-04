


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity tb_top is

end tb_top;

architecture Behavioral of tb_top is
constant         c_CLK_100MHZ_PERIOD : time := 10ns;
signal           s_CLK100MHZ :  STD_LOGIC;                      --clock
signal           s_sw        :  std_logic_vector(0 downto 0);   -- reset switch
           --outputs
signal           s_jd        :  STD_LOGIC_VECTOR (4 downto 0);  --LEDs
signal           s_ja        :  std_logic_vector (1 downto 0);  -- ja(0) -> trigger_o;  ja(1) -> sound
           --input (echo_i)
signal           s_jc        :  std_logic_vector(0 downto 0);


begin

    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 200 ms loop   -- 10 usec of simulation
            s_CLK100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_CLK100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;


uut_top : entity work.top
    port map(
           CLK100MHZ =>s_CLK100MHZ,
           sw(0)        => s_sw(0),
           jd        =>s_jd,
           ja        =>s_ja,
           jc(0)       =>s_jc(0) 
    );

p_top : process
begin

 wait for 10 ms;
 s_sw(0) <= '1';
 wait for 2 ms;
 s_sw(0) <= '0';
 wait for 5 ms;
 s_jc(0) <= '1';
 wait for 5ms;
 s_jc(0) <= '0';
 wait for 4ms;
 s_jc(0) <= '1';
 wait for 2ms;
 s_jc(0) <= '0';
 wait;
end process p_top;
end Behavioral;
