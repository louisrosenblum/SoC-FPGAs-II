library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity y0 is
	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16); -- number of fractional bits

	port(	clock : in std_logic;
		x_in : in std_logic_vector(w_bits-1 downto 0);
		z_in : in std_logic_vector(4 downto 0);
		guess: out std_logic_vector(w_bits downto 1));

end entity y0;

architecture y0_arch of y0 is

signal B : std_logic_vector(w_bits downto 1);

begin

main : process(clock,x_in,z_in)
	begin
	
	if(rising_edge(clock)) then
		B <= w_bits - F_bits - to_integer(z_in) - 1;
	
end process;


end architecture;