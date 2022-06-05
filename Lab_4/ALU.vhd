--------------------------------------------------------------------------------
--
-- LAB #4
--
--------------------------------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity ALU is
	Port(	DataIn1: in std_logic_vector(31 downto 0);
		DataIn2: in std_logic_vector(31 downto 0);
		ALUCtrl: in std_logic_vector(4 downto 0);
		Zero: out std_logic;
		ALUResult: out std_logic_vector(31 downto 0) );
end entity ALU;

architecture ALU_Arch of ALU is
	-- ALU components	
	component adder_subtracter
		port(	datain_a: in std_logic_vector(31 downto 0);
			datain_b: in std_logic_vector(31 downto 0);
			add_sub: in std_logic;
			dataout: out std_logic_vector(31 downto 0);
			co: out std_logic);
	end component adder_subtracter;

	component shift_register
		port(	datain: in std_logic_vector(31 downto 0);
		   	dir: in std_logic;
			shamt:	in std_logic_vector(4 downto 0);
			dataout: out std_logic_vector(31 downto 0));
	end component shift_register;

	SIGNAL instruct1: std_logic_vector(31 downto 0);
	SIGNAL instruct2: std_logic_vector(31 downto 0);
	SIGNAL instruct3: std_logic_vector(31 downto 0);
	SIGNAL instruct4: std_logic_vector(31 downto 0);
	SIGNAL instruct5: std_logic_vector(31 downto 0);
	SIGNAL instruct6: std_logic_vector(31 downto 0);
	SIGNAL instruct7: std_logic_vector(31 downto 0);

begin
	-- Add ALU VHDL implementation here
	add: adder_subtracter port map(DataIn1,DataIn2,'0', instruct1, Zero);	
	addi: adder_subtracter port map(DataIn1,DataIn2,'0', instruct2, Zero);
	sub: adder_subtracter port map(DataIn1,DataIn2,'1', instruct3, Zero);	
	sllcmd: shift_register port map(DataIn1, '0', DataIn2(4 downto 0), instruct4);	
	sllicmd: shift_register port map(DataIn1, '0', DataIn2(4 downto 0), instruct5);	
	srlcmd: shift_register port map(DataIn1, '1', DataIn2(4 downto 0), instruct6);	
	slricmd: shift_register port map(DataIn1, '1', DataIn2(4 downto 0), instruct7);	
	
		
	
	with ALUCtrl select 
	ALUResult <=    	instruct1 when "00000",
				instruct2 when "10001",
				instruct3 when "00010",
				DataIn1 or DataIn2 when "00011",
				DataIn1 or DataIn2 when "10100",
				DataIn1 and DataIn2 when "00101",
				DataIn1 and DataIn2 when "10110",
				instruct4 when "00111",
				instruct5 when "11000",
				instruct6 when "01001",
				instruct7 when "11010",
				X"00000000" when others;
				
end architecture ALU_Arch;


