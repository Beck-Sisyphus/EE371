	component niosII_microprocessor is
		port (
			address_export : out   std_logic_vector(10 downto 0);                    -- export
			clk_clk        : in    std_logic                     := 'X';             -- clk
			data_export    : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			led_export     : out   std_logic_vector(7 downto 0);                     -- export
			outen_export   : out   std_logic;                                        -- export
			reset_reset_n  : in    std_logic                     := 'X';             -- reset_n
			wren_export    : out   std_logic                                         -- export
		);
	end component niosII_microprocessor;

	u0 : component niosII_microprocessor
		port map (
			address_export => CONNECTED_TO_address_export, -- address.export
			clk_clk        => CONNECTED_TO_clk_clk,        --     clk.clk
			data_export    => CONNECTED_TO_data_export,    --    data.export
			led_export     => CONNECTED_TO_led_export,     --     led.export
			outen_export   => CONNECTED_TO_outen_export,   --   outen.export
			reset_reset_n  => CONNECTED_TO_reset_reset_n,  --   reset.reset_n
			wren_export    => CONNECTED_TO_wren_export     --    wren.export
		);

