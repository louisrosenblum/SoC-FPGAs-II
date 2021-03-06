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


alpha : process(x)

variable A : integer;
variable B : integer;
variable even : Boolean;
variable addr : std_logic_vector(6 downto 0);
variable Xa: ufixed(w_bits-F_bits-1 downto -F_bits);
variable Xb: ufixed(w_bits-F_bits-1 downto -F_bits);

begin

	if(rising_edge(clk)) then

	B := w_bits - F_bits - to_integer(unsigned(z)) - 1;

	if(B mod 2) = 0 then
		even := true;
	else
		even := false;
	end if;

	if(even = true) then
		A := -3/2*B;
	else
		A := -3/2*B + 1/2;
	end if;

	Xa := resize(x sll A,w_bits-F_bits-1,-F_bits);
		
	Xb := resize(x srl B,w_bits-F_bits-1,-F_bits);

	addr := to_std_logic_vector(resize(Xb(-1 downto -F_bits),-1,-7));

	address <= addr;
	even_sig <= even;
	Xa_sig <= Xa;
	
	end if;

end process;

bravo : process(clk)

variable lookup_fixed : ufixed(0 downto -F_bits);
variable lookup_wide : ufixed(w_bits-F_bits-1 downto -F_bits);

begin

	if(rising_edge(clk)) then

	lookup_fixed := to_ufixed(lookup,0,-F_bits);
	lookup_wide := resize(lookup_fixed,w_bits-F_bits-1,-F_bits);

	if(even_sig = true) then
		y <= resize(Xa_sig *lookup_wide,w_bits-F_bits-1,-F_bits);
	else
		y <= resize(Xa_sig *lookup_wide*0.0625,w_bits-F_bits-1,-F_bits);

	end if;

	end if;

end process;

end architecture;

