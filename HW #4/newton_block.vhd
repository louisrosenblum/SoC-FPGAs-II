library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity newton_block is

	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16); -- number of fractional bits

	port(input_x : in unsigned(w_bits-1 downto 0);
		input_y : in unsigned(w_bits-1 downto 0);
		output_y : out unsigned(w_bits-1 downto 0));
	

end entity;

architecture newton_block_arch of newton_block is


begin

main: process(input_x,input_y)

	variable x_in : integer;
	variable y_in : integer;
	variable y_out : integer;

begin

	x_in := to_integer(input_x(w_bits-1 downto F_bits)) + to_integer(input_x(F_bits-1 downto 0))/(2**F_bits);
	y_in := to_integer(input_y(w_bits-1 downto F_bits)) + to_integer(input_y(F_bits-1 downto 0))/(2**F_bits);
	
	y_out := y_in * (3-(x_in * (y_in)**2))/2;

	output_y(w_bits-1 downto 0) <= to_unsigned(y_out,w_bits);

end process;

end architecture;