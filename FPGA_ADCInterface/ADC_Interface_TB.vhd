--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:51:18 04/30/2015
-- Design Name:   
-- Module Name:   C:/Xilinx/FPGA_ADCInterface/ADC_Interface_TB.vhd
-- Project Name:  FPGA_ADCInterface
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ADC_FPGA_Interface
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ADC_Interface_TB IS
END ADC_Interface_TB;
 
ARCHITECTURE behavior OF ADC_Interface_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ADC_FPGA_Interface
    PORT(
         Rest : IN  std_logic;
         En : IN  std_logic;
         CLK_IN_P : IN  std_logic;
         CLK_IN_N : IN  std_logic;
         CLK_OUT : OUT  std_logic;
         Din_P : IN  std_logic_vector(11 downto 0);
         Din_N : IN  std_logic_vector(11 downto 0);
         Dout_R : OUT  std_logic_vector(11 downto 0);
         Dout_F : OUT  std_logic_vector(11 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Rest : std_logic := '0';
   signal En : std_logic := '0';
   signal CLK_IN_P : std_logic := '0';
   signal CLK_IN_N : std_logic := '0';
   signal Din_P : std_logic_vector(11 downto 0) := (others => '0');
   signal Din_N : std_logic_vector(11 downto 0) := (others => '0');

 	--Outputs
   signal CLK_OUT : std_logic;
   signal Dout_R : std_logic_vector(11 downto 0);
   signal Dout_F : std_logic_vector(11 downto 0);

   -- Clock period definitions
   --constant CLK_IN_P_period : time := 10 ns;
   --constant CLK_IN_N_period : time := 10 ns;
   --constant CLK_OUT_period : time := 10 ns;
	constant CLK_period : time := 10 ns;
 
 ---------------------------------------------------------------------------------------------------------
 ----------------------------------Detailed Test----------------------------------------------------------
 ---------------------------------------------------------------------------------------------------------
signal BUFOUT_clk : STD_LOGIC;
signal BUFOUT_D0 : STD_LOGIC;
signal BUFOUT_D1 : STD_LOGIC;
signal BUFOUT_D2 : STD_LOGIC;
signal BUFOUT_D3 : STD_LOGIC;
signal BUFOUT_D4 : STD_LOGIC;
signal BUFOUT_D5 : STD_LOGIC;
signal BUFOUT_D6 : STD_LOGIC;
signal BUFOUT_D7 : STD_LOGIC;
signal BUFOUT_D8 : STD_LOGIC;
signal BUFOUT_D9 : STD_LOGIC;
signal BUFOUT_D10 : STD_LOGIC;
signal BUFOUT_D11 : STD_LOGIC;
signal IDDROUT_DP : STD_LOGIC_VECTOR(11 downto 0);
signal IDDROUT_DN : STD_LOGIC_VECTOR(11 downto 0);

signal ce: STD_LOGIC;
signal reset: STD_LOGIC;
--signal set: STD_LOGIC;
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ADC_FPGA_Interface PORT MAP (
          Rest => Rest,
          En => En,
          CLK_IN_P => CLK_IN_P,
          CLK_IN_N => CLK_IN_N,
          CLK_OUT => CLK_OUT,
          Din_P => Din_P,
          Din_N => Din_N,
          Dout_R => Dout_R,
          Dout_F => Dout_F
        );


------------------------------------------------------------------------------------------------------------------
IBUFGDS_inst : IBUFGDS
generic map (
DIFF_TERM => TRUE, -- Differential Termination
IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
IOSTANDARD => "DEFAULT")
port map (
O => BUFOUT_clk, -- Clock buffer output
I => CLK_IN_P, -- Diff_p clock buffer input (connect directly to top-level port)
IB => CLK_IN_N -- Diff_n clock buffer input (connect directly to top-level port)
);
-- End of IBUFGDS_inst instantiation


IBUFDS_inst1 : IBUFDS
generic map (
             DIFF_TERM => TRUE, -- Differential Termination
             IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
             IOSTANDARD => "DEFAULT")
port map (
          O => BUFOUT_D0, -- Buffer output
          I => Din_P(0), -- Diff_p buffer input (connect directly to top-level port)
          IB => Din_N(0) -- Diff_n buffer input (connect directly to top-level port)
          );
-- End of IBUFDS_inst instantiation


IBUFDS_inst2 : IBUFDS
generic map (
             DIFF_TERM => TRUE, -- Differential Termination
             IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
             IOSTANDARD => "DEFAULT")
port map (
          O => BUFOUT_D1, -- Buffer output
          I => Din_P(1), -- Diff_p buffer input (connect directly to top-level port)
          IB => Din_N(1) -- Diff_n buffer input (connect directly to top-level port)
          );
-- End of IBUFDS_inst instantiation

IBUFDS_inst3 : IBUFDS
generic map (
             DIFF_TERM => TRUE, -- Differential Termination
             IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
             IOSTANDARD => "DEFAULT")
port map (
          O => BUFOUT_D2, -- Buffer output
          I => Din_P(2), -- Diff_p buffer input (connect directly to top-level port)
          IB => Din_N(2) -- Diff_n buffer input (connect directly to top-level port)
          );
-- End of IBUFDS_inst instantiation


IBUFDS_inst4 : IBUFDS
generic map (
             DIFF_TERM => TRUE, -- Differential Termination
             IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
             IOSTANDARD => "DEFAULT")
port map (
          O => BUFOUT_D3, -- Buffer output
          I => Din_P(3), -- Diff_p buffer input (connect directly to top-level port)
          IB => Din_N(3) -- Diff_n buffer input (connect directly to top-level port)
          );
-- End of IBUFDS_inst instantiation

-- IDDR: Double Data Rate Input Register with Set, Reset

IBUFDS_inst5 : IBUFDS
generic map (
             DIFF_TERM => TRUE, -- Differential Termination
             IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
             IOSTANDARD => "DEFAULT")
port map (
          O => BUFOUT_D4, -- Buffer output
          I => Din_P(4), -- Diff_p buffer input (connect directly to top-level port)
          IB => Din_N(4) -- Diff_n buffer input (connect directly to top-level port)
          );
-- End of IBUFDS_inst instantiation

IBUFDS_inst6 : IBUFDS
generic map (
             DIFF_TERM => TRUE, -- Differential Termination
             IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
             IOSTANDARD => "DEFAULT")
port map (
          O => BUFOUT_D5, -- Buffer output
          I => Din_P(5), -- Diff_p buffer input (connect directly to top-level port)
          IB => Din_N(5) -- Diff_n buffer input (connect directly to top-level port)
          );
-- End of IBUFDS_inst instantiation

IBUFDS_inst7 : IBUFDS
generic map (
             DIFF_TERM => TRUE, -- Differential Termination
             IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
             IOSTANDARD => "DEFAULT")
port map (
          O => BUFOUT_D6, -- Buffer output
          I => Din_P(6), -- Diff_p buffer input (connect directly to top-level port)
          IB => Din_N(6)-- Diff_n buffer input (connect directly to top-level port)
          );
-- End of IBUFDS_inst instantiation


IBUFDS_inst8 : IBUFDS
generic map (
             DIFF_TERM => TRUE, -- Differential Termination
             IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
             IOSTANDARD => "DEFAULT")
port map (
          O => BUFOUT_D7, -- Buffer output
          I => Din_P(7), -- Diff_p buffer input (connect directly to top-level port)
          IB => Din_N(7) -- Diff_n buffer input (connect directly to top-level port)
          );
-- End of IBUFDS_inst instantiation

IBUFDS_inst9 : IBUFDS
generic map (
             DIFF_TERM => TRUE, -- Differential Termination
             IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
             IOSTANDARD => "DEFAULT")
port map (
          O => BUFOUT_D8, -- Buffer output
          I => Din_P(8), -- Diff_p buffer input (connect directly to top-level port)
          IB => Din_N(8) -- Diff_n buffer input (connect directly to top-level port)
          );
-- End of IBUFDS_inst instantiation


IBUFDS_inst10 : IBUFDS
generic map (
             DIFF_TERM => TRUE, -- Differential Termination
             IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
             IOSTANDARD => "DEFAULT")
port map (
          O => BUFOUT_D9, -- Buffer output
          I => Din_P(9), -- Diff_p buffer input (connect directly to top-level port)
          IB => Din_N(9) -- Diff_n buffer input (connect directly to top-level port)
          );
-- End of IBUFDS_inst instantiation

IBUFDS_inst11 : IBUFDS
generic map (
             DIFF_TERM => TRUE, -- Differential Termination
             IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
             IOSTANDARD => "DEFAULT")
port map (
          O => BUFOUT_D10, -- Buffer output
          I => Din_P(10), -- Diff_p buffer input (connect directly to top-level port)
          IB => Din_N(10) -- Diff_n buffer input (connect directly to top-level port)
          );
-- End of IBUFDS_inst instantiation

IBUFDS_inst12 : IBUFDS
generic map (
             DIFF_TERM => TRUE, -- Differential Termination
             IBUF_LOW_PWR => TRUE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
             IOSTANDARD => "DEFAULT")
port map (
          O => BUFOUT_D11, -- Buffer output
          I => Din_P(11), -- Diff_p buffer input (connect directly to top-level port)
          IB => Din_N(11) -- Diff_n buffer input (connect directly to top-level port)
          );
-- End of IBUFDS_inst instantiation


IDDR_inst1 : IDDR
generic map (
             DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE", "SAME_EDGE"
             -- or "SAME_EDGE_PIPELINED"
             INIT_Q1 => '0', -- Initial value of Q1: '0' or '1'
             INIT_Q2 => '0', -- Initial value of Q2: '0' or '1'
             SRTYPE => "ASYNC") -- Set/Reset type: "SYNC" or "ASYNC"
port map (
          Q1 => IDDROUT_DP(0), -- 1-bit output for positive edge of clock
          Q2 => IDDROUT_DN(0), -- 1-bit output for negative edge of clock
          C => BUFOUT_clk, -- 1-bit clock input
          CE => ce, -- 1-bit clock enable input
          D => BUFOUT_D0, -- 1-bit DDR data input
          R => Rest -- 1-bit reset
          --S => set -- 1-bit set
          );
-- End of IDDR_inst instantiation

IDDR_inst2 : IDDR
generic map (
             DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE", "SAME_EDGE"
             -- or "SAME_EDGE_PIPELINED"
             INIT_Q1 => '0', -- Initial value of Q1: '0' or '1'
             INIT_Q2 => '0', -- Initial value of Q2: '0' or '1'
             SRTYPE => "ASYNC") -- Set/Reset type: "SYNC" or "ASYNC"
port map (
          Q1 => IDDROUT_DP(1), -- 1-bit output for positive edge of clock
          Q2 => IDDROUT_DN(1), -- 1-bit output for negative edge of clock
          C => BUFOUT_clk, -- 1-bit clock input
          CE => ce, -- 1-bit clock enable input
          D => BUFOUT_D1, -- 1-bit DDR data input
          R => reset -- 1-bit reset
          --S => set -- 1-bit set
          );
-- End of IDDR_inst instantiation

IDDR_inst3 : IDDR
generic map (
             DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE", "SAME_EDGE"
             -- or "SAME_EDGE_PIPELINED"
             INIT_Q1 => '0', -- Initial value of Q1: '0' or '1'
             INIT_Q2 => '0', -- Initial value of Q2: '0' or '1'
             SRTYPE => "ASYNC") -- Set/Reset type: "SYNC" or "ASYNC"
port map (
          Q1 => IDDROUT_DP(2), -- 1-bit output for positive edge of clock
          Q2 => IDDROUT_DN(2), -- 1-bit output for negative edge of clock
          C => BUFOUT_clk, -- 1-bit clock input
          CE => ce, -- 1-bit clock enable input
          D => BUFOUT_D2, -- 1-bit DDR data input
          R => reset -- 1-bit reset
          --S => set -- 1-bit set
          );
-- End of IDDR_inst instantiation

IDDR_inst4 : IDDR
generic map (
             DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE", "SAME_EDGE"
             -- or "SAME_EDGE_PIPELINED"
             INIT_Q1 => '0', -- Initial value of Q1: '0' or '1'
             INIT_Q2 => '0', -- Initial value of Q2: '0' or '1'
             SRTYPE => "ASYNC") -- Set/Reset type: "SYNC" or "ASYNC"
port map (
          Q1 => IDDROUT_DP(3), -- 1-bit output for positive edge of clock
          Q2 => IDDROUT_DN(3), -- 1-bit output for negative edge of clock
          C => BUFOUT_clk, -- 1-bit clock input
          CE => ce, -- 1-bit clock enable input
          D => BUFOUT_D3, -- 1-bit DDR data input
          R => reset -- 1-bit reset
          --S => set -- 1-bit set
          );
-- End of IDDR_inst instantiation

IDDR_inst5 : IDDR
generic map (
             DDR_CLK_EDGE =>"SAME_EDGE", -- "OPPOSITE_EDGE", "SAME_EDGE"
             -- or "SAME_EDGE_PIPELINED"
             INIT_Q1 => '0', -- Initial value of Q1: '0' or '1'
             INIT_Q2 => '0', -- Initial value of Q2: '0' or '1'
             SRTYPE => "ASYNC") -- Set/Reset type: "SYNC" or "ASYNC"
port map (
          Q1 => IDDROUT_DP(4), -- 1-bit output for positive edge of clock
          Q2 => IDDROUT_DN(4), -- 1-bit output for negative edge of clock
          C => BUFOUT_clk, -- 1-bit clock input
          CE => ce, -- 1-bit clock enable input
          D => BUFOUT_D4, -- 1-bit DDR data input
          R => reset -- 1-bit reset
          --S => set -- 1-bit set
          );
-- End of IDDR_inst instantiation

IDDR_inst6 : IDDR
generic map (
             DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE", "SAME_EDGE"
             -- or "SAME_EDGE_PIPELINED"
             INIT_Q1 => '0', -- Initial value of Q1: '0' or '1'
             INIT_Q2 => '0', -- Initial value of Q2: '0' or '1'
             SRTYPE => "ASYNC") -- Set/Reset type: "SYNC" or "ASYNC"
port map (
          Q1 => IDDROUT_DP(5), -- 1-bit output for positive edge of clock
          Q2 => IDDROUT_DN(5), -- 1-bit output for negative edge of clock
          C => BUFOUT_clk, -- 1-bit clock input
          CE => ce, -- 1-bit clock enable input
          D => BUFOUT_D5, -- 1-bit DDR data input
          R => reset -- 1-bit reset
          --S => set -- 1-bit set
          );
-- End of IDDR_inst instantiation

IDDR_inst7 : IDDR
generic map (
             DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE", "SAME_EDGE"
             -- or "SAME_EDGE_PIPELINED"
             INIT_Q1 => '0', -- Initial value of Q1: '0' or '1'
             INIT_Q2 => '0', -- Initial value of Q2: '0' or '1'
             SRTYPE => "ASYNC") -- Set/Reset type: "SYNC" or "ASYNC"
port map (
          Q1 => IDDROUT_DP(6), -- 1-bit output for positive edge of clock
          Q2 => IDDROUT_DN(6), -- 1-bit output for negative edge of clock
          C => BUFOUT_clk, -- 1-bit clock input
          CE => ce, -- 1-bit clock enable input
          D => BUFOUT_D6, -- 1-bit DDR data input
          R => reset -- 1-bit reset
          --S => set -- 1-bit set
          );
-- End of IDDR_inst instantiation

IDDR_inst8 : IDDR
generic map (
             DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE", "SAME_EDGE"
             -- or "SAME_EDGE_PIPELINED"
             INIT_Q1 => '0', -- Initial value of Q1: '0' or '1'
             INIT_Q2 => '0', -- Initial value of Q2: '0' or '1'
             SRTYPE => "ASYNC") -- Set/Reset type: "SYNC" or "ASYNC"
port map (
          Q1 => IDDROUT_DP(7), -- 1-bit output for positive edge of clock
          Q2 => IDDROUT_DN(7), -- 1-bit output for negative edge of clock
          C => BUFOUT_clk, -- 1-bit clock input
          CE => ce, -- 1-bit clock enable input
          D => BUFOUT_D7, -- 1-bit DDR data input
          R => reset -- 1-bit reset
          --S => set -- 1-bit set
          );
-- End of IDDR_inst instantiation

IDDR_inst9 : IDDR
generic map (
             DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE", "SAME_EDGE"
             -- or "SAME_EDGE_PIPELINED"
             INIT_Q1 => '0', -- Initial value of Q1: '0' or '1'
             INIT_Q2 => '0', -- Initial value of Q2: '0' or '1'
             SRTYPE => "ASYNC") -- Set/Reset type: "SYNC" or "ASYNC"
port map (
          Q1 => IDDROUT_DP(8), -- 1-bit output for positive edge of clock
          Q2 => IDDROUT_DN(8), -- 1-bit output for negative edge of clock
          C => BUFOUT_clk, -- 1-bit clock input
          CE => ce, -- 1-bit clock enable input
          D => BUFOUT_D8, -- 1-bit DDR data input
          R => reset -- 1-bit reset
          --S => set -- 1-bit set
          );
-- End of IDDR_inst instantiation

IDDR_inst10 : IDDR
generic map (
             DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE", "SAME_EDGE"
             -- or "SAME_EDGE_PIPELINED"
             INIT_Q1 => '0', -- Initial value of Q1: '0' or '1'
             INIT_Q2 => '0', -- Initial value of Q2: '0' or '1'
             SRTYPE => "ASYNC") -- Set/Reset type: "SYNC" or "ASYNC"
port map (
          Q1 => IDDROUT_DP(9), -- 1-bit output for positive edge of clock
          Q2 => IDDROUT_DN(9), -- 1-bit output for negative edge of clock
          C => BUFOUT_clk, -- 1-bit clock input
          CE => ce, -- 1-bit clock enable input
          D => BUFOUT_D9, -- 1-bit DDR data input
          R => reset -- 1-bit reset
          --S => set -- 1-bit set
          );
-- End of IDDR_inst instantiation

IDDR_inst11 : IDDR
generic map (
             DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE", "SAME_EDGE"
             -- or "SAME_EDGE_PIPELINED"
             INIT_Q1 => '0', -- Initial value of Q1: '0' or '1'
             INIT_Q2 => '0', -- Initial value of Q2: '0' or '1'
             SRTYPE => "ASYNC") -- Set/Reset type: "SYNC" or "ASYNC"
port map (
          Q1 => IDDROUT_DP(10), -- 1-bit output for positive edge of clock
          Q2 => IDDROUT_DN(10), -- 1-bit output for negative edge of clock
          C => BUFOUT_clk, -- 1-bit clock input
          CE => ce, -- 1-bit clock enable input
          D => BUFOUT_D10, -- 1-bit DDR data input
          R => reset -- 1-bit reset
          --S => set -- 1-bit set
          );
-- End of IDDR_inst instantiation

IDDR_inst12 : IDDR
generic map (
             DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE", "SAME_EDGE"
             -- or "SAME_EDGE_PIPELINED"
             INIT_Q1 => '0', -- Initial value of Q1: '0' or '1'
             INIT_Q2 => '0', -- Initial value of Q2: '0' or '1'
             SRTYPE => "ASYNC") -- Set/Reset type: "SYNC" or "ASYNC"
port map (
          Q1 => IDDROUT_DP(11), -- 1-bit output for positive edge of clock
          Q2 => IDDROUT_DN(11), -- 1-bit output for negative edge of clock
          C => BUFOUT_clk, -- 1-bit clock input
          CE => ce, -- 1-bit clock enable input
          D => BUFOUT_D11, -- 1-bit DDR data input
          R => reset -- 1-bit reset
          --S => set -- 1-bit set
          );
--End of IDDR_inst instantiation

------------------------------------------------------------------------------------------------------------------

   -- Clock process definitions
   CLK_IN_P_process :process
   begin
		CLK_IN_P <= '0';
		wait for CLK_period/2;
		CLK_IN_P <= '1';
		wait for CLK_period/2;
   end process;
 
   CLK_IN_N_process :process
   begin
		CLK_IN_N <= '1';
		wait for CLK_period/2;
		CLK_IN_N <= '0';
		wait for CLK_period/2;
   end process;
 
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
	Din_process :process
   begin
		Din_P <= Din_P + 1;
		Din_N <= not (Din_P);
		wait for clk_period/2; 
   end process;
  
  
    IDDR_Reset_process :process
   begin
		reset <= '1';
		wait for clk_period;
		reset <= '0';
		wait;  
   end process;
	
	IDDR_ce_process :process
   begin
      --ce <= '0';
		--wait for clk_period*2;
		ce <= '1';
		wait; 
   end process;

END;
