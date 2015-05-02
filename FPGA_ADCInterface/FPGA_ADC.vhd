
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.STD_LOGIC_SIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;
entity ADC_FPGA_Interface is
Port ( 
      Rest:  in  STD_LOGIC;
		En:  in  STD_LOGIC;
      CLK_IN_P  : in  STD_LOGIC;
      CLK_IN_N  : in  STD_LOGIC;
      CLK_OUT : out STD_LOGIC;
      Din_P       : in STD_LOGIC_VECTOR(11 downto 0);
      Din_N       : in STD_LOGIC_VECTOR(11 downto 0);
		Dout_R       : out STD_LOGIC_VECTOR(11 downto 0);
		Dout_F       : out STD_LOGIC_VECTOR(11 downto 0)
		);
end ADC_FPGA_Interface;

architecture arch_Interface of ADC_FPGA_Interface is
--
--COMPONENT MyRam
--  PORT (
--    clka : IN STD_LOGIC;
--    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
--    addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
--    dina : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
--    clkb : IN STD_LOGIC;
--    addrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
--    doutb : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
--    sbiterr : OUT STD_LOGIC;
--    dbiterr : OUT STD_LOGIC;
--    rdaddrecc : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
--  );
--END COMPONENT;



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


   
--signal wea1: STD_LOGIC_VECTOR(0 DOWNTO 0);
--signal addra1: STD_LOGIC_VECTOR(3 downto 0);
--signal  dina1: STD_LOGIC_VECTOR(11 downto 0);
--signal clkb1: STD_LOGIC;
--signal addrb1: STD_LOGIC_VECTOR (3 downto 0);
--signal doutb1: STD_LOGIC_VECTOR(11 downto 0);
--signal sbiterr1: STD_LOGIC;
--signal dbiterr1: STD_LOGIC;
--signal rdaddrecc1: STD_LOGIC_VECTOR(3 DOWNTO 0);
--
--signal wea2: STD_LOGIC_VECTOR(0 DOWNTO 0);
--signal addra2: STD_LOGIC_VECTOR(3 downto 0);
--signal  dina2: STD_LOGIC_VECTOR(11 downto 0);
--signal clkb2: STD_LOGIC;
--signal addrb2: STD_LOGIC_VECTOR (3 downto 0);
--signal doutb2: STD_LOGIC_VECTOR(11 downto 0);
--signal sbiterr2: STD_LOGIC;
--signal dbiterr2: STD_LOGIC;
--signal rdaddrecc2: STD_LOGIC_VECTOR(3 DOWNTO 0);

--
--
begin

-- 12 Different Buffers
-- IBUFGDS: Differential Global Clock Input Buffer
-- 7 Series
-- Xilinx HDL Libraries Guide, version 14.2
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

--------------------------------------------------------------------------------------
CLK_OUT <= BUFOUT_clk;
--------------------------------------------------------------------------------------

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

Dout_R<= IDDROUT_DP; 
Dout_F<= IDDROUT_DN; 
--
--Mem1 : MyRam
--  PORT MAP (
--    clka => CLK_OUT,
--    wea => wea1,
--    addra => addra1,
--    dina => Dout_R,
--    clkb => clkb1,
--    addrb => addrb1,
--    doutb => doutb1,
--    sbiterr => sbiterr1,
--    dbiterr => dbiterr1,
--    rdaddrecc => rdaddrecc1
--  );
--
--Mem2 : MyRam
--  PORT MAP (
--    clka => CLK_OUT,
--    wea => wea2,
--    addra => addra2,
--    dina => Dout_F,
--    clkb => clkb2,
--    addrb => addrb2,
--    doutb => doutb2,
--    sbiterr => sbiterr2,
--    dbiterr => dbiterr2,
--    rdaddrecc => rdaddrecc2
--  );

end arch_Interface;