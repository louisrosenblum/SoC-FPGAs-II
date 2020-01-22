library IEEE;
use IEEE.std_logic_1164.all;

entity rsqrt is

	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16; -- number of fractional bits
		 N_iterations : positive := 3); -- number of Newton's iterations

	port (x : in std_logic_vector(w_bits-1 downto 0);
	      y: out std_logic_vector(w_bits-1 downto 0));

end entity rsqrt;

architecture rsqrt_arch of rsqrt is

signal clock : std_logic;
signal z : std_logic_vector(4 downto 0);
signal initial_guess : std_logic_vector(w_bits downto 1);

component lzc is
    port (
        clk        : in  std_logic;
        lzc_vector : in  std_logic_vector (31 downto 0);
        lzc_count  : out std_logic_vector ( 4 downto 0)
    );
end component;

component y0 is
	generic (w_bits : positive := 32; -- size of word
		 F_bits : positive := 16); -- number of fractional bits

	port(	clock: in std_logic;
		x_in : in std_logic_vector(w_bits-1 downto 0);
		z_in : in std_logic_vector(4 downto 0);
		guess: out std_logic_vector(w_bits downto 1));
end component;

begin

lzc0 : lzc port map (clk => clock, lzc_vector => x, lzc_count => z);

y0_main : y0 generic map (w_bits => w_bits, F_bits => F_bits)
		port map (clock => clock, x_in => x, z_in => z, guess => initial_guess);

end architecture;
