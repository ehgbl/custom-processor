library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.main_paras.all;

entity ALU is
    port (
        A, B: in std_logic_vector(m-1 downto 0);

        ALUop: in std_logic_vector(2 downto 0);
        result: out std_logic_vector(m-1 downto 0);
        zero: out std_logic
        
    );
end ALU;

architecture behavior of ALU is
    signal temp_result: std_logic_vector(m-1 downto 0);
begin
    -- Combinational ALU process
    process (A, B, ALUop)
    begin
        case ALUop is
            when "000" => temp_result <= A + B;        -- Addition
            when "001" => temp_result <= A - B;        -- Subtraction  
            when "010" => temp_result <= A AND B;      -- Bitwise AND
            when "011" => temp_result <= A OR B;       -- Bitwise OR
            when "100" => temp_result <= A XOR B;      -- Bitwise XOR
            when "101" => temp_result <= NOT A;        -- Bitwise NOT A
            when "110" => temp_result <= A;            -- Pass A through
            when others => temp_result <= (others => '0'); -- Default
        end case;
    end process;
    
    result <= temp_result;
    
    zero <= '1' when temp_result = conv_std_logic_vector(0, m) else '0';
end behavior;