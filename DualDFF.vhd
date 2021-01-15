-- Jared Day
-- 10/5/2017

-- Dual D Flip-Flop Latch w/ preset, clear, positive clock edge.
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY DualDFF IS
PORT(	
		i_clk1	:IN std_logic;									-- need two clocks
		i_clk2	:IN std_logic;									-- need two clocks
		i_D		:IN std_logic_vector(1 DOWNTO 0);		-- Dual (2) D FF inputs
		i_CLR		:IN std_logic_vector(1 DOWNTO 0);		-- two clear
		i_PR		:IN std_logic_vector(1 DOWNTO 0);		-- two preset
		o_Q		:OUT std_logic_vector(1 DOWNTO 0);		-- two Q	
		o_Qbar	:OUT std_logic_vector(1 DOWNTO 0));		-- two Qbar
		
END DualDFF;

ARCHITECTURE ckt OF DualDFF IS

	SIGNAL internal_check1	: std_logic_vector(1 DOWNTO 0);
	SIGNAL internal_check2	: std_logic_vector(1 DOWNTO 0);
	
BEGIN	
	internal_check1 <= i_PR(1) & i_CLR(1);
	PROCESS(i_clk1, internal_check1)						-- need two processes
		BEGIN
			IF(internal_check1 = "01") THEN								-- if PRESET is low set Q high
			o_Q(1) <= '1';
			o_Qbar(1) <= '0';
			ELSIF(internal_check1 = "10") THEN							-- if clear is low then set Q low
			o_Q(1) <= '0';
			o_Qbar(1) <= '1';
			ELSIF(internal_check1 = "00") THEN
			o_Q(1) <= '1';
			o_Qbar(1) <= '1';
			ELSIF(i_clk1'EVENT AND i_clk1 = '1') THEN		-- else do the FF
			o_Q(1) <= i_D(1);
			o_Qbar(1) <= NOT i_D(1);
			END IF;
	END PROCESS;
	
	
	internal_check2 <= i_PR(0) & i_CLR(0);
PROCESS(i_clk2, internal_check2)						-- need two processes
		BEGIN
			IF(internal_check2 = "01") THEN								-- if PRESET is low set Q high
			o_Q(0) <= '1';
			o_Qbar(0) <= '0';
			ELSIF(internal_check2 = "10") THEN							-- if clear is low then set Q low
			o_Q(0) <= '0';
			o_Qbar(0) <= '1';
			ELSIF(internal_check2 = "00") THEN
			o_Q(0) <= '1';
			o_Qbar(0) <= '1';
			ELSIF(i_clk2'EVENT AND i_clk2 = '1') THEN		-- else do the FF
			o_Q(0) <= i_D(0);
			o_Qbar(0) <= NOT i_D(0);
			END IF;
	END PROCESS;
	

END ckt;