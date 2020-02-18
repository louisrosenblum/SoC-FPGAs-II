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
signal address : std_logic_vector(6 downto 0) := (others => 'U');
signal LUT_value: STD_LOGIC_VECTOR (F_bits DOWNTO 0);
signal lookup : STD_LOGIC_VECTOR (F_bits DOWNTO 0) := (others => 'U');

signal A_sig : integer;
signal B_sig : integer;
signal even_sig : Boolean;
signal Xa_sig: ufixed(w_bits-F_bits-1 downto -F_bits);
signal Xb_sig: ufixed(w_bits-F_bits-1 downto -F_bits);

COMPONENT ROM IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (16 DOWNTO 0)
	);
END COMPONENT;

component lzc is
    port (
        clk        : in  std_logic;
        lzc_vector : in  std_logic_vector (31 downto 0);
        lzc_count  : out std_logic_vector ( 4 downto 0)
    );
end component;

begin

LUT : component ROM
	port map(address => address, clock => clk, q => lookup);

lzc_main : component lzc
	port map(clk => clk, lzc_vector => to_std_logic_vector(x), lzc_count => z);


alpha : process(clk)

begin

	if(rising_edge(clk)) then

	y <= resize(x+1,w_bits-F_bits-1,-F_bits);

	end if;

end process;

end architecture;

