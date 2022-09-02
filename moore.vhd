library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity MOORE is -- Moore machine
port(
clk,rst : in std_logic;
inc : in std_logic_Vector(1 downto 0);
outc : out std_logic_Vector(1 downto 0);
can : out std_logic
);
end MOORE;
architecture BEHAVIOR of MOORE is
type STATE_TYPE is (Sa, Sb, Sc, Sd, Se, Sf);
signal CURRENT_STATE, NEXT_STATE: STATE_TYPE;
begin
-- Process to hold synchronous elements (flip-flops)
SYNCH: process(clk)
begin
if(rising_edge(clk)) then
 if(rst = '1') then
 CURRENT_STATE <= Sa;
 else 
 CURRENT_STATE <= NEXT_STATE;
 end if;
end if;
CURRENT_STATE <= NEXT_STATE;
end process SYNCH;
-- Process to hold combinational logic 
COMBIN: process(CURRENT_STATE, inc)
begin
case CURRENT_STATE is
when Sa => 
outc <= "01";
can <= '0';
if (inc = "01") then -- 0 p
NEXT_STATE <= Sa; 
end if;
if (inc = "11") then --1 pound
NEXT_STATE <= Sf;
end if;
if (inc = "00") then --2 pound
NEXT_STATE <= Sb;
end if;
if (inc = "10") then --50p
NEXT_STATE <= Sc;
end if;
when Sb =>
outc <= "11";
can <= '0';
NEXT_STATE <= Sf;
when Sc =>
outc <= "01";
can <= '0';
if (inc = "01") then --0p
NEXT_STATE <= Sc;
end if;
if (inc = "11") then --1 pound
NEXT_STATE <= Sd;
end if;
if (inc = "00") then --2 pound
NEXT_STATE <= Se;
end if;
if (inc = "10") then
NEXT_STATE <= Sf;
end if;
when Se =>
outc <= "11";
can <= '0';
NEXT_STATE <= Sd;
when Sd =>
outc <= "10";
can <= '0';
NEXT_STATE <= Sf;
when Sf =>
outc <= "01";
can <= '1';
NEXT_STATE <= Sa;
end case;
end process COMBIN;
end BEHAVIOR;
