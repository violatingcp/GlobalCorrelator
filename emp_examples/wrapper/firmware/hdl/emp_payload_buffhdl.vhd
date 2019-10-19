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
  constant PAYLOAD_LATENCY : natural := 1;
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

--  gen: for i in 17 downto 0 generate
--    constant ich: integer := i * 4 + 3;
--    constant icl: integer := i * 4;
--    signal dr: dr_t;
--    attribute SHREG_EXTRACT: string;
--    attribute SHREG_EXTRACT of dr: signal is "no"; -- Don't absorb FFs into shreg
--  begin
--    dr(0) <= d(ich downto icl);
--    process(clk) -- Mother of all shift registers
--    begin
--      if rising_edge(clk) then
--        dr(PAYLOAD_LATENCY downto 1) <= dr(PAYLOAD_LATENCY - 1 downto 0);
--      end if;
--    end process;
--    inputtmp(ich downto icl) <= dr(PAYLOAD_LATENCY);
--  end generate;
       
    start_pf(0) <= '1';
    pf_algo : entity work.simple_buff
        port map (
          ap_clk    => clk_p,
          ap_rst    => rst_loc(5),
          input_0_V => d(0).data,    
          input_1_V => d(1).data,
          input_2_V => d(2).data,
          input_3_V => d(3).data,
          input_4_V => d(4).data,
          input_5_V => d(5).data,
          input_6_V => d(6).data,
          input_7_V => d(7).data,
          input_8_V => d(8).data,
          input_9_V => d(9).data,
          input_10_V => d(10).data,
          input_11_V => d(11).data,
          input_12_V => d(12).data,
          input_13_V => d(13).data,
          input_14_V => d(14).data,
          input_15_V => d(15).data,
          input_16_V => d(16).data,
          input_17_V => d(17).data,
          input_18_V => d(18).data,
          input_19_V => d(19).data,
          input_20_V => d(20).data,
          input_21_V => d(21).data,
          input_22_V => d(22).data,
          input_23_V => d(23).data,
          input_24_V => d(24).data,
          input_25_V => d(25).data,
          input_26_V => d(26).data,
          input_27_V => d(27).data,
          input_28_V => d(28).data,
          input_29_V => d(29).data,
          input_30_V => d(30).data,
          input_31_V => d(31).data,
          input_32_V => d(32).data,
          input_33_V => d(33).data,
          input_34_V => d(34).data,
          input_35_V => d(35).data,
          input_36_V => d(36).data,
          input_37_V => d(37).data,
          input_38_V => d(38).data,
          input_39_V => d(39).data,
          input_40_V => d(40).data,
          input_41_V => d(41).data,
          input_42_V => d(42).data,
          input_43_V => d(43).data,
          input_44_V => d(44).data,
          input_45_V => d(45).data,
          input_46_V => d(46).data,
          input_47_V => d(47).data,
          input_48_V => d(48).data,
          input_49_V => d(49).data,
          input_50_V => d(50).data,
          input_51_V => d(51).data,
          input_52_V => d(52).data,
          input_53_V => d(53).data,
          input_54_V => d(54).data,
          input_55_V => d(55).data,
          input_56_V => d(56).data,
          input_57_V => d(57).data,
          input_58_V => d(58).data,
          input_59_V => d(59).data,
          input_60_V => d(60).data,
          input_61_V => d(61).data,
          input_62_V => d(62).data,
          input_63_V => d(63).data,
          input_64_V => d(64).data,
          input_65_V => d(65).data,
          input_66_V => d(66).data,
          input_67_V => d(67).data,
          input_68_V => d(68).data,
          input_69_V => d(69).data,
          input_70_V => d(70).data,
          input_71_V => d(71).data,
          output_0_V => q(0).data,
          output_1_V => q(1).data,
          output_2_V => q(2).data,
          output_3_V => q(3).data,
          output_4_V => q(4).data,
          output_5_V => q(5).data,
          output_6_V => q(6).data,
          output_7_V => q(7).data,
          output_8_V => q(8).data,
          output_9_V => q(9).data,
          output_10_V => q(10).data,
          output_11_V => q(11).data,
          output_12_V => q(12).data,
          output_13_V => q(13).data,
          output_14_V => q(14).data,
          output_15_V => q(15).data,
          output_16_V => q(16).data,
          output_17_V => q(17).data,
          output_18_V => q(18).data,
          output_19_V => q(19).data,
          output_20_V => q(20).data,
          output_21_V => q(21).data,
          output_22_V => q(22).data,
          output_23_V => q(23).data,
          output_24_V => q(24).data,
          output_25_V => q(25).data,
          output_26_V => q(26).data,
          output_27_V => q(27).data,
          output_28_V => q(28).data,
          output_29_V => q(29).data,
          output_30_V => q(30).data,
          output_31_V => q(31).data,
          output_32_V => q(32).data,
          output_33_V => q(33).data,
          output_34_V => q(34).data,
          output_35_V => q(35).data,
          output_36_V => q(36).data,
          output_37_V => q(37).data,
          output_38_V => q(38).data,
          output_39_V => q(39).data,
          output_40_V => q(40).data,
          output_41_V => q(41).data,
          output_42_V => q(42).data,
          output_43_V => q(43).data,
          output_44_V => q(44).data,
          output_45_V => q(45).data,
          output_46_V => q(46).data,
          output_47_V => q(47).data,
          output_48_V => q(48).data,
          output_49_V => q(49).data,
          output_50_V => q(50).data,
          output_51_V => q(51).data,
          output_52_V => q(52).data,
          output_53_V => q(53).data,
          output_54_V => q(54).data,
          output_55_V => q(55).data,
          output_56_V => q(56).data,
          output_57_V => q(57).data,
          output_58_V => q(58).data,
          output_59_V => q(59).data,
          output_60_V => q(60).data,
          output_61_V => q(61).data,
          output_62_V => q(62).data,
          output_63_V => q(63).data,
          output_64_V => q(64).data,
          output_65_V => q(65).data,
          output_66_V => q(66).data,
          output_67_V => q(67).data,
          output_68_V => q(68).data,
          output_69_V => q(69).data,
          output_70_V => q(70).data, 
          output_71_V => q(71).data
    );

--   genout: for i in 17 downto 0 generate
--      constant ich: integer := i * 4 + 3;
--      constant icl: integer := i * 4;
--      signal dr: dr_t;
--      attribute SHREG_EXTRACT: string;
--      attribute SHREG_EXTRACT of dr: signal is "no"; -- Don't absorb FFs into shreg
--    begin
--      dr(0) <= outputtmp(3 downto 0);
--      process(clk) -- Mother of all shift registers
--      begin
--        if rising_edge(clk) then
--          dr(PAYLOAD_LATENCY downto 1) <= dr(PAYLOAD_LATENCY - 1 downto 0);
--        end if;
--      end process;
--      q(ich downto icl) <= dr(PAYLOAD_LATENCY);
--      q(ich).strobe <= '1';
--      q(ich).valid  <= '1';
--      q(ich-1).strobe <= '1';
--      q(ich-1).valid  <= '1';
--      q(ich-2).strobe <= '1';
--      q(ich-2).valid  <= '1';
--      q(ich-3).strobe <= '1';
--      q(ich-3).valid  <= '1';      
--    end generate;
       
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
