----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:38:29 12/18/2014 
-- Design Name: 
-- Module Name:    Trigger_generator - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Trigger_generator is
    Port ( clk : in  STD_LOGIC;
           Trigger : out  STD_LOGIC);
end Trigger_generator;

architecture Behavioral of Trigger_generator is
component Counter is
	generic(n: POSITIVE := 10);
	Port(clk: in STD_LOGIC;
		  enable : in STD_LOGIC;
		  reset : in STD_LOGIC;
		  Counter_output : out STD_LOGIC_VECTOR(n-1 downto 0));
end component;
signal resetCounter : STD_LOGIC;
signal outputCounter : STD_LOGIC_VECTOR(23 downto 0);  		  
		  
begin

	trigg: Counter generic map (24) port map(clk,'1',resetCounter,outputCounter);
	process(clk)
	constant ms250 : STD_LOGIC_VECTOR(23 downto 0) := "101111101011110000100000";
	constant ms250And100us: STD_LOGIC_VECTOR(23 downto 0):="101111101100111110101000";

		begin
			if(outputCounter > ms250 and outputCounter < ms250And100us) then
					trigger <= '1';
			else
					trigger <='0';
			
			end if;
			
			if(outputCounter = ms250And100us or outputCounter = "XXXXXXXXXXXXXXXXXXXXXXXX") then 
				resetCounter <= '0';
			else 
				resetCounter <='1';
			end if;	
	end process;



end Behavioral;

