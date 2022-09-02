library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity MOOREtb is
-- Port ( );
end MOOREtb;
architecture Behavioral of MOOREtb is
component MOORE is -- Moore machine
port(
clk, rst : in std_logic;
inc : in std_logic_Vector(1 downto 0);
outc : out std_logic_Vector(1 downto 0);
can : out std_logic
);
end component;
signal clk, rst, can : std_logic := '0';
signal outc : std_logic_Vector(1 downto 0) := "00";
signal inc : std_logic_Vector(1 downto 0) := "00";
begin
C1 : MOORE port map (clk => clk, inc => inc, outc => outc, rst => rst, can => can);
clk_process:process(clk)
begin
clk <= not clk after 10 ns; --oscillate at this specific period
end process clk_process;
---------------------------------------------
control_process:process
begin
inc <= "01";
wait for 50 ns;
rst <= '1' after 10 ns ; 
wait for 50 ns;
rst <= '0'; 
inc <= "10";
wait for 50 ns;
--£50p case
inc <= "10";
wait for 50 ns;
inc <= "01";
wait for 50 ns;
--- £50p
inc <= "10";
wait for 50 ns;
-----£1
inc <= "11";
wait for 50 ns;
-----£2 and 50p
inc <= "10";
wait for 50 ns;
inc <= "00";
wait for 50 ns;
-----£1.50
inc <= "10";
inc <= "11";
wait for 50 ns;
end process control_process;
end Behavioral;
