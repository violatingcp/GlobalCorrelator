--
-- Do-nothing top level algo for testing
--
-- Dave Newbold, July 2013

library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.ipbus.all;
use work.emp_data_types.all;
use work.emp_project_decl.all;

use work.emp_data_types.all;
use work.emp_device_decl.all;
use work.emp_ttc_decl.all;

--use work.pf_data_types.all;
--use work.pf_constants.all;



entity emp_payload is
	port(
		clk: in std_logic; -- ipbus signals
		rst: in std_logic;
		ipb_in: in ipb_wbus;
		ipb_out: out ipb_rbus;
		clk_payload: in std_logic_vector(2 downto 0);
		rst_payload: in std_logic_vector(2 downto 0);
		clk_p: in std_logic; -- data clock
		rst_loc: in std_logic_vector(N_REGION - 1 downto 0);
		clken_loc: in std_logic_vector(N_REGION - 1 downto 0);
		ctrs: in ttc_stuff_array;
		bc0: out std_logic;
		d: in ldata(4 * N_REGION - 1 downto 0); -- data in
		q: out ldata(4 * N_REGION - 1 downto 0); -- data out
		gpio: out std_logic_vector(29 downto 0); -- IO to mezzanine connector
		gpio_en: out std_logic_vector(29 downto 0) -- IO to mezzanine connector (three-state enables)
	);
		
end emp_payload;

architecture rtl of emp_payload is
  constant PAYLOAD_LATENCY : natural := 2;
  signal rst_loc_reg : std_logic_vector(N_REGION - 1 downto 0);       
  constant N_FRAMES_USED : natural := 1;
  signal start_pf : std_logic_vector(0 downto 0) := (others => '1');                
  type dr_t  is array(PAYLOAD_LATENCY downto 0) of ldata(3 downto 0);
  signal inputtmp  : ldata(72 downto 0);
  signal outputtmp : ldata(72 downto 0);
  
