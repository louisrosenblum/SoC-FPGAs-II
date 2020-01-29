library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee_proposed.standard_textio_additions.all;

library std;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity testbench is
	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16; -- number of fractional bits
		N_iterations : positive := 3);
end entity;

architecture testbench_arch of testbench is

type fixed_array is array(0 to N_iterations-1) of ufixed(w_bits-F_bits-1 downto -F_bits);

signal output : ufixed(w_bits-F_bits-1 downto -F_bits);
signal output_x : ufixed(w_bits-F_bits-1 downto -F_bits);
signal input : ufixed(w_bits-F_bits-1 downto -F_bits);

component newton_block is
	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16); -- number of fractional bits

	port(input_x : in ufixed(w_bits-F_bits-1 downto -F_bits);
		input_y : in ufixed(w_bits-F_bits-1 downto -F_bits);
		output_x : out ufixed(w_bits-F_bits-1 downto -F_bits);
		output_y : out ufixed(w_bits-F_bits-1 downto -F_bits));
end component;


begin

block0: component newton_block
	generic map(w_bits => w_bits, F_bits => F_bits)
	port map(input_x => input, input_y => to_ufixed(1,w_bits-F_bits-1,-F_bits),output_x => output_x, output_y => output);

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

	if(output(1) = 'U') then

	else


	write(write_line,output);
	writeline(write_file,write_line);
	
	end if;

	end process;

end architecture;
