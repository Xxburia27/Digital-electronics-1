library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_d_latch is
--  Port ( );
end tb_d_latch;

architecture testbench of tb_d_latch is
        signal s_en    :  STD_LOGIC;
        signal s_d     :  STD_LOGIC;
        signal s_arst  :  STD_LOGIC;
        signal s_q     :  STD_LOGIC; 
        signal s_q_bar :  STD_LOGIC;

begin
uut_d_latch : entity work.d_latch
port map (
        en       => s_en,
        d        => s_d,
        arst     => s_arst,
        q        => s_q,
        q_bar    => s_q_bar
);

p_d_latch :process
begin
report "Stimulus process started" severity note;

        s_en   <= '0'; 
        s_d    <= '0';
        s_arst <= '0';
        wait for 26 ns;
        
        s_d    <= '1'; 
        wait for 14 ns;
        s_d    <= '0';
        wait for 24 ns;
        s_d    <= '1';
        wait for 22 ns;
        s_d    <= '0';
        wait for 36 ns;
                                     -- Test enable
        s_en <= '1';                 -- Enable activated
        wait for 14 ns;
        s_d  <= '1';
        wait for 14 ns;
        s_d  <= '0';
        wait for 24 ns;
        s_d  <= '1';
        wait for 22 ns;
        s_d  <= '0';
        wait for 36 ns;
        s_en <= '0';                -- Enable deactivated
        wait for 56 ns;
                                    -- Test reset
        s_en   <= '1';
        wait for 14 ns;
        s_d    <= '1';
        wait for 14 ns;
        s_arst <= '1';              -- Reset activated
        wait for 24 ns;
        s_d    <= '0';
        wait for 36 ns;
        s_d  <= '1';
        wait for 22 ns;
        s_d <= '0';
        wait for 36 ns;
        s_arst <= '0';             -- Reset deactivated
        wait for 56 ns;
        s_d <= '1';
        wait for 14 ns;
        s_d <= '0';
        wait for 24 ns;
        s_d <= '1';
        wait for 22 ns;
        s_d <= '0';
        wait for 22ns;
        
         report "Stimulus process finished" severity note;
         wait;
end process p_d_latch;

 
end testbench;