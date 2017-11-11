-------------------------------------------------------------------------------
-- Author      : AKRARAI MOHAMED & HAD HAJAR
-- School      : INPT, Rabat
-- Description : Design of Lowpass Filter
-------------------------------------------------------------------------------



Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
--use ieee.numeric_std.all ;
entity System is
  generic(
    gBits        :Positive:=8);
    port(
    RST          :in std_logic;  
    CLK          :in std_logic;
    X_in         :in std_logic_vector(gBits-1 downto 0);
    Y            :out std_logic_vector(gBits-1 downto 0));
    
  end System;
architecture Behavioral of system is
  
  type COEFS_TYPE is array(2 downto 0) of std_logic_vector(8 downto 0);
  constant COEFS              : COEFS_TYPE := (b"000000110",b"001100000",b"011000110");
  type MULT_TYPE is array(2 downto 0) of std_logic_vector(17 downto 0);
  signal   MULT_RESULTS       : MULT_TYPE;
  type ADD_TYPE is array(2 downto 0) of std_logic_vector(8 downto 0);
  signal   ADD_RESULTS        : ADD_TYPE;
  type DELAY_SIG is array(5 downto 0) of std_logic_vector(7 downto 0);
  signal   DELAY_INPUT        : DELAY_SIG;
  signal   PRE_OUTPUT_SIG     : std_logic_vector(18 downto 0);
  
begin
  
  process(CLK,RST) 
  
  begin
    
    if RST='0' then
      
       DELAY_INPUT <=(others=>(others=>'0'));
    
     elsif CLK'event and CLK = '1' then
         
      for I in 0 to 5 loop
        
        if I = 0 then
         
          DELAY_INPUT(0) <= X_in;
         
        else
         
          DELAY_INPUT(I) <= DELAY_INPUT(I-1);
         
        end if;
       
      end loop;
     end if;
     
     end process;
     
      ADD_RESULTS(0)  <= (DELAY_INPUT(0)(7)&DELAY_INPUT(0)) + (DELAY_INPUT(0)(7)&DELAY_INPUT(5));
      ADD_RESULTS(1)  <= (DELAY_INPUT(1)(7)&DELAY_INPUT(1)) + (DELAY_INPUT(4)(7)&DELAY_INPUT(4));
      ADD_RESULTS(2)  <= (DELAY_INPUT(2)(7)&DELAY_INPUT(2)) + (DELAY_INPUT(3)(7)&DELAY_INPUT(3));
      
      MULT_RESULTS(0) <= COEFS(2)* ADD_RESULTS(0);
      MULT_RESULTS(1) <= COEFS(1)* ADD_RESULTS(1);
      MULT_RESULTS(2) <= COEFS(0)* ADD_RESULTS(2);
      
      PRE_OUTPUT_SIG <= (MULT_RESULTS(0)(17)&MULT_RESULTS(0)) + (MULT_RESULTS(1)(17)&MULT_RESULTS(1)) + (MULT_RESULTS(2)(17)&MULT_RESULTS(2)); 
          
      process(RST,CLK)
      begin
        
        if RST='0' then
          
           Y <= (others=>'0');
           
        elsif CLK'event and CLK='1' then
          
          Y <= PRE_OUTPUT_SIG(18 downto 11);
           
                
      end if;   
      end process;
            
     
end Behavioral;
  
