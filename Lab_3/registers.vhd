--------------------------------------------------------------------------------
--
-- LAB #3
--
--------------------------------------------------------------------------------

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity bitstorage is
	port(bitin: in std_logic;
		 enout: in std_logic;
		 writein: in std_logic;
		 bitout: out std_logic);
end entity bitstorage;

architecture memlike of bitstorage is
	signal q: std_logic := '0';
begin
	process(writein) is
	begin
		if (rising_edge(writein)) then
			q <= bitin;
		end if;
	end process;
	
	-- Note that data is output only when enout = 0	
	bitout <= q when enout = '0' else 'Z';
end architecture memlike;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity fulladder is
    port (a : in std_logic;
          b : in std_logic;
          cin : in std_logic;
          sum : out std_logic;
          carry : out std_logic
         );
end fulladder;

architecture addlike of fulladder is
begin
  sum   <= a xor b xor cin; 
  carry <= (a and b) or (a and cin) or (b and cin); 
end architecture addlike;


--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register8 is
	port(datain: in std_logic_vector(7 downto 0);
	     enout:  in std_logic;
	     writein: in std_logic;
	     dataout: out std_logic_vector(7 downto 0));
end entity register8;

architecture memmy of register8 is
	component bitstorage
		port(bitin: in std_logic;
		 	 enout: in std_logic;
		 	 writein: in std_logic;
		 	 bitout: out std_logic);
	end component;
begin
	-- insert your code here.
	S0: bitstorage port map(datain(0), enout, writein, dataout(0));
	S1: bitstorage port map(datain(1), enout, writein, dataout(1));
	S2: bitstorage port map(datain(2), enout, writein, dataout(2));
	S3: bitstorage port map(datain(3), enout, writein, dataout(3));
	S4: bitstorage port map(datain(4), enout, writein, dataout(4));
	S5: bitstorage port map(datain(5), enout, writein, dataout(5));
	S6: bitstorage port map(datain(6), enout, writein, dataout(6));
	S7: bitstorage port map(datain(7), enout, writein, dataout(7));

	
end architecture memmy;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register32 is
	port(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;	--active low
		 writein32, writein16, writein8: in std_logic;	--active high
		 dataout: out std_logic_vector(31 downto 0));
end entity register32;

architecture biggermem of register32 is
	-- hint: you'll want to put register8 as a component here 
	-- so you can use it below
	component register8 
		port(datain: in std_logic_vector(7 downto 0);
	   	  enout:  in std_logic;
	  	  writein: in std_logic;
	   	  dataout: out std_logic_vector(7 downto 0));
	end component;

	signal enable: std_logic_vector(2 downto 0);
	signal wrote: std_logic_vector(2 downto 0);
	signal enable2: std_logic_vector(3 downto 0);
	signal wrote2: std_logic_vector(3 downto 0);
begin
	-- insert code here.
	-- need to write 3 enables for enout and writein with 3 bits
	-- then concatenate enout and writein 
	-- make four signals
	-- make port map for register8
	enable <= enout32 & enout16 & enout8;
	wrote <= writein32 & writein16 & writein8;
	
	with enable select
	enable2 <= 	"0000" when "011",
			"1100" when "101",
			"1110" when "110",
			"1111" when others;
	
	with wrote select
	wrote2 <= 	"0001" when "001",
			"0011" when "010",
			"1111" when "100",
			"0000" when others;

	P1: register8 port  map (datain(31 downto 24), enable2(3),wrote2(3), dataout(31 downto 24)); 
	P2: register8 port  map (datain(23 downto 16), enable2(2),wrote2(2), dataout(23 downto 16)); 
	P3: register8 port  map (datain(15 downto 8), enable2(1),wrote2(1), dataout(15 downto 8)); 
	P4: register8 port  map (datain(7 downto 0), enable2(0),wrote2(0), dataout(7 downto 0)); 
end architecture biggermem;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity adder_subtracter is
	port(	datain_a: in std_logic_vector(31 downto 0);
		datain_b: in std_logic_vector(31 downto 0);
		add_sub: in std_logic;
		dataout: out std_logic_vector(31 downto 0);
		co: out std_logic);
end entity adder_subtracter;

architecture calc of adder_subtracter is

	component fulladder is 
	port( 	 a : in std_logic;
       	 	 b : in std_logic;
          	 cin : in std_logic;
         	 sum : out std_logic;
         	 carry : out std_logic
        	 );
	end component;

signal C: std_logic_vector(31 downto 0);
signal B_hold: std_logic_vector(31 downto 0);

begin
	-- insert code here.
	with add_sub select
		B_hold <= datain_b when '0',
			  not datain_b when others;

	AS0: fulladder port map(datain_a(0),B_hold(0), add_sub, dataout(0), C(0) );
	GEN_ADD: for I in 31 downto 1 generate
		ASI: fulladder port map( datain_a(I), B_hold(I), C(I-1), dataout(I), C(I) );
	END GENERATE;
	co <= C(31);
end architecture calc;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity shift_register is
	port(	datain: in std_logic_vector(31 downto 0);
	   	dir: in std_logic;
		shamt:	in std_logic_vector(4 downto 0);
		dataout: out std_logic_vector(31 downto 0));
end entity shift_register;

architecture shifter of shift_register is
	
begin
	-- insert code here.
	with dir & shamt (3 downto 0) select
	dataout <=	datain(30 downto 0) & '0' when "00001",
			datain(29 downto 0) & "00" when "00010",
		   	datain(28 downto 0) & "000" when "00011",
		   	'0' & datain(31 downto 1)  when "10001",
			"00" & datain(31 downto 2)  when "10010",
			"000" & datain(31 downto 3)  when "10011",
			datain when others;
end architecture shifter;



