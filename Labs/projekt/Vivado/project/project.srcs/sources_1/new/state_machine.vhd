

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity state_machine is
 Port (
        clk       : in  std_logic;
        reset     : in  std_logic;
        
        echo_i    : in  std_logic_vector(0 downto 0);
       
        -- OUTPUTS
        echo_count_o : out unsigned(16 - 1 downto 0);
        trigger_o : out std_logic
        
  );
end state_machine;

architecture Behavioral of state_machine is
-- Define the states
    type t_state is (DEF,     --default
                     TRIGG_SEND,   -- trig_send
                     TRIGG_WAIT, -- trigg_wait
                     ECHO_COUNT    --echo_count
                     );
                     
    -- Define the signal that uses different states
    signal s_state  : t_state;
    -- Internal clock enable
    signal s_en     : std_logic;
    -- Local delay counter
    signal   s_cnt  : unsigned(18 - 1 downto 0);
    -- Local echo counter
    signal   s_cnt_echo  : unsigned(16 - 1 downto 0)  := b"0000_0000_0000_0000"; 
    
    signal s_reverse : std_logic := '1';
    -- Specific values for local counter
    constant c_ZERO         :    unsigned(18 - 1 downto 0)  := b"00_0000_0000_0000_0000";
    constant c_DELAY_20uSEC :    unsigned(18 - 1 downto 0)  := b"00_0000_0000_0001_0100";--20us  
    constant c_DELAY_60mSEC :    unsigned(18 - 1 downto 0)  := b"001_1101_0100_1100_000";--60ms  
    
    
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

   
    p_fsm : process(clk)
    begin
        if rising_edge(clk) then    -- 1 clk = 10 ns
            if (reset = '1') then       -- Synchronous reset
                s_state <= DEF ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits
            elsif (s_en = '1') then
                -- Every 1 us, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is
                    -- If the current state is DEF                   
                    when DEF =>
                        -- Count up to c_DELAY_20uSEC
                        echo_count_o <=(others => '0');         
                        if (s_reverse = '0' ) then
                            trigger_o <= '0';
                        else
                            -- Move to the next state
                            s_state <= TRIGG_SEND;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;                            
                        end if;

                    when TRIGG_SEND =>                      
                        if (s_cnt < c_DELAY_20uSEC) then                       
                            trigger_o <= '1';
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TRIGG_WAIT;
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when TRIGG_WAIT =>
                        
                        if(s_reverse = '0') then
                               s_state <= DEF;
                               s_cnt   <= c_ZERO;
                        else                              
                            if (s_cnt < c_DELAY_60mSEC) then
                                trigger_o <= '0';
                                s_cnt <= s_cnt + 1;
                                if(echo_i = "1") then
                                    s_cnt_echo <= (others => '0');
                                    s_state <= ECHO_COUNT;                                   
                                end if;    
                            else
                                s_state <= TRIGG_SEND;
                                s_cnt   <= c_ZERO;
                            end if;
                        end if;
                        
                    when ECHO_COUNT =>   
                                                 
                        if(s_reverse = '0') then
                               s_state <= DEF;
                               s_cnt   <= c_ZERO;
                        else                             
                            if(echo_i = "1") then                                                
                                s_cnt_echo <= s_cnt_echo + 1;  -- 1 count = 1 us                                                          
                            else
                            echo_count_o <= s_cnt_echo;                 
                            s_state <= TRIGG_SEND;
                            s_cnt   <= c_ZERO; 
                            end if;                            
                        end if;   
                    when others =>
                        s_state <= DEF;                       
                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_fsm;
end Behavioral;
