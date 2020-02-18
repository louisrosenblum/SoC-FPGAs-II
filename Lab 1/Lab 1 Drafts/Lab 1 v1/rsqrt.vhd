library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee_proposed.standard_textio_additions.all;

entity rsqrt is
	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16; -- number of fractional bits
		N_iterations : positive := 3);

	port (  clk : in std_logic;
		x : in ufixed(w_bits-F_bits-1 downto -F_bits);
		y : out ufixed(w_bits-F_bits-1 downto -F_bits));
	
end entity;

architecture rsqrt_arch of rsqrt is

signal approx : ufixed(w_bits-F_bits-1 downto -F_bits);

component newton_block is

	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16); -- number of fractional bits

	port(	clk : in std_logic;
		input_x : in ufixed(w_bits-F_bits-1 downto -F_bits);
		input_y : in ufixed(w_bits-F_bits-1 downto -F_bits);
		output_x : out ufixed(w_bits-F_bits-1 downto -F_bits);
		output_y : out ufixed(w_bits-F_bits-1 downto -F_bits));
	

end component;

component y0 is
	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16); -- number of fractional bits


	port (	clk : in std_logic;
		x : in ufixed(w_bits-F_bits-1 downto -F_bits);
		y : out ufixed(w_bits-F_bits-1 downto -F_bits));
	
end component;

begin

y0_main : component y0
	generic map (w_bits => w_bits, F_bits => F_bits)
	port map (clk => clk, x => x, y => approx);

newton_0 : component newton_block
		generic map(w_bits => w_bits, F_bits => F_bits)
		port map(clk => clk, input_x => x, input_y => approx, output_x => OPEN, output_y => y);

end architecture;

