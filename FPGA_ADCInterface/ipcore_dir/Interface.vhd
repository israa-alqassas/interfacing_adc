-- file: Interface.vhd
-- (c) Copyright 2009 - 2011 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
------------------------------------------------------------------------------
-- User entered comments
------------------------------------------------------------------------------
-- None
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity Interface is
generic
 (-- width of the data for the system
  sys_w       : integer := 12;
  -- width of the data for the device
  dev_w       : integer := 24);
port
 (
  -- From the system into the device
  DATA_IN_FROM_PINS_P     : in    std_logic_vector(sys_w-1 downto 0);
  DATA_IN_FROM_PINS_N     : in    std_logic_vector(sys_w-1 downto 0);
  DATA_IN_TO_DEVICE       : out   std_logic_vector(dev_w-1 downto 0);

 
-- Clock and reset signals
  CLK_IN_P                : in    std_logic;                    -- Differential fast clock from IOB
  CLK_IN_N                : in    std_logic;
  CLK_OUT                 : out   std_logic;
  SYNC_RESET		  : in    std_logic;
  IO_RESET                : in    std_logic);                   -- Reset signal for IO circuit
end Interface;

architecture xilinx of Interface is
  attribute CORE_GENERATION_INFO            : string;
  attribute CORE_GENERATION_INFO of xilinx  : architecture is "Interface,selectio_wiz_v4_1,{component_name=Interface,bus_dir=INPUTS,bus_sig_type=DIFF,bus_io_std=LVDS_25,use_serialization=false,use_phase_detector=false,serialization_factor=4,enable_bitslip=false,enable_train=false,system_data_width=12,bus_in_delay=NONE,bus_out_delay=NONE,clk_sig_type=DIFF,clk_io_std=LVCMOS18,clk_buf=BUFIO2,active_edge=RISING,clk_delay=NONE,v6_bus_in_delay=NONE,v6_bus_out_delay=NONE,v6_clk_buf=BUFIO,v6_active_edge=DDR,v6_ddr_alignment=OPPOSITE_EDGE,v6_oddr_alignment=SAME_EDGE,ddr_alignment=C0,v6_interface_type=NETWORKING,interface_type=NETWORKING,v6_bus_in_tap=0,v6_bus_out_tap=0,v6_clk_io_std=LVDS_25,v6_clk_sig_type=DIFF}";
  constant clock_enable            : std_logic := '1';
  signal unused : std_logic;
  signal clk_in_int                : std_logic;
  signal clk_div                   : std_logic;
  signal clk_div_int               : std_logic;
  signal clk_in_int_buf            : std_logic;


  -- After the buffer
  signal data_in_from_pins_int     : std_logic_vector(sys_w-1 downto 0);
  -- Between the delay and serdes
  signal data_in_from_pins_delay   : std_logic_vector(sys_w-1 downto 0);
  signal ce_in_uc          : std_logic;
  signal inc_in_uc         : std_logic;
  signal regrst_in_uc      : std_logic;
  signal ce_out_uc              : std_logic;
  signal inc_out_uc             : std_logic;
  signal regrst_out_uc          : std_logic;


begin




  -- Create the clock logic
     ibufds_clk_inst : IBUFGDS
       generic map (
         IOSTANDARD => "LVDS_25")
       port map (
         I          => CLK_IN_P,
         IB         => CLK_IN_N,
         O          => clk_in_int);
-- High Speed BUFIO clock buffer
     bufio_inst : BUFIO
       port map (
         O => clk_in_int_buf,
         I => clk_in_int);
-- BUFR generates the slow clock
     clkout_buf_inst : BUFR
       generic map (
          SIM_DEVICE => "7SERIES",
          BUFR_DIVIDE => "BYPASS")
       port map (
          O           => clk_div,
          CE          => unused,
          CLR         => unused,
          I           => clk_in_int);


   CLK_OUT <= clk_div;     --This is regional clock;

  
  -- We have multiple bits- step over every bit, instantiating the required elements
  pins: for pin_count in 0 to sys_w-1 generate
  begin
    -- Instantiate the buffers
    ----------------------------------
    -- Instantiate a buffer for every bit of the data bus
     ibufds_inst : IBUFDS
       generic map (
         DIFF_TERM  => FALSE,             -- Differential termination
         IOSTANDARD => "LVDS_25")
       port map (
         I          => DATA_IN_FROM_PINS_P  (pin_count),
         IB         => DATA_IN_FROM_PINS_N  (pin_count),
         O          => data_in_from_pins_int(pin_count));


    -- Pass through the delay
    -----------------------------------
   data_in_from_pins_delay(pin_count) <= data_in_from_pins_int(pin_count);

    -- Connect the delayed data to the fabric
    ------------------------------------------
   -- DDR register instantation
    iddr_inst : IDDR
      generic map (
        INIT_Q1        => '0',
        INIT_Q2        => '0',
        DDR_CLK_EDGE   => "OPPOSITE_EDGE", --"SAME_EDGE", "OPPOSITE_EDGE", "SAME_EDGE", "SAME_EDGE_PIPELINED"
       SRTYPE         => "SYNC")
      port map
       (Q1             => DATA_IN_TO_DEVICE(pin_count),
        Q2             => DATA_IN_TO_DEVICE(sys_w + pin_count),
        C              => clk_div,
        CE             => clock_enable,
        D              => data_in_from_pins_delay(pin_count),
        R              => SYNC_RESET,
        S              => '0');

  end generate pins;





end xilinx;



