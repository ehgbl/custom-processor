library IEEE;
use IEEE.std_logic_1164.all;
use work.main_paras.all;

entity output_selection is
    port (
        A, reg: in std_logic_vector(m-1 downto 0);
        clk, out_en, out_sel: in std_logic;
        i: in std_logic_vector(2 downto 0);
        OUT0, OUT1, OUT2, OUT3, OUT4, OUT5, OUT6, OUT7: out std_logic_vector(m-1 downto 0)
    );
end output_selection;

architecture output_selection_arch of output_selection is
    signal EN: std_logic_vector(0 to 7);
    signal DEC_OUT: std_logic_vector(0 to 7);
    signal to_ports: std_logic_vector(m-1 downto 0);
begin
    -- Decoder: converts 3-bit address to one-hot
    decoder: process(i)
    begin
        case i is
            when "000" => DEC_OUT <= "10000000";
            when "001" => DEC_OUT <= "01000000";
            when "010" => DEC_OUT <= "00100000";
            when "011" => DEC_OUT <= "00010000";
            when "100" => DEC_OUT <= "00001000";
            when "101" => DEC_OUT <= "00000100";
            when "110" => DEC_OUT <= "00000010";
            when others => DEC_OUT <= "00000001";
        end case;
    end process;
    
    -- AND gate: enables output only when out_en is active
    and_gate: process(DEC_OUT, out_en)
    begin
        for idx in 0 to 7 loop 
            EN(idx) <= DEC_OUT(idx) AND out_en;
        end loop;
    end process;
    
    -- Multiplexer: selects data source
    multiplexer: process(out_sel, A, reg)
    begin
        if out_sel = '0' then 
            to_ports <= A;    -- Direct value from instruction
        else 
            to_ports <= reg;  -- Value from register
        end if;
    end process;
    
    -- Output registers: store data to output ports
    output_registers: process(clk)
    begin
        if clk'event and clk = '1' then
            case EN is
                when "10000000" => OUT0 <= to_ports;
                when "01000000" => OUT1 <= to_ports;
                when "00100000" => OUT2 <= to_ports;
                when "00010000" => OUT3 <= to_ports;
                when "00001000" => OUT4 <= to_ports;
                when "00000100" => OUT5 <= to_ports;
                when "00000010" => OUT6 <= to_ports;
                when "00000001" => OUT7 <= to_ports;
                when others => null; -- No output enabled
            end case;
        end if;
    end process;
end output_selection_arch;