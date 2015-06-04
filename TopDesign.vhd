----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:11:22 12/18/2014 
-- Design Name: 
-- Module Name:    TopDesign - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopDesign is
    Port ( pulse_pin : in  STD_LOGIC;
           Trigger_pin : out  STD_LOGIC;
           clk : in  STD_LOGIC;
           topselDispA : out  STD_LOGIC;
           topselDispB : out  STD_LOGIC;
           topselDispC : out  STD_LOGIC;
           topselDispD : out  STD_LOGIC;
           topsegA : out  STD_LOGIC;
           topsegB : out  STD_LOGIC;
           topsegC : out  STD_LOGIC;
           topsegD : out  STD_LOGIC;
           topsegE : out  STD_LOGIC;
           topsegF : out  STD_LOGIC;
           topsegG : out  STD_LOGIC);

end TopDesign;

architecture Behavioral of TopDesign is
component Range_sensor 
port(

		fpgaclk : in STD_LOGIC;
		triggerOut : out STD_LOGIC;
		pulse: in STD_LOGIC;
		meters: out STD_LOGIC_VECTOR(3 DOWNTO 0);
		decimeters : out STD_LOGIC_VECTOR(3 DOWNTO 0);
		centimeters : out STD_LOGIC_VECTOR(3 DOWNTO 0)
);
end component;

component segmentdriver
	Port(
		
			display_A: in STD_LOGIC_VECTOR (3 DOWNTO 0);
			display_B: in STD_LOGIC_VECTOR (3 DOWNTO 0);
			display_C: in STD_LOGIC_VECTOR (3 DOWNTO 0);
			display_D: in STD_LOGIC_VECTOR (3 DOWNTO 0);
	
			segA: out STD_LOGIC;
			segB: out STD_LOGIC;
			segC: out STD_LOGIC;
			segD: out STD_LOGIC;
			segE: out STD_LOGIC;
			segF: out STD_LOGIC;
			segG: out STD_LOGIC;
	
			select_Display_A: out STD_LOGIC;
			select_Display_B: out STD_LOGIC;
			select_Display_C: out STD_LOGIC;
			select_Display_D: out STD_LOGIC;
			
			clk: in STD_LOGIC	

);

end component;

SIGNAL Ai : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL Bi : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL Ci : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL Di : STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL sensor_meters :STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL sensor_decimeters :STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL sensor_centimeters :STD_LOGIC_VECTOR(3 DOWNTO 0); 

begin

uut2: segmentDriver PORT MAP(
			
			display_A=>Ai,
			display_B=>Bi,
			display_C=>Ci,
			display_D=>Di,
			segA => topsegA,
			segB => topsegB,
			segC => topsegC,
			segD => topsegD,
			segE => topsegE,
			segF => topsegF,
			segG => topsegG,			
			select_Display_A => topselDispA, 
			select_Display_B => topselDispB, 
			select_Display_C => topselDispC,
			select_Display_D => topselDispD,
			clk => clk
			);

uut4: Range_sensor PORT MAP(
		fpgaclk => clk,
		triggerOut => Trigger_pin,
		pulse => pulse_pin,
		meters => sensor_meters,
		decimeters=> sensor_decimeters,
		centimeters=> sensor_centimeters
		
);			
			Ai <= sensor_centimeters;
			Bi <= sensor_decimeters;
			Ci <= sensor_meters;
			Di <="0000";
			
end Behavioral;

