library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_tb is
end adder_tb;

architecture behav of adder_tb is

	signal clk	: std_logic := '0';
	signal rst	: std_logic := '0';
	signal A	: std_logic_vector(7 downto 0) := (others => '0');
	signal B	: std_logic_vector(7 downto 0) := (others => '0');
	signal C	: std_logic_vector(8 downto 0);

begin
	DUT : entity work.adder
		port map(
			clk		=> clk,
			reset	=> rst,
			A		=> A,
			B		=> B,
			result	=> C
		);


	clk <= not(clk) after 10 ns;
	rst <= '1','0' after 30 ns;

	simulation : process
	begin
		
		wait for 20 ns;

		-- Test ADD 1+1
		wait until rising_edge(clk);
			A <= std_logic_vector(to_signed(1,8));
			B <= std_logic_vector(to_signed(1,8));

		-- Test ADD (-1)+1
		wait until rising_edge(clk);
			A <= std_logic_vector(to_signed(-1,8));
			B <= std_logic_vector(to_signed(1,8));

		-- Test ADD 17+(-27)
		wait until rising_edge(clk);
			A <= std_logic_vector(to_signed(17,8));
			B <= std_logic_vector(to_signed(-27,8));

		wait for 10 ns;
	end process simulation;

end behav;
