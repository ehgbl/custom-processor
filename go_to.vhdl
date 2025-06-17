
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.main_parameters.all;

entity go_to is
    port (
        N, data: in std_logic_vector(m-1 downto 0);
        clk, reset: in std_logic;
        numb_sel: in std_logic_vector(3 downto 0);
        number: inout std_logic_vector(m-1 downto 0)
    );
end go_to;

architecture go_to_arch of go_to is
    signal pos, neg, load: std_logic;
begin
    -- Sign computation: determine if data is positive, negative, or zero
    sign_computation: process(data)
    begin
        if data(m-1) = '1' then      -- MSB = 1 means negative (two's complement)
            pos <= '0'; 
            neg <= '1';
        elsif data = zero then        -- All zeros
            pos <= '0'; 
            neg <= '0';
        else                          -- Positive number
            pos <= '1'; 
            neg <= '0'; 
        end if;
    end process;
    
    -- Load condition: determines when to load new program counter value
    load_condition: process(numb_sel, pos, neg)
    begin
        case numb_sel is
            when "1110" => load <= '1';    -- Unconditional jump
            when "1100" => load <= pos;    -- Jump if positive
            when "1101" => load <= neg;    -- Jump if negative
            when others => load <= '0';    -- No jump (increment)
        end case;
    end process;
    
    -- Programmable counter: implements program counter logic
    programmable_counter: process(clk, reset)
    begin
        if reset = '1' then 
            number <= zero;                -- Reset to zero
        elsif clk'event and clk = '1' then
            if load = '1' then 
                number <= N;               -- Jump to address N
            else 
                number <= number + 1;      -- Increment counter
            end if;
        end if;
    end process;
end go_to_arch;