# 7. Cvičení - ffs

## Domácí příprava
Pravdivostní tabulky

   | **D** | **Qn** | **Q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | No change |
   | 0 | 1 | 1 | Change |
   | 1 | 0 | 0 | Change |
   | 1 | 1 | 1 | No change |

   | **J** | **K** | **Qn** | **Q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | 0 | No change |
   | 0 | 0 | 1 | 1 | No change |
   | 0 | 1 | 0 | 0 | Reset |
   | 0 | 1 | 1 | 0 | Reset |
   | 1 | 0 | 1 | 1 | Set |
   | 1 | 1 | 1 | 1 | Set |
   | 1 | 1 | 0 | 1 | Toggle |
   | 1 | 1 | 1 | 0 | Toggle |

   | **T** | **Qn** | **Q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | No change |
   | 0 | 1 | 1 | No change |
   | 1 | 0 | 1 | Invert (toggle) |
   | 1 | 1 | 0 | Invert (toggle) |

## D-latch vhdl kód z `p_d_latch`, process
```vhdl
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
```
## D-latch testbench kód `tb_p_d_latch`, stimulus
```vhdl
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
```
## Simulace
![Simulace_1](./images/Simulace_1.PNG)


