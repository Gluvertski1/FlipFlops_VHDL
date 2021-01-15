-- Jared Day
-- 10/9/2017

-- This is a JK Flip Flop from Tocci 11th edition. Fig 5-31
-- clocked with asynchronous pre and clear.

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY jkflipflop IS
PORT(
		i_clk				:IN std_logic;			-- clock for JKFF
		i_j, i_k			:IN std_logic;			-- the j and k
		i_PR, i_CLR		:IN std_logic;			-- asynchronous pre and clear
		o_Q				:OUT std_logic_vector(1 DOWNTO 0));
END jkflipflop;

ARCHITECTURE ckt OF jkflipflop IS
	SIGNAL internal_Q : std_logic_vector(1 DOWNTO 0);
BEGIN
	PROCESS(i_clk, i_CLR, i_PR)						-- responds to these signals
	BEGIN	
		IF (i_PR = '0' AND i_CLR = '0') THEN
		internal_Q <= "11";
		ELSIF(i_PR = '0' AND i_CLR = '1') THEN
		internal_Q <= "10";							-- asynchronous preset
		ELSIF (i_PR = '1' AND i_CLR = '0') THEN	
		internal_Q <= "01";							-- asynchronous clear
		ELSIF(i_clk'EVENT AND i_clk = '0') THEN
			IF(i_j = '1' AND i_k = '1') THEN
			internal_Q <= NOT internal_Q;
			ELSIF(i_j = '1' AND i_k = '0') THEN
			internal_Q <= "10";
			ELSIF(i_j = '0' AND i_k = '1') THEN
			internal_Q <= "01";
			END IF;
		END IF;
	END PROCESS;
	o_Q <= internal_Q;				-- output pin is updated
END ckt;
			
		
	