library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
	port (
		-- Control signals
		clk		: in std_logic;
		reset	: in std_logic;
		-- Inputs
		A		: in std_logic_vector(7 downto 0);
		B		: in std_logic_vector(7 downto 0);
		-- Output
		result	: out std_logic_vector(8 downto 0)
	);
end adder;

architecture arch of adder is
	signal op_a	: signed(8 downto 0);
	signal op_b	: signed(8 downto 0);
begin

	add_process : process(clk, reset, A,B)
	begin
		if (reset = '1') then
			op_a      <=  (others => '0');
			op_b      <=  (others => '0');
		elsif(rising_edge(clk)) then
			-- register input and extend sign
			op_a      <=  resize(signed(A),8+1);
			op_b      <=  resize(signed(B),8+1);
		end if;
	end process add_process;

	result <= std_logic_vector(op_a+op_b);
end arch;
