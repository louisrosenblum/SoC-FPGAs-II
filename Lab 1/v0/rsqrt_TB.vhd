library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;
library std;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity rsqrt_TB is

end entity rsqrt_TB;

architecture rsqrt_TB_arch of rsqrt_TB is

signal w_bits : positive := 32;
signal F_bits : positive := 16;
signal N_iterations: positive;
signal clock_sig : std_logic;
signal x : std_logic_vector(w_bits-1 downto 0);
signal y : std_logic_vector(w_bits-1 downto 0);

component rsqrt is

	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16; -- number of fractional bits
		 N_iterations : positive := 3); -- number of Newton's iterations

	port (clock : in std_logic;
	      x : in std_logic_vector(w_bits-1 downto 0);
	      y: out std_logic_vector(w_bits-1 downto 0));

end component;


begin

rsqrt_main : rsqrt generic map (w_bits => w_bits, F_bits => F_bits, N_iterations => N_iterations)
		port map (clock => clock_sig, x => x, y => y);
					
clock_logic : process
	begin
	
	clock_sig <= not(clock_sig) after 1 ms;
	
	end process;

read_logic : process(clock_sig)

  file text_file : text open read_mode is "stim.txt";
  variable text_line : line;
	variable input : std_logic_vector(w_bits-1 downto 0);

begin

while not endfile(text_file) loop
 
  readline(text_file, text_line);
  
  HREAD(text_line, input);

	x <= input;
  
  end loop;
 

end process;


end architecture;
