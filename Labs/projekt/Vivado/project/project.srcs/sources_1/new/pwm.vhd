library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity pwm is
    Port (           
           sound    : out STD_LOGIC;
           clock    : in STD_LOGIC;
           reset    : in std_logic;
           echo_count_i : in unsigned(16 - 1 downto 0)
           );

end pwm;

architecture Behavioral of pwm is
    signal s_4khz  : std_logic;
    signal s_en    : std_logic;
    signal s_sound : std_logic := '0';
    signal g_MAX_length : unsigned(18-1 downto 0) := b"11_0110_1110_1110_1000"; -- 225 000
begin

    clk_en0 : entity work.clock_enable
       generic map(g_MAX => 25000
       )
            port map(
                clk => clock,
                reset => reset,
                ce_o => s_4khz          
            );
            
     clk_en1 : entity work.clk_enable_beep
       
            port map(
                clk => clock,
                reset => reset,
                ce_o => s_en,
                g_MAX => g_MAX_length
            );       
            
            
            
p_sound : process (clock)
 begin
    if rising_edge (clock) then
        if(reset = '1') then
            s_sound <= '0';
        else
            if(s_en = '1') then
            s_sound <= not s_sound;
            else
                s_sound <=  s_sound;
            end if;
        end if;
    end if;
        end process p_sound;
        
p_decide : process(clock)
begin
   if(echo_count_i > 0 and echo_count_i < 1166) then
    g_MAX_length <= b"01_1000_0110_1010_0000";      --100 000
 elsif(echo_count_i > 1166 and echo_count_i < 2332)then
    g_MAX_length <=b"01_1110_1000_0100_1000";       --125 000
 elsif(echo_count_i > 2332 and echo_count_i < 3499) then
    g_MAX_length <=b"10_0100_1001_1111_0000";       --150 000
 elsif(echo_count_i > 3499 and echo_count_i < 4664)then
    g_MAX_length <=b"10_1010_1011_1001_1000";       --175 000
 elsif(echo_count_i > 4664 and echo_count_i < 5831)then
    g_MAX_length <=b"11_0000_1101_0100_0000";       --200 000
 else
    g_MAX_length <=b"11_0110_1110_1110_1000";       --225 000
 end if;
end process p_decide;       
        sound <= s_sound and s_4khz;
        
end Behavioral;
