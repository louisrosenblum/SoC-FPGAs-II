library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity newton_block is

	port(input_x : in unsigned(7 downto 0);
		input_y : in unsigned(7 downto 0);
		output_y : out unsigned(7 downto 0));
	

end entity;

architecture newton_block_arch of newton_block is


begin

main: process(input_x,input_y)

	variable x_in : integer;
	variable y_in : integer;
	variable y_out : integer;

begin

	x_in := to_integer(input_x);
	y_in := to_integer(input_y);
	
	output_y

end process;

end architecture;