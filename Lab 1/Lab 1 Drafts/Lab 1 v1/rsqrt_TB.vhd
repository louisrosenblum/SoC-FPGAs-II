library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee_proposed.standard_textio_additions.all;

library std;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity rsqrt_TB is
	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16; -- number of fractional bits
		N_iterations : positive := 3);
end entity;

architecture rsqrt_TB_arch of rsqrt_TB is

signal y : ufixed(w_bits-F_bits-1 downto -F_bits);
signal x : ufixed(w_bits-F_bits-1 downto -F_bits);
signal clk : std_logic := '0';

component rsqrt is
	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16; -- number of fractional bits
		N_iterations : positive := 3);

	port (  clk : in std_logic;
		x : in ufixed(w_bits-F_bits-1 downto -F_bits);
		y : out ufixed(w_bits-F_bits-1 downto -F_bits));
	
end component;



begin

rqsrt_main : component rsqrt
	generic map(w_bits => w_bits, F_bits => F_bits, N_iterations => N_iterations)
	port map(clk => clk, x => x, y => y);



-- File I/O
main : process

file text_file : text open read_mode is "stim.txt";
variable text_line : line;
variable data_fixed : ufixed(w_bits-F_bits-1 downto -F_bits);

begin


	clk <= not clk;


	wait for 1 ms;
	clk <= not clk;
	wait for 1 ms;

while not endfile(text_file) loop

 
  readline(text_file, text_line);
 
	read(text_line,data_fixed);

	x <= data_fixed;

	clk <= not clk;

	wait for 1 ms;

	clk <= not clk;

	wait for 1 ms;
  
  end loop;

	clk <= not clk;
	wait for 1 ms;



end process;

write_out : process(y)

	variable zero : ufixed(w_bits-F_bits-1 downto -F_bits);

	file write_file : text open write_mode is "output.txt";
	variable write_line : line;
	
	begin

	zero := (others => '0');

	if(y(1) = 'U') or (y(1) = 'X') then

	elsif(y = zero) then

	else


	write(write_line,y);
	writeline(write_file,write_line);
	
	end if;

	end process;

end architecture;

