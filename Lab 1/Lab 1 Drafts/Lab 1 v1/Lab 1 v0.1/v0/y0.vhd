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



begin

main : process(clock,x_in,z_in)

	variable A : integer;
	variable B : integer;
	variable even : Boolean;
	variable Xa: unsigned(w_bits-1 downto 0);
	variable Xb: unsigned(w_bits-1 downto 0);

	begin
	
	if(rising_edge(clock)) then
		B := w_bits - F_bits - to_integer(unsigned(z_in)) - 1;

		if(to_signed(B,w_bits-1)(0) = '0') then
			even := true;
		else
			even := false;

		end if;

		if(even = true) then
			A := -3/2*B;
		else
			A := -3/2*B + 1/2;
		end if;

		Xa := to_unsigned(2**A,w_bits-1)*unsigned(x_in);
		
		Xb := to_unsigned(2**(-1*B),w_bits-1);
		
	end if;
	
end process;


end architecture;
