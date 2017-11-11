LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ; 
--USE ieee.std_logic_arith.all  ; 
--USE ieee.STD_LOGIC_SIGNED.all  ;
USE ieee.numeric_std.all;
library std;
use std.textio.ALL; 
ENTITY system_tb  IS 
  GENERIC (
    gBits  : POSITIVE   := 8 ); 
END ; 
 
ARCHITECTURE system_tb_arch OF system_tb IS
  SIGNAL Y   :  std_logic_vector (gBits-1 downto 0)  ; 
  SIGNAL RST   :  STD_LOGIC  ; 
  SIGNAL X_in, In_im   :  std_logic_vector (gBits - 1 downto 0)  ; 
  SIGNAL CLK   :  STD_LOGIC  ; 
  COMPONENT System  
    GENERIC ( 
      gBits  : POSITIVE  );  
    PORT ( 
      Y  : out std_logic_vector (gBits-1 downto 0) ; 
      RST  : in STD_LOGIC ; 
      X_in  : in std_logic_vector (gBits - 1 downto 0) ; 
      CLK  : in STD_LOGIC ); 
  END COMPONENT ;
  
BEGIN
  DUT  : System  
    GENERIC MAP ( 
      gBits  => gBits   )
    PORT MAP ( 
      Y   => Y  ,
      X_in   => X_in  ,
      CLK   => CLK,
      RST   => RST  ) ; 
RST 		<= '0', '1' after 5 ns;
P: process
begin
  CLK <= '0';
  wait for 10 ns;
  CLK <= '1';
  wait for 10 ns; 
end process P;

LECTURE : process
  variable L,M	: LINE;
  file ENTREE	 : TEXT is in	"C:\altera\13.0sp1\TP\TP4\data.txt"; 		--nom de fichier des échantillons
  file SORTIE	 : TEXT is out	"corr.txt"; 
  variable A,B	: integer := 0;
 
begin
	wait for 10 ns;
	READLINE(ENTREE, L);
	READ(L,A);
	X_in 		<= std_logic_vector(TO_SIGNED(A,gBits)) after 2 ns;
	--In_im		<= std_logic_vector(TO_SIGNED(-A,gBits)) after 2 ns;
	wait for 10 ns; 

	WRITE(M,to_INTEGER(SIGNED(Y))	,LEFT, 6);
	WRITELINE(SORTIE, M);
	
end process LECTURE;

END ;
