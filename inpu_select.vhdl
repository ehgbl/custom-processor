library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.main_paras.all;

entity inpu_select is
    port (IN0,IN1,IN2,IN3,IN4,IN5,IN6,IN7: in std_logic_vector(m-1 downto 0);
        A, result: in std_logic_vector(m-1 downto 0);
        j: in std_logic_vector(2 downto 0);
        input_control: in std_logic_vector(1 downto 0);
        to_reg: out std_logic_vector(m-1 downto 0)
    );
end inpu_select;
architecture behavior of inpu_select is
    signal temp_result: std_logic_vector(m-1 downto 0);
begin
    -- Combinational input selection process
    first_process: process (IN0, IN1, IN2, IN3, IN4, IN5, IN6, IN7, j)
    begin
        case j is
            when "000" => temp_result <= IN0;  -- Select IN0
            when "001" => temp_result <= IN1;  -- Select IN1
            when "010" => temp_result <= IN2;  -- Select IN2
            when "011" => temp_result <= IN3;  -- Select IN3
            when "100" => temp_result <= IN4;  -- Select IN4
            when "101" => temp_result <= IN5;  -- Select IN5
            when "110" => temp_result <= IN6;  -- Select IN6
            when others => temp_result <= IN7; -- Default to IN7
        end case;
    end process;
    -- Second process to handle input control
    second_process: process (input_control, A,selected,result)
    begin
        case input_control is
            when "00" => to_reg <= temp_result;  -- Output selected input
            when "01" => to_reg <= A;            -- Pass A through
            when "10" => to_reg <= result;       -- Pass result through
            when others => to_reg <= (others => '0'); -- Default to zero
        end case;
    end process;
end input_selection_arch;
