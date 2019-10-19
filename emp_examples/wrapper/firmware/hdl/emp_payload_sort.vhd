-- null_algo
--
-- Do-nothing top level algo for testing
--
-- Dave Newbold, July 2013

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.ipbus.all;
use work.emp_data_types.all;
use work.emp_project_decl.all;

use work.emp_data_types.all;
use work.emp_device_decl.all;
use work.emp_ttc_decl.all;

--use work.pf_data_types.all;
use work.pf_constants.all;

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

  signal rst_loc_reg : std_logic_vector(N_REGION - 1 downto 0);       
  constant N_FRAMES_USED : natural := 1;
  signal start_pf : std_logic_vector(0 downto 0) := (others => '1');                
  
begin

   ipb_out <= IPB_RBUS_NULL;

   selector_gen : process (clk_p)
   begin  -- process selector_gen
     if clk_p'event and clk_p = '1' then  -- rising clock edge
       rst_loc_reg <= rst_loc;
      end if;
    end process selector_gen;

  start_pf(0) <= '1';

  pf_algo : entity work.sort_ip_wrapper
    PORT MAP (
      clk    => clk_p,
      rst    => rst_loc(5),
      start  => start_pf(0),
      input  => d(N_IN_CHANS-1 downto 0),
      done   => open,
      idle   => open,
      ready  => open,
      output => q(N_OUT_CHANS - 1 downto 0)
   );
   
  bc0 <= '0';
  gpio <= (others => '0');
  gpio_en <= (others => '0');

end rtl;
