library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

library ieee_proposed;
use ieee_proposed.fixed_pkg.all;

library std;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity testbench is

end entity;

architecture testbench_arch of testbench is

signal input : unsigned(7 downto 0);
signal output : unsigned(7 downto 0);


component newton_block is
end component;

begin


main : process

  file text_file : text open read_mode is "stim.txt";
  variable text_line : line;
  
  variable int : integer;

begin

while not endfile(text_file) loop
 
  readline(text_file, text_line);
 

  read(text_line,int);
  
  input <= to_unsigned(int,8);
  
  wait for 10ms;
  
  end loop;
  
	wait;

end process;

write_out : process(output)
	file write_file : text open write_mode is "output.txt";
	variable write_line : line;
	
	begin
	
	if(to_integer(output) = 0) then

	else
		write(write_line,to_integer(output));
		writeline(write_file,write_line);
	
	end if;

	end process;


end architecture;