begin

   ipb_out <= IPB_RBUS_NULL;

   selector_gen : process (clk_p)
   begin  -- process selector_gen
     if clk_p'event and clk_p = '1' then  -- rising clock edge
       rst_loc_reg <= rst_loc;
      end if;
    end process selector_gen;

  gen: for i in 17 downto 0 generate
    constant ich: integer := i * 4 + 3;
    constant icl: integer := i * 4;
    signal dr: dr_t;
    attribute SHREG_EXTRACT: string;
    attribute SHREG_EXTRACT of dr: signal is "no"; -- Don't absorb FFs into shreg
  begin
    dr(0) <= d(ich downto icl);
    process(clk) -- Mother of all shift registers
    begin
      if rising_edge(clk) then
        dr(PAYLOAD_LATENCY downto 1) <= dr(PAYLOAD_LATENCY - 1 downto 0);
      end if;
    end process;
    inputtmp(ich downto icl) <= dr(PAYLOAD_LATENCY);
  end generate;
       
    start_pf(0) <= '1';
    pf_algo : entity work.simple_buff_0
        port map (
          ap_clk    => clk_p,
          ap_rst    => rst_loc(5),
          ap_start  => start_pf(0),
          ap_done   => open,
          ap_idle   => open,
          ap_ready  => open,
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
          input_36_V => inputtmp(36).data,
          input_37_V => inputtmp(37).data,
          input_38_V => inputtmp(38).data,
          input_39_V => inputtmp(39).data,
          input_40_V => inputtmp(40).data,
          input_41_V => inputtmp(41).data,
          input_42_V => inputtmp(42).data,
          input_43_V => inputtmp(43).data,
          input_44_V => inputtmp(44).data,
          input_45_V => inputtmp(45).data,
          input_46_V => inputtmp(46).data,
          input_47_V => inputtmp(47).data,
          input_48_V => inputtmp(48).data,
          input_49_V => inputtmp(49).data,
          input_50_V => inputtmp(50).data,
          input_51_V => inputtmp(51).data,
          input_52_V => inputtmp(52).data,
          input_53_V => inputtmp(53).data,
          input_54_V => inputtmp(54).data,
          input_55_V => inputtmp(55).data,
          input_56_V => inputtmp(56).data,
          input_57_V => inputtmp(57).data,
          input_58_V => inputtmp(58).data,
          input_59_V => inputtmp(59).data,
          input_60_V => inputtmp(60).data,
          input_61_V => inputtmp(61).data,
          input_62_V => inputtmp(62).data,
          input_63_V => inputtmp(63).data,
          input_64_V => inputtmp(64).data,
          input_65_V => inputtmp(65).data,
          input_66_V => inputtmp(66).data,
          input_67_V => inputtmp(67).data,
          input_68_V => inputtmp(68).data,
          input_69_V => inputtmp(69).data,
          input_70_V => inputtmp(70).data,
          input_71_V => inputtmp(71).data,
          output_0_V => outputtmp(0).data,
          output_1_V => outputtmp(1).data,
          output_2_V => outputtmp(2).data,
          output_3_V => outputtmp(3).data,
          output_4_V => outputtmp(4).data,
          output_5_V => outputtmp(5).data,
          output_6_V => outputtmp(6).data,
          output_7_V => outputtmp(7).data,
          output_8_V => outputtmp(8).data,
          output_9_V => outputtmp(9).data,
          output_10_V => outputtmp(10).data,
          output_11_V => outputtmp(11).data,
          output_12_V => outputtmp(12).data,
          output_13_V => outputtmp(13).data,
          output_14_V => outputtmp(14).data,
          output_15_V => outputtmp(15).data,
          output_16_V => outputtmp(16).data,
          output_17_V => outputtmp(17).data,
          output_18_V => outputtmp(18).data,
          output_19_V => outputtmp(19).data,
          output_20_V => outputtmp(20).data,
          output_21_V => outputtmp(21).data,
          output_22_V => outputtmp(22).data,
          output_23_V => outputtmp(23).data,
          output_24_V => outputtmp(24).data,
          output_25_V => outputtmp(25).data,
          output_26_V => outputtmp(26).data,
          output_27_V => outputtmp(27).data,
          output_28_V => outputtmp(28).data,
          output_29_V => outputtmp(29).data,
          output_30_V => outputtmp(30).data,
          output_31_V => outputtmp(31).data,
          output_32_V => outputtmp(32).data,
          output_33_V => outputtmp(33).data,
          output_34_V => outputtmp(34).data,
          output_35_V => outputtmp(35).data,
          output_36_V => outputtmp(36).data,
          output_37_V => outputtmp(37).data,
          output_38_V => outputtmp(38).data,
          output_39_V => outputtmp(39).data,
          output_40_V => outputtmp(40).data,
          output_41_V => outputtmp(41).data,
          output_42_V => outputtmp(42).data,
          output_43_V => outputtmp(43).data,
          output_44_V => outputtmp(44).data,
          output_45_V => outputtmp(45).data,
          output_46_V => outputtmp(46).data,
          output_47_V => outputtmp(47).data,
          output_48_V => outputtmp(48).data,
          output_49_V => outputtmp(49).data,
          output_50_V => outputtmp(50).data,
          output_51_V => outputtmp(51).data,
          output_52_V => outputtmp(52).data,
          output_53_V => outputtmp(53).data,
          output_54_V => outputtmp(54).data,
          output_55_V => outputtmp(55).data,
          output_56_V => outputtmp(56).data,
          output_57_V => outputtmp(57).data,
          output_58_V => outputtmp(58).data,
          output_59_V => outputtmp(59).data,
          output_60_V => outputtmp(60).data,
          output_61_V => outputtmp(61).data,
          output_62_V => outputtmp(62).data,
          output_63_V => outputtmp(63).data,
          output_64_V => outputtmp(64).data,
          output_65_V => outputtmp(65).data,
          output_66_V => outputtmp(66).data,
          output_67_V => outputtmp(67).data,
          output_68_V => outputtmp(68).data,
          output_69_V => outputtmp(69).data,
          output_70_V => outputtmp(70).data, 
          output_71_V => outputtmp(71).data
    );

   genout: for i in 17 downto 0 generate
      constant ich: integer := i * 4 + 3;
      constant icl: integer := i * 4;
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
      q(ich downto icl) <= dr(PAYLOAD_LATENCY);
      q(ich).strobe <= '1';
      q(ich).valid  <= '1';
      q(ich-1).strobe <= '1';
      q(ich-1).valid  <= '1';
      q(ich-2).strobe <= '1';
      q(ich-2).valid  <= '1';
      q(ich-3).strobe <= '1';
      q(ich-3).valid  <= '1';      
    end generate;
       
--   gMux : for i in 71 downto 0 generate     
--     selector_end : process (clk_p)
--     begin 
--       if rising_edge(clk) then
--         q(i).strobe <= '1';
--         q(i).valid  <= '1'; 
--       end if;
--     end process selector_end;
--   end generate gMux;
       

   bc0 <= '0';
   gpio <= (others => '0');
   gpio_en <= (others => '0');

end rtl;
