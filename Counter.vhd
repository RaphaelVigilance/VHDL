----------------------------------------------------------------------------------
-- Company: Khon Kaen Univercity Electrinics System Engineer
-- Engineer: SOrayut Thongtaweephon
-- 
-- Create Date:    10:01:29 01/16/2026 
-- Design Name: 
-- Module Name:    Counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           led : out  STD_LOGIC_VECTOR (3 downto 0);
			  sevenseg : out STD_LOGIC_VECTOR (7 downto 0);
			  selsevenseg : out STD_LOGIC_VECTOR (5 downto 0)
			  );
end Counter;

architecture Behavioral of Counter is
	signal count: STD_LOGIC_VECTOR(3 downto 0);
	signal tmp: STD_LOGIC;
	signal cnt: natural range 0 to 25000000;
	signal clk1hz: STD_LOGIC;

begin
	clkdivider:process(clk,rst,tmp,cnt)
	begin
		if(rst='0')then
		tmp <= '0';
		cnt <= 0;
		else
		 if(rising_edge(clk)) then
			if(cnt = 2)then
				cnt <=0;
				tmp <= not tmp;
			else
				tmp <= tmp;
				cnt <= cnt + 1;
			end if;
		end if;
		end if;
	end process clkdivider;
		clk1hz <= tmp;


	counter: process(clk1hz,rst)
	begin
	if (rst='0')then
		count <= "0000";
	else
		if (rising_edge(clk1hz))then
			if(count = "1111")then
				count <= "0000";
			else
				count <= count+'1';
			end if;
		end if;
	end if;
	
	end process counter;
	led <= count;
	
	sevenseg7: process(count)
	begin
		case count is
			when "0000" => sevenseg <="11000000"; --0
			when "0001" => sevenseg <="11111001"; --1 
			when "0010" => sevenseg <="10100100"; --2
			when "0011" => sevenseg <="10110000"; --3
			when "0100" => sevenseg <="10011001"; --4
			when "0101" => sevenseg <="10010010"; --5
			when "0110" => sevenseg <="10000010"; --6
			when "0111" => sevenseg <="11111000"; --7
			when "1000" => sevenseg <="10000000"; --8
			when "1001" => sevenseg <="10010000"; --9
			when "1010" => sevenseg <="10001000"; --A
			when "1011" => sevenseg <="10000011"; --B
			when "1100" => sevenseg <="11000110"; --C
			when "1101" => sevenseg <="10100001"; --D	
			when "1110" => sevenseg <="10000110"; --E	
			when "1111" => sevenseg <="10001110"; --F
			when others => sevenseg <="11111111"; --F
		end case;
	end process sevenseg7;
	selsevenseg <= "111110";

end Behavioral;

