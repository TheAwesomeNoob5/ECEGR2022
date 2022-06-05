--------------------------------------------------------------------------------
--
-- LAB #6 - Processor Elements
--
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BusMux2to1 is
	Port(	selector: in std_logic;
			In0, In1: in std_logic_vector(31 downto 0);
			Result: out std_logic_vector(31 downto 0) );
end entity BusMux2to1;

architecture selection of BusMux2to1 is
begin
-- Add your code here
	with selector select
		Result <= In0 when '0',
			  In1 when others;

end architecture selection;

--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Control is
      Port(clk : in  STD_LOGIC;
           opcode : in  STD_LOGIC_VECTOR (6 downto 0);
           funct3  : in  STD_LOGIC_VECTOR (2 downto 0);
           funct7  : in  STD_LOGIC_VECTOR (6 downto 0);
           Branch : out  STD_LOGIC_VECTOR(1 downto 0);
           MemRead : out  STD_LOGIC;
           MemtoReg : out  STD_LOGIC;
           ALUCtrl : out  STD_LOGIC_VECTOR(4 downto 0);
           MemWrite : out  STD_LOGIC;
           ALUSrc : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           ImmGen : out STD_LOGIC_VECTOR(1 downto 0));
end Control;

architecture Boss of Control is
signal Path: std_logic_vector(4 downto 0);
begin
-- Add your code here
	Path <=         "00000" when opcode = "0110011" and funct3= "000" and funct7 = "0000000" else	--add
			"00001" when opcode = "0110011" and funct3= "000" and funct7 = "0100000" else	--sub
			"10010" when opcode = "0010011" and funct3= "000" else	 			--addi
			"00011" when opcode = "0110011" and funct3= "110" and funct7 = "0000000"else	--or
			"10100" when opcode = "0010011" and funct3= "110"else 				--ori
			"00101" when opcode = "0110011" and funct3= "111" and funct7 = "0000000"else	--and
			"10110" when opcode = "0010011" and funct3= "000"else 				--andi
			"00111" when opcode = "0110011" and funct3= "001" and funct7 = "0000000"else	--sll
			"11000" when opcode = "0010011" and funct3= "001"else				--slli
			"01001" when opcode = "0110011" and funct3= "101" and funct7 = "0000000"else	--srl
			"11010" when opcode = "0010011" and funct3= "101" else				--srli
			"00001" when opcode = "1100011" else
			(OTHERS => 'Z');

	ALUCtrl <= Path;

	ImmGen <= 	"00" when Path(4) = '1' and (funct7 = "0000000" or opcode = "0110011") else
			"01" when Path(4) = '1' and opcode = "1100011" else
			"10" when Path(4) = '1' and (opcode = "0010011" or opcode = "0000011" or opcode = "0100011") else
			"11" when Path(4) = '1' and opcode = "0110111" else
			"00";
	
	Branch <= 	"10" when funct3 = "000" and funct7 = "1100011" else
			"01" when funct3 = "001" and funct7 = "1100011" else
			"00";

	MemRead <= 	'1' when opcode = "0000011" else
			'0';

	MemtoReg <= 	'0' when funct7 = "0000000" or opcode = "0010011" else	--rtype
			'1' when opcode = "0000011" else			-- lw
			'0'; 

	MemWrite <= 	'0' when opcode = "0000011" else	
			'1' when opcode = "0100011" else
			'0';

	RegWrite <= 	'0' when opcode = "0100011" else
			'1' when opcode = "0110011" or opcode = "0010011" or opcode = "0000011" else
			'0';

	ALUSrc <= 	'0' when opcode = "0110011" else 
			'1' when opcode = "0100011" or opcode = "0010011" or (opcode = "1100011" and funct3 = "000") else 
			'0';
	
			
			
			
end Boss;

--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ProgramCounter is
    Port(Reset: in std_logic;
	 Clock: in std_logic;
	 PCin: in std_logic_vector(31 downto 0);
	 PCout: out std_logic_vector(31 downto 0));
end entity ProgramCounter;

architecture executive of ProgramCounter is
begin
-- Add your code here
	programCount: process(Reset,Clock)
		begin 
		if Reset = '1' then
			PCout <= X"00400000";
		end if;
		if rising_edge(Clock) then
			PCout <= PCin;
		end if;
	end process;
	
end executive;
--------------------------------------------------------------------------------
