

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity d_ff_rst is
  Port (    clk   : in STD_LOGIC;
            d     : in STD_LOGIC;
            rst  : in STD_LOGIC;
            q     : out STD_LOGIC;
            q_bar : out STD_LOGIC);
end d_ff_rst;

architecture Behavioral of d_ff_rst is
            signal s_q : STD_LOGIC;
            signal s_q_bar : STD_LOGIC; 
begin

p_d_ff_rst :process (clk)
    begin
       if rising_edge (clk) then
         if(rst = '1') then 
           s_q     <= '0';
           s_q_bar <= '1'; 
       else
           s_q     <= d;    
           s_q_bar <= not d;
         end if;
       end if;
     end process p_d_ff_rst;
     
     q     <= s_q;
     q_bar <= s_q_bar;
     
end Behavioral;