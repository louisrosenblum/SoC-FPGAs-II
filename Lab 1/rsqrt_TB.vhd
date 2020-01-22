library IEEE;
use IEEE.std_logic_1164.all;

entity rsqrt_TB is
	
	generic (w_bits : positive := 32; -- size of word
	F_bits : positive := 16; -- number of fractional bits
	N_iterations : positive := 3); -- number of Newton's iterations

	port(clock : out std_logic;
			x : out std_logic_vector(w_bits downto 1);
			y: in std_logic_vector(w_bits downto 1);)

end entity rsqrt_TB;

architecture rsqrt_TB_arch of rsqrt_TB is

signal clock_sig : std_logic;

component rsqrt is

	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16; -- number of fractional bits
		 N_iterations : positive := 3); -- number of Newton's iterations

	port (clock : in std_logic;
		  x : in std_logic_vector(w_bits-1 downto 0);
	      y: out std_logic_vector(w_bits-1 downto 0));

end component;


begin

rsqrt_main : rsqrt generic map (w_bits => w_bits, F_bits => F_bits, N_iterations => N_iterations);
					port map (clock => clock, x => x, y => y);
					
main : process
	begin
	
	clock <= not(clock) after 1 ms;
	
	end process;

end architecture;
