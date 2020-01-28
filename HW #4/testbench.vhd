library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

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

component newton_block is

	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16); -- number of fractional bits

	port(input_x : in ufixed(w_bits-F_bits-1 downto -F_bits);
		input_y : in ufixed(w_bits-F_bits-1 downto -F_bits);
		output_y : out ufixed(w_bits-F_bits-1 downto -F_bits));
end component;

begin

newton_chain : for i in N_iterations-1 downto 0 generate

	signal output_chain : fixed_array;
	signal x_chain : fixed_array;

	begin

	block_chain : if i = N_iterations-1 generate

		block0: component newton_block  -- Most significant cell
			generic map (w_bits => w_bits, F_bits => F_bits)
			port map (input_x => x_chain(i-1), input_y  => output_chain(i-1),output_y => output);


	elsif i = 0 generate

		block0: component newton_block  -- Least significant cell
			generic map (w_bits => w_bits, F_bits => F_bits)
			port map (input_x => x_chain(i), input_y  => to_ufixed(1,w_bits-F_bits-1,-F_bits),output_y => output_chain(i));

	else generate

		block0: component newton_block  -- Middle cells
			generic map (w_bits => w_bits, F_bits => F_bits)
			port map (input_x => x_chain(i-1), input_y  => output_chain(i-1),output_y => output_chain(i));

	end generate block_chain;

end generate newton_chain;

	


main : process

  file text_file : text open read_mode is "stim.txt";
  variable text_line : line;
	variable data : ufixed(W_bits-F_bits-1 downto -F_bits);

begin

while not endfile(text_file) loop
 
  readline(text_file, text_line);
 
	hread(text_line,data);
  
  wait for 10ms;
  
  end loop;
  
	wait;

end process;

end architecture;