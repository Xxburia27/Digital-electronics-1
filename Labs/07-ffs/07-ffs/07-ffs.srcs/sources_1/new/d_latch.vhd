library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity d_latch is
    Port ( 
        en    : in STD_LOGIC;
        d     : in STD_LOGIC;
        arst  : in STD_LOGIC;
        q     : out STD_LOGIC;
        q_bar : out STD_LOGIC);
end d_latch;

architecture Behavioral of d_latch is
begin
    p_d_latch : process(en, d, arst)
    begin
        if (arst = '1') then
            q      <= '0';
            q_bar  <= '1';
        elsif (en   = '1') then
            q      <= d;
            q_bar  <= not d;        
        end if;
    end process p_d_latch;
end Behavioral;
