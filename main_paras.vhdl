library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package main_paras is
    constant m: natural := 8; -- 8 bit processor
    constant zero: std_logic_vector(m-1 downto 0) := (conv_std_logic_vector(0, m));
end main_paras;
