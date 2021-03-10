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
entity tb_hex7seg is
    -- Entity of testbench is always empty
end entity tb_hex7seg;

------------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_hex7seg is

    -- Local signals
    signal s_hex       : std_logic_vector(4 - 1 downto 0);
    signal s_seg         : std_logic_vector(7 - 1 downto 0);
begin
    uut_hex_7seg : entity work.hex_7seg
        port map(
            hex_i       => s_hex,
            seg_o       => s_seg
            );
          

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_7seg_decoder : process
    begin
    
    s_hex <= "0000";
    wait for 100ns;
    assert (s_seg = "0000001")
    report "Number: 0 failed" severity error;
    
    s_hex <= "0001";
    wait for 100ns;
    assert (s_seg = "1001111")
    report "Number: 1 failed" severity error;
   
    s_hex <= "0010";
    wait for 100ns;
    assert (s_seg = "0010010")
    report "Number: 2 failed" severity error;
    
    s_hex <= "0011";
    wait for 100ns;
    assert (s_seg = "0000110")
    report "Number: 3 failed" severity error;
    
    s_hex <= "0100";
    wait for 100ns;
    assert (s_seg = "1001100")
    report "Number: 4 failed" severity error;
    
    s_hex <= "0101";
    wait for 100ns;
    assert (s_seg = "0100100")
    report "Number: 5 failed" severity error;
    
    s_hex <= "0110";
    wait for 100ns;
    assert (s_seg = "0100000")
    report "Number: 6 failed" severity error;
    
    s_hex <= "0111";
    wait for 100ns;
    assert (s_seg = "0001111")
    report "Number: 7 failed" severity error;
    
    s_hex <= "1000";
    wait for 100ns;
    assert (s_seg = "0000000")
    report "Number: 8 failed" severity error;
    
    s_hex <= "1001";
    wait for 100ns;
    assert (s_seg = "0000100")
    report "Value: 9 failed" severity error;
    
    s_hex <= "1010";
    wait for 100ns;
    assert (s_seg = "0001000")
    report "Value: A failed" severity error;
    
    s_hex <= "1011";
    wait for 100ns;
    assert (s_seg = "1100000")
    report "Value: b failed" severity error;
    
    s_hex <= "1100";
    wait for 100ns;
    assert (s_seg = "0110011")
    report "Value: C failed" severity error;
    
    s_hex <= "1101";
    wait for 100ns;
    assert (s_seg = "1000010")
    report "Value: d failed" severity error;
    
    s_hex <= "1110";
    wait for 100ns;
    assert (s_seg = "0110000")
    report "Value: E failed" severity error;
    
    s_hex <= "1111";
    wait for 100ns;
    assert (s_seg = "0111000")
    report "Value: E failed" severity error;
    
    
    end process p_7seg_decoder;

end  testbench;
