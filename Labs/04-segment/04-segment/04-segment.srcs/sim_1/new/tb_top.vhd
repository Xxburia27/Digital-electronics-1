------------------------------------------------------------------------
--
-- Testbench for 2-bit binary comparator.
-- EDA Playground
--
-- Copyright (c) 2020-2021 Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_top is
    -- Entity of testbench is always empty
end entity tb_top;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_top is

    -- Local signals
    signal s_SW          : std_logic_vector(3 downto 0);
    signal s_LED         : std_logic_vector(7 downto 0);
    signal s_CA          : std_logic;
    signal s_CB          : std_logic;
    signal s_CC          : std_logic;
    signal s_CD          : std_logic;
    signal s_CE          : std_logic;
    signal s_CF          : std_logic;
    signal s_CG          : std_logic;
    signal s_AN          : std_logic_vector(7 downto 0);
    
begin
    uut_top : entity work.top
        port map(
            SW           => s_SW,
            LED          => s_LED,
            CA           => s_CA,
            CB           => s_CB,
            CC           => s_CC,
            CD           => s_CD,
            CE           => s_CE,
            CF           => s_CF,
            CG           => s_CG,
            AN           => s_AN
            );
          

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_LED : process
    begin
    
    s_SW <= "0000";
    wait for 100ns;
    s_SW <= "0001";
    wait for 100ns;
    s_SW <= "0010";
    wait for 100ns;
    s_SW <= "0011";
    wait for 100ns;
    s_SW <= "0100";
    wait for 100ns;
    s_SW <= "0101";
    wait for 100ns;
    s_SW <= "0110";
    wait for 100ns;
    s_SW <= "0111";
    wait for 100ns;
    s_SW <= "1000";
    wait for 100ns;
    s_SW <= "1001";
    wait for 100ns;
    s_SW <= "1010";
    wait for 100ns;
    s_SW <= "1011";
    wait for 100ns;
    s_SW <= "1100";
    wait for 100ns;
    s_SW <= "1101";
    wait for 100ns;
    s_SW <= "1110";
    wait for 100ns;
    s_SW <= "1111";
    wait;
 
    end process p_LED;

end testbench;
