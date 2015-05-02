-- file: Interface_exdes.vhd
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
-- SelectIO wizard example design
------------------------------------------------------------------------------
-- This example design instantiates the IO circuitry
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.and_reduce;

library unisim;
use unisim.vcomponents.all;

entity Interface_exdes is
generic (
  -- width of the data for the system
  sys_w      : integer := 12;
  -- width of the data for the device
  dev_w      : integer := 24
);
port (
  PATTERN_COMPLETED_OUT     : out   std_logic_vector (1 downto 0);
  -- From the system into the device
  DATA_IN_FROM_PINS_P      : in    std_logic_vector(sys_w-1 downto 0);
  DATA_IN_FROM_PINS_N      : in    std_logic_vector(sys_w-1 downto 0);
  DATA_OUT_TO_PINS_P         : out   std_logic_vector(sys_w-1 downto 0);
  DATA_OUT_TO_PINS_N         : out   std_logic_vector(sys_w-1 downto 0);
  CLK_TO_PINS_FWD_P         : out std_logic;
  CLK_TO_PINS_FWD_N         : out std_logic;

  CLK_IN_P                 : in    std_logic;
  CLK_IN_N                 : in    std_logic;
  CLK_IN_FWD_P             : in    std_logic;
  CLK_IN_FWD_N             : in    std_logic;
  CLK_RESET                : in    std_logic;
  SYNC_RESET		   : in    std_logic;
  IO_RESET                 : in    std_logic);
end Interface_exdes;

architecture xilinx of Interface_exdes is

component Interface is
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
end component;

   constant num_serial_bits  : integer := dev_w/sys_w;
   signal unused             : std_logic;
   signal clkin1             : std_logic;
   signal count_out          : std_logic_vector (num_serial_bits-1 downto 0);
   signal local_counter      : std_logic_vector(num_serial_bits-1 downto 0);
   signal pattern_completed    : std_logic_vector (1 downto 0) := "00";
   signal clk_in_int_inv       : std_logic;
            -- connection between ram and io circuit
   signal data_in_to_device         : std_logic_vector(dev_w-1 downto 0);
   signal data_in_to_device_int2    : std_logic_vector(dev_w-1 downto 0);
   signal data_in_to_device_int3    : std_logic_vector(dev_w-1 downto 0);

   signal data_out_from_device : std_logic_vector(dev_w-1 downto 0);

  
   signal data_out_from_device_q    : std_logic_vector(dev_w-1 downto 0) ;
   signal data_out_to_pins_int      : std_logic_vector(sys_w-1 downto 0);
   signal data_out_to_pins_predelay : std_logic_vector(sys_w-1 downto 0);
   constant clock_enable            : std_logic := '1';

   signal clk_out              : std_logic;
   signal clk_fwd_out          : std_logic;
   signal clk_fwd_int          : std_logic;
   signal clk_in_pll           : std_logic;
   signal clk_div_in_int       : std_logic;
   signal clk_div_in           : std_logic;
   signal locked               : std_logic;
--   signal clkin1             : std_logic;
  -- Output clock buffering / unused connectors
   signal clkfbout             : std_logic;
   signal clkfbout_buf         : std_logic;
   signal clkfboutb_unused     : std_logic;
   signal clkout0              : std_logic;
   signal clkout0b_unused      : std_logic;
   signal clkout1_unused   : std_logic;
   signal clkout1          : std_logic;
   signal clkout1b_unused  : std_logic;
   signal clkout2_unused   : std_logic;
   signal clkout2b_unused  : std_logic;
   signal clkout3_unused   : std_logic;
   signal clkout3b_unused  : std_logic;
   signal clkout4_unused   : std_logic;
   signal clkout5_unused   : std_logic;
   signal clkout6_unused   : std_logic;
  -- Dynamic programming unused signals
   signal do_unused        : std_logic_vector(15 downto 0);
   signal drdy_unused      : std_logic;
  -- Dynamic phase shift unused signals
   signal psdone_unused    : std_logic;
  -- Unused status signals
   signal clkfbstopped_unused : std_logic;
   signal clkinstopped_unused : std_logic;
   signal rst_sync      : std_logic;
   signal rst_sync_int  : std_logic;
   signal rst_sync_int1 : std_logic;
   signal rst_sync_int2 : std_logic;
   signal rst_sync_int3 : std_logic;
   signal rst_sync_int4 : std_logic;
   signal rst_sync_int5 : std_logic;
   signal rst_sync_int6 : std_logic;
   signal rst_sync_d      : std_logic;
   signal rst_sync_int_d  : std_logic;
   signal rst_sync_int1_d : std_logic;
   signal rst_sync_int2_d : std_logic;
   signal rst_sync_int3_d : std_logic;
   signal rst_sync_int4_d : std_logic;
   signal rst_sync_int5_d : std_logic;
   signal rst_sync_int6_d : std_logic;

   attribute KEEP : string;
   attribute KEEP of clk_div_in_int : signal is "TRUE";



