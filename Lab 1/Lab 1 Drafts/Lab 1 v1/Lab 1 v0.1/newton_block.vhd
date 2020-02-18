library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

library IEEE_proposed;
use IEEE_proposed.fixed_pkg.all;

entity newton_block is

	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16); -- number of fractional bits

	port(	clk : in std_logic;
		input_x : in ufixed(w_bits-F_bits-1 downto -F_bits);
		input_y : in ufixed(w_bits-F_bits-1 downto -F_bits);
		output_x : out ufixed(w_bits-F_bits-1 downto -F_bits);
		output_y : out ufixed(w_bits-F_bits-1 downto -F_bits));
	

end entity;

architecture newton_block_arch of newton_block is


begin

main: process(clk)

	variable y1 : ufixed(w_bits-F_bits-1 downto -F_bits);
	variable y2 : ufixed(w_bits-F_bits-1 downto -F_bits);

begin

	if(rising_edge(clk)) then

	y1 := resize((input_x*input_y*input_y),w_bits-F_bits-1,-F_bits);
	y2 := resize(input_y*(3 - y1)/2,w_bits-F_bits-1,-F_bits);

	output_y <= y2;
	output_x <= input_x;

	end if;

end process;

end architecture;