	component nios_system is
		port (
			clk_clk         : in  std_logic                    := 'X'; -- clk
			keys_export     : out std_logic_vector(3 downto 0);        -- export
			reset_reset_n   : in  std_logic                    := 'X'; -- reset_n
			switches_export : out std_logic_vector(9 downto 0)         -- export
		);
	end component nios_system;

	u0 : component nios_system
		port map (
			clk_clk         => CONNECTED_TO_clk_clk,         --      clk.clk
			keys_export     => CONNECTED_TO_keys_export,     --     keys.export
			reset_reset_n   => CONNECTED_TO_reset_reset_n,   --    reset.reset_n
			switches_export => CONNECTED_TO_switches_export  -- switches.export
		);

