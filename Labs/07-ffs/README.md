# 7. Cvičení - ffs

## Domácí příprava

rovnice:
\begin{align*}
    q_{n+1}^D = d \\
    q_{n+1}^{JK} =notk * q_n + * notq_n\\
    q_{n+1}^T =&\\
\end{align*}-->


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

## flip-flops vhdl kód `p_d_ff_arst` 
```vhdl
p_d_ff_arst : process(clk, arst)
    begin
        if (arst = '1') then
            q      <= '0';
            q_bar  <= '1';
        elsif rising_edge(clk) then
            q      <= d;
            q_bar  <= not d;        
        end if;
    end process p_d_ff_arst;
```
## flip-flops vhdl kód clock_enable testbench
```vhdl
p_clk_gen : process
begin
    while now < 750ns loop          -- 75 perido of 100MHz clock
        s_clk <= '0';
        wait for c_CLK_100MHZ_PERIOD / 2;
        s_clk <= '1';
        wait for c_CLK_100MHZ_PERIOD / 2;
    end loop;
    wait;
end process p_clk_gen;
```
## flip-flops vhdl kód clock_enable testbench, reset
```vhdl
p_reset_gen : process
begin
    s_arst <= '0';
    wait for 328ns;
    
    s_arst <= '1';          -- reset activated
    wait for 144ns;
    
    s_arst <= '0';          -- reset deactivated
    wait;
    
end process p_reset_gen;
```
## flip-flops vhdl kód clock_enable testbench, stimulus
```vhdl
p_stimulus :process
begin
        report "Stimulus process started" severity note;

          s_d    <= '0';
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
          wait for 14 ns;
          s_d  <= '1';
          wait for 14 ns;
          s_d  <= '0';
          wait for 24 ns;
          s_d  <= '1';
          wait for 22 ns;
          s_d  <= '0';
          wait for 36 ns;
          wait for 56 ns;

          s_d    <= '1'; 
          wait for 14 ns;
          s_d    <= '0'; 
          wait for 24 ns;
          s_d    <= '1'; 
          wait for 22 ns;
          s_d    <= '0'; 
          wait for 36 ns;

                                        -- Test reset
          wait for 14 ns;
          s_d    <= '1';
          wait for 14 ns;
          s_d    <= '0';
          wait for 36 ns;
          s_d  <= '1';
          wait for 22 ns;
          s_d <= '0';
          wait for 56 ns;
          s_d <= '1';
          wait for 14 ns;
          s_d <= '0';
          wait for 24 ns;
          s_d <= '1';
          wait for 22 ns;
          s_d <= '0';
          wait for 36  ns;
           
           report "Stimulus process finished" severity note;
           wait;
        
end process p_stimulus;
```
## Simulace
![Simulavce_2](./images/Simulace_2.PNG)

## flip-flops vhdl kód `p_d_ff_rst` 
```vhdl
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
```
## flip-flops vhdl kód testbench, reset
```vhdl
p_reset_gen : process
begin
    s_rst <= '0';
    wait for 328ns;
    
    s_rst <= '1';          -- reset activated
    wait for 144ns;
    
    s_rst <= '0';          -- reset deactivated
    wait;
    
end process p_reset_gen;
```
## flip-flops vhdl kód testbench, stimulus
```vhdl
p_stimulus :process
begin
        report "Stimulus process started" severity note;

          s_d    <= '0';
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
          wait for 14 ns;
          s_d  <= '1';
          wait for 14 ns;
          s_d  <= '0';
          wait for 24 ns;
          s_d  <= '1';
          wait for 22 ns;
          s_d  <= '0';
          wait for 36 ns;
          wait for 56 ns;

          s_d    <= '1'; 
          wait for 14 ns;
          s_d    <= '0'; 
          wait for 24 ns;
          s_d    <= '1'; 
          wait for 22 ns;
          s_d    <= '0'; 
          wait for 36 ns;

                                        -- Test reset
          wait for 14 ns;
          s_d    <= '1';
          wait for 14 ns;
          s_d    <= '0';
          wait for 36 ns;
          s_d  <= '1';
          wait for 22 ns;
          s_d <= '0';
          wait for 56 ns;
          s_d <= '1';
          wait for 14 ns;
          s_d <= '0';
          wait for 24 ns;
          s_d <= '1';
          wait for 22 ns;
          s_d <= '0';
          wait for 36  ns;
           
           report "Stimulus process finished" severity note;
           wait;
        
end process p_stimulus;
```
## Simulace
![Simulace_3](./images/Simulace_3.PNG)

