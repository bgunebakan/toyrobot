----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:59:18 12/18/2014 
-- Design Name: 
-- Module Name:    Range_sensor - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Range_sensor is
    Port ( fpgaclk : in  STD_LOGIC;
           pulse : in  STD_LOGIC;
           triggerOut : out  STD_LOGIC;
           meters : out  STD_LOGIC_VECTOR (3 downto 0);
           decimeters : out  STD_LOGIC_VECTOR (3 downto 0);
           centimeters : out  STD_LOGIC_VECTOR (3 downto 0));
end Range_sensor;

architecture Behavioral of Range_sensor is

component  Distance_calculation is 
	Port(clk :in STD_LOGIC;
		  Calculation_Reset : in STD_LOGIC;
		  pulse: in STD_LOGIC;
		  distance: out STD_LOGIC_VECTOR(8 downto 0));
end component;


component Trigger_generator is 
	Port(clk: in STD_LOGIC;
		  trigger: out STD_LOGIC);
end component;

component BCD_converter is
	Port (Distance_input: in STD_LOGIC_VECTOR(8 downto 0);
			hundreds: out STD_LOGIC_VECTOR(3 downto 0);
			tens: out STD_LOGIC_VECTOR(3 downto 0);
			unit: out STD_LOGIC_VECTOR(3 downto 0));
end component;

signal distanceOut: STD_LOGIC_VECTOR(8 downto 0);
signal triggOut: STD_LOGIC;
 			

begin

trigger_gen: trigger_generator port map(fpgaclk,triggOut);
Pulsewidth: distance_Calculation port map(fpgaclk,triggOut,pulse,distanceOut);
BCDConv:bcd_converter port map(distanceOut,meters,decimeters,centimeters);
triggerOut <= triggOut;


end Behavioral;

