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

	port (input : in ufixed(w_bits-F_bits-1 downto -F_bits);
		output : out ufixed(w_bits-F_bits-1 downto -F_bits));
	
end entity;

architecture rsqrt_arch of rsqrt is

begin

end architecture;

