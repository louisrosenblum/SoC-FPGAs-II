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

signal output : ufixed(w_bits-F_bits-1 downto -F_bits);
signal input : ufixed(w_bits-F_bits-1 downto -F_bits);

component rsqrt is
	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16; -- number of fractional bits
		N_iterations : positive := 3);

	port (input : in ufixed(w_bits-F_bits-1 downto -F_bits);
		output : out ufixed(w_bits-F_bits-1 downto -F_bits));
	
end component;



begin

rqsrt_main : component rsqrt
	generic map(w_bits => w_bits, F_bits => F_bits, N_iterations => N_iterations)
	port map(input => input, output => output);


-- File I/O
main : process

file text_file : text open read_mode is "stim.txt";
variable text_line : line;
variable data_fixed : ufixed(w_bits-F_bits-1 downto -F_bits);

begin

while not endfile(text_file) loop
 
  readline(text_file, text_line);
 
	read(text_line,data_fixed);

	input <= data_fixed;

	wait for 1 ms;
  
  end loop;
  
	wait;

end process;

write_out : process(output)
	file write_file : text open write_mode is "output.txt";
	variable write_line : line;
	
	begin

	if(output(1) = 'U') or (output(1) = 'X') then

	else


	write(write_line,output);
	writeline(write_file,write_line);
	
	end if;

	end process;

end architecture;

