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

end architecture;

