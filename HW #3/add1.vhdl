library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity add1 is
	port ( num : in unsigned(7 downto 0);
			sum : out unsigned(7 downto 0));
			
end entity;

architecture add1_arch of add is


begin


main : process(num)

begin
	sum <= to_unsigned(num) + 1;
	
end process;

end architecture;