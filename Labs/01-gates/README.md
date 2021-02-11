# cvičení 1. De Morganovy zákony.

## Odkaz na EDA playground:

[EDA palyground](https://www.edaplayground.com/x/8LrP)

## Funkce v základnímu úpravu

```vhdl
architecture dataflow of gates is
begin
    f_o  <= ((not b_i) and a_i) or ((not c_i) and (not b_i));
end architecture dataflow;
```

| **c** | **b** |**a** | **f(c,b,a)** |
| :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | 0 |

![Základní funkce](/images/f_o.png)

## Funkce pomocí NOR

```vhdl
architecture dataflow of gates is
begin
   
    fnor_o <= not((b_i) or (not a_i)) or not((c_i) or (b_i));

end architecture dataflow;
```

| **c** | **b** |**a** | **f(c,b,a)** |
| :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | 0 |

![NOR](/images/f_nor.png)

## Funkce pomocí NAND

```vhdl
architecture dataflow of gates is
begin
  
    fnand_o <= not(not((not b_i) and (a_i)) and not((not c_i) and (not b_i)));

end architecture dataflow;
```

| **c** | **b** |**a** | **f(c,b,a)** |
| :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | 0 |

![NAND](/images/f_nand.png)