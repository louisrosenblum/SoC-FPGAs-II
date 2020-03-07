-- rsqrt_TB.vhd

library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;
use ieee_proposed.standard_textio_additions.all;

library std;
use STD.textio.all;
use ieee.std_logic_textio.all;

-- Louis Rosenblum
-- 02/04/2020

entity rsqrt_TB is
	generic (w_bits : positive := 32; -- Size of word
		 F_bits : positive := 16; -- Number of fractional bits
		N_iterations : positive := 3); -- Number of Newton's iterations
end entity;

architecture rsqrt_TB_arch of rsqrt_TB is

component rsqrt is
	generic (w_bits : positive := 32; -- Size of word
		 F_bits : positive := 16; -- Number of fractional bits
		N_iterations : positive := 3); -- Number of Newton's iterations

	port (  clk : in std_logic;
		x : in ufixed(w_bits-F_bits-1 downto -F_bits);
		y : out ufixed(w_bits-F_bits-1 downto -F_bits));
	
end component;

signal y : ufixed(w_bits-F_bits-1 downto -F_bits); -- Output signal
signal x : ufixed(w_bits-F_bits-1 downto -F_bits); -- Input signal
signal clk : std_logic := '0'; -- Clock signal

signal count : integer := 0;

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

-- Read stimulus inputs from text file
while not endfile(text_file) loop

 
  readline(text_file, text_line);
 
	read(text_line,data_fixed);

	x <= data_fixed;

	clk <= not clk;

	wait for 100 us;

	clk <= not clk;

	wait for 100 us;
  
  end loop;

	clk <= not clk;
	wait for 100 us;



end process;

-- Write outputs to text file
write_out : process(clk)



	

	variable zero : ufixed(w_bits-F_bits-1 downto -F_bits);

	file write_file : text open write_mode is "output.txt";
	variable write_line : line;
	
	begin

	if(rising_edge(clk)) then

	if(count < 5000) then

	zero := (others => '0');

	if(y(1) = 'U') or (y(1) = 'X') then

	elsif(y = zero) then

	else

	count <= count +1;

	write(write_line,y);
	writeline(write_file,write_line);
	
	end if;

	

	end if;

	else

	end if;

	end process;

end architecture;

