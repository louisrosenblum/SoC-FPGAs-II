-- y0.vhd

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

signal z : std_logic_vector(4 downto 0);
signal address : std_logic_vector(6 downto 0) := (others => 'U');
signal LUT_value: ufixed(w_bits-F_bits-1 downto -F_bits);
signal lookup : STD_LOGIC_VECTOR (F_bits DOWNTO 0);

signal A_sig : integer;
signal B_sig : integer;

signal Xa0: ufixed(w_bits-F_bits-1 downto -F_bits);
signal Xa1: ufixed(w_bits-F_bits-1 downto -F_bits);
signal Xa2: ufixed(w_bits-F_bits-1 downto -F_bits);

signal even_0 : Boolean;
signal even_1 : Boolean;
signal even_2 : Boolean;

signal x0 : ufixed(w_bits-F_bits-1 downto -F_bits);

signal addr0 : std_logic_vector(6 downto 0);
signal addr1 : std_logic_vector(6 downto 0);



begin

-- Use 1-port ROM LUT for -3/2 exponent operation
LUT : component ROM
	port map(address => address, clock => clk, q => lookup);

-- Component to determine number of leading zeros in a vector
lzc_main : component lzc
	port map(clk => clk, lzc_vector => to_std_logic_vector(x), lzc_count => z);


-- Begin initial guess calculation, generate address to check in LUT
alpha : process(clk)

variable A : sfixed(w_bits-F_bits-1 downto -F_bits);
variable B : sfixed(w_bits-F_bits-1 downto -F_bits);
variable even : Boolean;
variable addr : std_logic_vector(6 downto 0);
variable Xa: ufixed(w_bits-F_bits-1 downto -F_bits);
variable Xb: ufixed(w_bits-F_bits-1 downto -F_bits);

begin

	if(rising_edge(clk)) then

	x0 <= x;
	
	-- Ignore case at system startup
	if (to_integer(unsigned(z))>16) then

	else
	
	B := to_sfixed(W_bits - F_bits - to_integer(unsigned(z)) - 1,w_bits-F_bits-1,-F_bits);

	if(B(0) = '0') then
		even := true;
	else
		even := false;
	end if;

	if(even = true) then
		A := resize((1.5)*B,w_bits-F_bits-1,-F_bits);
	else
		A := resize((1.5)*B + 0.5,w_bits-F_bits-1,-F_bits);
	end if;

	Xa := x0 srl to_integer(A);
	Xb := x0 srl to_integer(B);

	addr := to_std_logic_vector(resize(Xb(-1 downto -F_bits),-1,-7));

	address <= addr;
	addr0 <= address;
	addr1 <= addr0;

	Xa0 <= Xa;
	Xa1 <= Xa0;
	Xa2 <= Xa1;

	even_0 <= even;
	even_1 <= even_0;
	even_2 <= even_1;

	end if;

	end if;

end process;


-- Register value from LUT in proper format
register_LUT: process(lookup)

variable lookup_check : STD_LOGIC_VECTOR (F_bits DOWNTO 0);
variable lookup_point : ufixed(0 downto -F_bits);

begin

	lookup_check := (others => '0');
	lookup_check(F_bits) := '1';

	if(lookup = lookup_check and addr0(0) = 'X') then
	
	else
		lookup_point := to_ufixed(lookup,0,-F_bits);
		LUT_value <= resize(lookup_point,w_bits-F_bits-1,-F_bits);

	end if;

end process;

-- Output initial guess to higher level entity
bravo: process(LUT_value)

begin

	if(even_2 = true) then
		y <= resize(Xa2 * LUT_value,w_bits-F_bits-1,-F_bits);
	else
		y <= resize(Xa2*LUT_value*0.7071067812,w_bits-F_bits-1,-F_bits);

	end if;

end process;

end architecture;

