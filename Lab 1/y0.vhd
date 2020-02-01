library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee_proposed.standard_textio_additions.all;

entity y0 is
	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16); -- number of fractional bits

	port (  clk : in std_logic;
		x : in ufixed(w_bits-F_bits-1 downto -F_bits);
		y : out ufixed(w_bits-F_bits-1 downto -F_bits));
	
end entity;

architecture y0_arch of y0 is

signal z : std_logic_vector(4 downto 0);

component lzc is
    port (
        clk        : in  std_logic;
        lzc_vector : in  std_logic_vector (31 downto 0);
        lzc_count  : out std_logic_vector ( 4 downto 0)
    );
end component;

begin

lzc_main : component lzc
	port map(clk => clk, lzc_vector => std_logic_vector(x), lzc_count => z);


main : process(clk)

variable A : integer;
variable B : integer;
variable even : Boolean;
variable Xa: ufixed(w_bits-F_bits-1 downto -F_bits);
variable Xb: ufixed(w_bits-F_bits-1 downto -F_bits);

begin

	B := w_bits - F_bits - to_integer(unsigned(z)) - 1;

	if(B mod 2) = 0 then
		even := true;
	else
		even := false;
	end if;

	if(even = true) then
		A := -3/2*B;
	else
		A := -3/2*B + 1/2;
	end if;

	Xa := resize((2**A) * x,w_bits-F_bits-1,-F_bits);
		
	Xb := resize((2**(-B)) * x,w_bits-F_bits-1,-F_bits);
	

end process;

end architecture;

