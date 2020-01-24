library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity testbench is

	port(   input : in unsigned(7 downto 0);
			output: out unsigned(7 downto 0));

end entity;

architecture testbench_arch of testbench is

component add1 is
	port ( num : in unsigned(7 downto 0);
			sum : out unsigned(7 downto 0));
			
end component;

begin

adder_main : add1 port map(num => output, sum => input);


main : process

  file text_file : text open read_mode is "stim.txt";
  variable text_line : line;
  
  file write_file : text open write_mode is "output.txt";
  variable write_line : line;

begin

while not endfile(text_file) loop
 
  readline(text_file, text_line);
 
  -- Skip empty lines and single-line comments
  if text_line.all'length = 0 or text_line.all(1) = '#' then
    next;
  end if;
  
  output <= to_unsigned(test_line);
  
  wait 10 ns;
  
  end while;
  

end process;

write_out : process(input)
	file write_file : text open write_mode is "output.txt";
	variable write_line : line;
	
	begin
	
	write(write_line,input);
	writeline(write_file,write_line);

	end process;


end architecture;