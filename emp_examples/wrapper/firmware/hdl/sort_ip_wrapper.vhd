library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.emp_data_types.all;
--use work.pf_data_types.all;
use work.pf_constants.all;

entity sort_ip_wrapper is
      port (
        clk: in std_logic;
        rst: in std_logic;
        start: in std_logic;
        input: in ldata(N_IN_CHANS-1 downto 0);
        done: out std_logic;
        idle: out std_logic;
        ready: out std_logic;
        output : out ldata(N_OUT_CHANS-1  downto 0)
        );
      
end sort_ip_wrapper;

architecture rtl of sort_ip_wrapper is
  	type dr_t  is array(PAYLOAD_LATENCY downto 0) of ldata(3 downto 0);
        type dr2_t is array(PAYLOAD_LATENCY downto 0) of ldata(1 downto 0);      
        signal inputtmp  : ldata(35 downto 0);
        signal outputtmp : ldata(5  downto 0);
begin

  gen: for i in 8 downto 0 generate
    constant ich: integer := i * 4 + 3;
    constant icl: integer := i * 4;
    signal dr: dr_t;
    attribute SHREG_EXTRACT: string;
    attribute SHREG_EXTRACT of dr: signal is "no"; -- Don't absorb FFs into shreg
  begin
    dr(0) <= input(ich downto icl);
    process(clk) -- Mother of all shift registers
    begin
      if rising_edge(clk) then
        dr(PAYLOAD_LATENCY downto 1) <= dr(PAYLOAD_LATENCY - 1 downto 0);
      end if;
    end process;
    inputtmp(ich downto icl) <= dr(PAYLOAD_LATENCY);
  end generate;
  
   pf_algo : entity work.algo_sort_v5_0
   port map (
      ap_clk => clk,
      ap_rst => rst,
      ap_start => start, -- ??
      ap_done => done, -- ??
      ap_idle => idle, -- ??
      ap_ready => ready, -- ??
      input_0_V => inputtmp(0).data,
      input_1_V => inputtmp(1).data,
      input_2_V => inputtmp(2).data,
      input_3_V => inputtmp(3).data,
      input_4_V => inputtmp(4).data,
      input_5_V => inputtmp(5).data,
      input_6_V => inputtmp(6).data,
      input_7_V => inputtmp(7).data,
      input_8_V => inputtmp(8).data,
      input_9_V => inputtmp(9).data,
      input_10_V => inputtmp(10).data,
      input_11_V => inputtmp(11).data,
      input_12_V => inputtmp(12).data,
      input_13_V => inputtmp(13).data,
      input_14_V => inputtmp(14).data,
      input_15_V => inputtmp(15).data,
      input_16_V => inputtmp(16).data,
      input_17_V => inputtmp(17).data,
      input_18_V => inputtmp(18).data,
      input_19_V => inputtmp(19).data,
      input_20_V => inputtmp(20).data,
      input_21_V => inputtmp(21).data,
      input_22_V => inputtmp(22).data,
      input_23_V => inputtmp(23).data,
      input_24_V => inputtmp(24).data,
      input_25_V => inputtmp(25).data,
      input_26_V => inputtmp(26).data,
      input_27_V => inputtmp(27).data,
      input_28_V => inputtmp(28).data,
      input_29_V => inputtmp(29).data,
      input_30_V => inputtmp(30).data,
      input_31_V => inputtmp(31).data,
      input_32_V => inputtmp(32).data,
      input_33_V => inputtmp(33).data,
      input_34_V => inputtmp(34).data,
      input_35_V => inputtmp(35).data,
      output_0_V => outputtmp(0).data,
      output_1_V => outputtmp(1).data,
      output_2_V => outputtmp(2).data,
      output_3_V => outputtmp(3).data,
      output_4_V => outputtmp(4).data,
      output_5_V => outputtmp(5).data
      );

    genout1: for i in 0 downto 0 generate
      signal dr: dr_t;
      attribute SHREG_EXTRACT: string;
      attribute SHREG_EXTRACT of dr: signal is "no"; -- Don't absorb FFs into shreg
    begin
      dr(0) <= outputtmp(3 downto 0);
      process(clk) -- Mother of all shift registers
      begin
        if rising_edge(clk) then
          dr(PAYLOAD_LATENCY downto 1) <= dr(PAYLOAD_LATENCY - 1 downto 0);
        end if;
      end process;
      output(3 downto 0) <= dr(PAYLOAD_LATENCY);
    end generate;

    genout2: for i in 0 downto 0 generate
      signal dr: dr2_t;
      attribute SHREG_EXTRACT: string;
      attribute SHREG_EXTRACT of dr: signal is "no"; -- Don't absorb FFs into shreg
    begin
      dr(0) <= outputtmp(5 downto 4);
      process(clk) -- Mother of all shift registers
      begin
        if rising_edge(clk) then
          dr(PAYLOAD_LATENCY downto 1) <= dr(PAYLOAD_LATENCY - 1 downto 0);
        end if;
      end process;
      output(5 downto 4) <= dr(PAYLOAD_LATENCY);
    end generate;

end rtl;
              