begin

   process (clk_out, IO_RESET) begin
     if (IO_RESET = '1') then
       rst_sync <= '1';
       rst_sync_int <= '1';
       rst_sync_int1 <= '1';
       rst_sync_int2 <= '1';
       rst_sync_int3 <= '1';
       rst_sync_int4 <= '1';
       rst_sync_int5 <= '1';
       rst_sync_int6 <= '1';
     elsif (clk_out = '1' and clk_out'event) then
       rst_sync <= '0';
       rst_sync_int <= rst_sync;
       rst_sync_int1 <= rst_sync_int;
       rst_sync_int2 <= rst_sync_int1;
       rst_sync_int3 <= rst_sync_int2;
       rst_sync_int4 <= rst_sync_int3;
       rst_sync_int5 <= rst_sync_int4;
       rst_sync_int6 <= rst_sync_int5;
     end if;
   end process;

   process (clk_in_pll, IO_RESET) begin
     if (IO_RESET = '1') then
       rst_sync_d <= '1';
       rst_sync_int_d <= '1';
       rst_sync_int1_d <= '1';
       rst_sync_int2_d <= '1';
       rst_sync_int3_d <= '1';
       rst_sync_int4_d <= '1';
       rst_sync_int5_d <= '1';
       rst_sync_int6_d <= '1';
     elsif (clk_in_pll = '1' and clk_in_pll'event) then
       rst_sync_d <= '0';
       rst_sync_int_d <= rst_sync_d;
       rst_sync_int1_d <= rst_sync_int_d;
       rst_sync_int2_d <= rst_sync_int1_d;
       rst_sync_int3_d <= rst_sync_int2_d;
       rst_sync_int4_d <= rst_sync_int3_d;
       rst_sync_int5_d <= rst_sync_int4_d;
       rst_sync_int6_d <= rst_sync_int5_d;
     end if;
   end process;



   clkin_in_buf : IBUFGDS
    port map
      (O  => clkin1,
       I  => CLK_IN_P,
       IB => CLK_IN_N);

  mmcm_adv_inst : MMCME2_ADV
  generic map
   (BANDWIDTH            => "OPTIMIZED",
    CLKOUT4_CASCADE      => FALSE,
    COMPENSATION         => "ZHOLD",
    STARTUP_WAIT         => FALSE,
    DIVCLK_DIVIDE        => 1,
    CLKFBOUT_MULT_F      => 10.000,
    CLKFBOUT_PHASE       => 0.000,
    CLKFBOUT_USE_FINE_PS => FALSE,
    CLKOUT0_DIVIDE_F     => 10.000,
    CLKOUT0_PHASE        => 0.000,
    CLKOUT0_DUTY_CYCLE   => 0.500,
    CLKOUT0_USE_FINE_PS  => FALSE,
--    CLKOUT1_DIVIDE       => 10,
--    CLKOUT1_PHASE        => 0.000,
--    CLKOUT1_DUTY_CYCLE   => 0.500,
    CLKOUT1_USE_FINE_PS  => FALSE,
    CLKIN1_PERIOD        => 10.0,
    REF_JITTER1          => 0.010)
  port map
    -- Output clocks
   (CLKFBOUT            => clkfbout,
    CLKFBOUTB           => clkfboutb_unused,
    CLKOUT0             => clkout0,
    CLKOUT0B            => clkout0b_unused,
    CLKOUT1             => clkout1_unused,
    CLKOUT1B            => clkout1b_unused,
    CLKOUT2             => clkout2_unused,
    CLKOUT2B            => clkout2b_unused,
    CLKOUT3             => clkout3_unused,
    CLKOUT3B            => clkout3b_unused,
    CLKOUT4             => clkout4_unused,
    CLKOUT5             => clkout5_unused,
    CLKOUT6             => clkout6_unused,
    -- Input clock control
    CLKFBIN             => clkfbout_buf,
    CLKIN1              => clkin1,
    CLKIN2              => '0',
    -- Tied to always select the primary input clock
    CLKINSEL            => '1',
    -- Ports for dynamic reconfiguration
    DADDR               => (others => '0'),
    DCLK                => '0',
    DEN                 => '0',
    DI                  => (others => '0'),
    DO                  => do_unused,
    DRDY                => drdy_unused,
    DWE                 => '0',
    -- Ports for dynamic phase shift
    PSCLK               => '0',
    PSEN                => '0',
    PSINCDEC            => '0',
    PSDONE              => psdone_unused,
    -- Other control and status signals
    LOCKED              => locked,
    CLKINSTOPPED        => clkinstopped_unused,
    CLKFBSTOPPED        => clkfbstopped_unused,
    PWRDWN              => '0',
    RST                 => CLK_RESET);


  -- Output buffering
  -------------------------------------
   clkf_buf : BUFG
    port map
      (O => clkfbout_buf,
       I => clkfbout);


   clkout1_buf : BUFG
    port map
      (O   => clk_in_pll,
       I   => clkout0);





   process(clk_in_pll) begin
   if (clk_in_pll='1' and clk_in_pll'event) then
     if (rst_sync_int6_d = '1') then
       count_out <= (others => '0');
     elsif locked='1' then
     count_out <= count_out + 1;
    end if;
   end if;
  end process;


   


assign:for assg in 0 to num_serial_bits-1 generate begin
pinsss:for pinsss in 0 to sys_w-1 generate begin
   data_out_from_device(pinsss+sys_w*assg) <= count_out(assg);
end generate pinsss;
end generate assign;


   process(clk_out) begin
   if (clk_out='1' and clk_out'event) then
   if (rst_sync_int6 = '1') then
       pattern_completed <= "00";
   elsif (and_reduce(data_in_to_device_int3) = '1') then
     pattern_completed <= "11";
   else
     pattern_completed <= "00";
   end if;
   end if;
 end process;

   process(clk_out) begin
   if (clk_out='1' and clk_out'event) then
   if (rst_sync_int6 = '1') then
        data_in_to_device_int2 <= (others => '0');
        data_in_to_device_int3 <= (others => '0');
     else
        data_in_to_device_int2 <= data_in_to_device;
        data_in_to_device_int3 <= data_in_to_device_int2;
     end if;

   end if;
 end process;




 
   PATTERN_COMPLETED_OUT <= pattern_completed;
  






     clk_in_int_inv <= not(clk_in_pll);

  pins: for pin_count in 0 to sys_w-1 generate
    -- Instantiate the buffers
    ----------------------------------
     obufds_inst : OBUFDS
       generic map (
         IOSTANDARD => "LVDS_25")
       port map (
         O          => DATA_OUT_TO_PINS_P  (pin_count),
         OB         => DATA_OUT_TO_PINS_N  (pin_count),
         I          => data_out_to_pins_predelay(pin_count));

    oddr_inst : ODDR
      generic map (
        DDR_CLK_EDGE   => "SAME_EDGE", --"SAME_EDGE", --OPPOSITE_EDGE", -- "SAME_EDGE"
        INIT           => '0',
        SRTYPE         => "ASYNC")
      port map
       (D1             => data_out_from_device(pin_count),
        D2             => data_out_from_device(sys_w + pin_count),
        C              => clk_in_pll,
        CE             => clock_enable,
        Q              => data_out_to_pins_predelay(pin_count),
        R              => IO_RESET,
        S              => '0');
  end generate pins;

        clk_fwd : ODDR
          generic map (
            DDR_CLK_EDGE   => "SAME_EDGE", --"SAME_EDGE", --DOPPOSITE_EDGE", -- "SAME_EDGE"
            INIT           => '0',
            SRTYPE         => "ASYNC")
          port map
           (D1             => '1',
            D2             => '0',
            C              => clk_in_pll,
            CE             => locked,
            Q              => clk_fwd_out,
            R              => CLK_RESET,
            S              => '0');

          obufds_clk_inst : OBUFDS
           generic map (
             IOSTANDARD => "LVDS_25")
           port map (
             O          => CLK_TO_PINS_FWD_P,
             OB         => CLK_TO_PINS_FWD_N,
             I          => clk_fwd_out);

   -- Instantiate the IO design
   io_inst : Interface
   port map
   (
    -- From the system into the device
    DATA_IN_FROM_PINS_P     => DATA_IN_FROM_PINS_P,
    DATA_IN_FROM_PINS_N     => DATA_IN_FROM_PINS_N,
    DATA_IN_TO_DEVICE       => data_in_to_device,

 

    CLK_IN_P                => CLK_IN_FWD_P,
    CLK_IN_N                => CLK_IN_FWD_N,
    CLK_OUT                 => clk_out,
    SYNC_RESET              => SYNC_RESET,
    IO_RESET                => IO_RESET);
end xilinx;