## flip-flops vhdl kód `p_jj_ff_rst` 
```vhdl
jk_ff_rst :process (clk)
  variable qn : std_logic;
    begin
       if rising_edge (clk) then
         if(rst = '1') then 
           qn := '0';
       else
       if (j = '0' and k = '0') then
           qn := qn;
       elsif (j = '0' and k = '1') then
           qn := '0';
       elsif (j = '1' and k = '0') then
           qn := '1';
       else
           qn := not qn;
         end if;
       end if;
     end if;
     q     <= qn;
     q_bar <= not qn;
     end process jk_ff_rst;
```
## flip-flops vhdl kód testbench, reset
```vhdl
jp_reset_gen : process
begin
    s_rst <= '0';
    wait for 328ns;
    
    s_rst <= '1';          -- reset activated
    wait for 144ns;
    
    s_rst <= '0';          -- reset deactivated
    wait;
    
end process p_reset_gen;
```
## flip-flops vhdl kód testbench, stimulus
```vhdl
p_stimulus :process
begin
        report "Stimulus process started" severity note;

          s_j    <= '0';
          s_k    <= '0';
          wait for 26 ns;
          
          s_j    <= '1'; 
          s_k    <= '0';
          wait for 14 ns;
          s_j    <= '0';
          s_k    <= '0';
          wait for 24 ns;
          s_j    <= '0';
          s_k    <= '1';
          wait for 22 ns;
          s_j    <= '1';
          s_k    <= '1';
          wait for 36 ns;
          s_j    <= '0';
          s_k    <= '0';
          wait for 26 ns;
          
          s_j    <= '1'; 
          s_k    <= '0';
          wait for 14 ns;
          s_j    <= '0';
          s_k    <= '0';
          wait for 24 ns;
          s_j    <= '0';
          s_k    <= '1';
          wait for 22 ns;
          s_j    <= '1';
          s_k    <= '1';
          wait for 36 ns;
          s_j    <= '0';
          s_k    <= '0';
          wait for 26 ns;
          
          s_j    <= '1'; 
          s_k    <= '0';
          wait for 14 ns;
          s_j    <= '0';
          s_k    <= '0';
          wait for 24 ns;
          s_j    <= '0';
          s_k    <= '1';
          wait for 22 ns;
          s_j    <= '1';
          s_k    <= '1';
          wait for 36 ns;
          s_j    <= '0';
          s_k    <= '0';
          wait for 26 ns;
          
          s_j    <= '1'; 
          s_k    <= '0';
          wait for 14 ns;
          s_j    <= '0';
          s_k    <= '0';
          wait for 24 ns;
          s_j    <= '0';
          s_k    <= '1';
          wait for 22 ns;
          s_j    <= '1';
          s_k    <= '1';
          wait for 36 ns;
          s_j    <= '0';
          s_k    <= '0';
          wait for 26 ns;
           
           report "Stimulus process finished" severity note;
           wait;
        
end process p_stimulus;
```
## Simulace
![Simulace_4](./images/Simulace_4.PNG)

## flip-flops vhdl `p_t_ff_rst`
```vhdl
t_ff_rst :process (clk)
    begin 
     if rising_edge (clk) then
         if(rst = '1') then 
           s_q     <= '0';
           s_q_bar <= '1'; 
        else
           if (t = '0') then
           s_q     <= s_q;
           s_q_bar <= s_q_bar;
        else 
          s_q     <= not s_q;
          s_q_bar <= not s_q_bar;
       end if;
     end if;
   end if;
     end process  t_ff_rst ;
```
## flip-flops vhdl testbench, reset
```vhdl
p_reset_gen : process
begin
    s_rst <= '0';
    wait for 328ns;
    
    s_rst <= '1';          -- reset activated
    wait for 144ns;
    
    s_rst <= '0';          -- reset deactivated
    wait;
    
end process p_reset_gen;
```
## flip-flops vhdl testbench, stimulus
```vhdl
p_stimulus :process
begin
        report "Stimulus process started" severity note;

           s_t    <= '0';
          wait for 26 ns;

          s_t    <= '1'; 
          wait for 14 ns;
          s_t    <= '0';
          wait for 24 ns;
          s_t    <= '1';
          wait for 22 ns;
          s_t    <= '0';
          wait for 36 ns;

                                        -- Test enable
          wait for 14 ns;
          s_t  <= '1';
          wait for 14 ns;
          s_t  <= '0';
          wait for 24 ns;
          s_t  <= '1';
          wait for 22 ns;
          s_t  <= '0';
          wait for 36 ns;
          wait for 56 ns;

          s_t    <= '1'; 
          wait for 14 ns;
          s_t    <= '0'; 
          wait for 24 ns;
          s_t    <= '1'; 
          wait for 22 ns;
          s_t    <= '0'; 
          wait for 36 ns;

                                          -- Test reset
          wait for 14 ns;
          s_t    <= '1';
          wait for 14 ns;
          s_t    <= '0';
          wait for 36 ns;
          s_t  <= '1';
          wait for 22 ns;
          s_t <= '0';
          wait for 56 ns;
          s_t <= '1';
          wait for 14 ns;
          s_t <= '0';
          wait for 24 ns;
          s_t <= '1';
          wait for 22 ns;
          s_t <= '0';
          wait for 36  ns;
           
           report "Stimulus process finished" severity note;
           wait;
        
end process p_stimulus;
```
## Simulace
![Simulace_5](./images/Simulace_5.PNG)








