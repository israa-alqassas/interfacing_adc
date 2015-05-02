-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

  ENTITY InterfaceTB IS
  END InterfaceTB;

  ARCHITECTURE behavior OF InterfaceTB IS 

  -- Component Declaration
          COMPONENT FPGA_ADC_Interface
          PORT(
      
		Rest:  in  STD_LOGIC;
		En:  in  STD_LOGIC;
      CLK_IN_P  : in  STD_LOGIC;
      CLK_IN_N  : in  STD_LOGIC;
      CLK_OUT : out STD_LOGIC;
      Din_P       : in STD_LOGIC_VECTOR(11 downto 0);
      Din_N       : in STD_LOGIC_VECTOR(11 downto 0));
                 
          END COMPONENT;
			 
--Signal Declaration
      signal Rest:  STD_LOGIC := '0';
		signal En:  STD_LOGIC:= '0';
      signal  CLK_IN_P  : STD_LOGIC:= '0';
      signal CLK_IN_N  :  STD_LOGIC:= '0';
      signal Din_P       : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
      signal Din_N       : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');		
		
--Outputs
		
		signal CLK_OUT : STD_LOGIC;

-- Clock period definitions
   constant Clk_period : time := 10 ns;      

  BEGIN

  -- Component Instantiation
          uut: FPGA_ADC_Interface PORT MAP(
			 Rest =>Rest,
            En => En,
                  CLK_IN_P => CLK_IN_P,
						CLK_IN_N => CLK_IN_N,
						Din_P => Din_P,
						Din_N => Din_N,
						CLK_OUT => CLK_OUT
          );


  --  Test Bench Statements
  
  
  -- Clock process definitions
   Clk_process :process
   begin
	   CLK_IN_P <= '0';
		CLK_IN_N <= '1';
		wait for Clk_period/2;
		CLK_IN_P <= '1';
		CLK_IN_N <= '0';
	   wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   
	Reset_process :process
   begin
		rest <= '1';
		wait for clk_period*5;
		rest <= '0';
		wait;  
   end process;
	
	--Enable Process
	
	Enable_process :process
   begin
      En <= '0';
		wait for clk_period*2;
		En <= '1';
		wait; 
   end process;
	
	--Input Process
	Din_P_process :process
   begin
		Din_P <= Din_P + 1;
		wait for clk_period/2; 
   end process;


Din_N_process :process
   begin
		Din_N <= Din_N + 2;
		wait for clk_period/2; 
   end process;

END;
