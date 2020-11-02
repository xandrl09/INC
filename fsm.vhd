-- fsm.vhd: 
-- Projekt INC
-- Prístupový terminál
-- Autor: Ondøej Andrla 
-- Datum: 5. 5. 2018
-- ----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        DEKLARACE ENTIT
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Vstupni signali
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Vystupni signali
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      DEKLARACE ARCHITEKTURY
-- ----------------------------------------------------------------------------
architecture behavioral of fsm is
   type t_state is (CISLO_1, CISLO_2, CISLO_3, CISLO_4A, CISLO_4B, CISLO_5A, CISLO_5B, CISLO_6A, 
	CISLO_6B, CISLO_7A, CISLO_7B, CISLO_8A, CISLO_8B, CISLO_9A, CISLO_9B, CISLO_10A ,CISLO_10B ,   
	SPRAVNE_CEKEJ, CHYBA_CEKEJ, TISK_PRISTUP_POVOLEN, TISK_PRISTUP_ODEPREN, KONEC);
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
-- VSTUP
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= CISLO_1;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
-- NÁSLEDUJÍCÍ STAV
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
	
   when CISLO_1 =>
      next_state <= CISLO_1;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(8) = '1') then
		  next_state <= CISLO_2;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
   -- - - - - - - - - - - - - - - - - - - - - - -
	
   when CISLO_2 =>
      next_state <= CISLO_2;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(1) = '1') then
		  next_state <= CISLO_3;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
	  -- - - - - - - - - - - - - - - - - - - - - - -
	  
   when CISLO_3 =>
      next_state <= CISLO_3;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(1) = '1') then
		  next_state <= CISLO_4A;
	  elsif (KEY(2) = '1') then
		  next_state <= CISLO_4B;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
	  -- - - - - - - - - - - - - - - - - - - - - - -
	  
   when CISLO_4A =>
      next_state <= CISLO_4A;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(3) = '1') then
		  next_state <= CISLO_5A;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
	    -- - - - - - - - - - - - - - - - - - - - - - -
		 
   when CISLO_4B =>
      next_state <= CISLO_4B;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(2) = '1') then
		  next_state <= CISLO_5B;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
	      -- - - - - - - - - - - - - - - - - - - - - - -
			
   when CISLO_5A =>
      next_state <= CISLO_5A;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(6) = '1') then
		  next_state <= CISLO_6A;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
	  -- - - - - - - - - - - - - - - - - - - - - - -
	  
   when CISLO_5B =>
      next_state <= CISLO_5B;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(7) = '1') then
		  next_state <= CISLO_6B;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
	    -- - - - - - - - - - - - - - - - - - - - - - -
		 
   when CISLO_6A =>
      next_state <= CISLO_6A;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(4) = '1') then
		  next_state <= CISLO_7A;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
	  -- - - - - - - - - - - - - - - - - - - - - - -
	  
   when CISLO_6B =>
      next_state <= CISLO_6B;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(2) = '1') then
		  next_state <= CISLO_7B;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
	    -- - - - - - - - - - - - - - - - - - - - - - -
   when CISLO_7A =>
      next_state <= CISLO_7A;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(1) = '1') then
		  next_state <= CISLO_8A;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
	    -- - - - - - - - - - - - - - - - - - - - - - -
		 
   when CISLO_7B =>
      next_state <= CISLO_7B;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(8) = '1') then
		  next_state <= CISLO_8B;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
	  -- - - - - - - - - - - - - - - - - - - - - - -
	  
   when CISLO_8A =>
      next_state <= CISLO_8A;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(9) = '1') then
		  next_state <= CISLO_9A;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
	  -- - - - - - - - - - - - - - - - - - - - - - -
	  
   when CISLO_8B =>
      next_state <= CISLO_8B;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(3) = '1') then
		  next_state <= CISLO_9B;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
	   -- - - - - - - - - - - - - - - - - - - - - - -
		
   when CISLO_9A =>
      next_state <= CISLO_9A;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(9) = '1') then
		  next_state <= CISLO_10A;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
	  -- - - - - - - - - - - - - - - - - - - - - - -
	  
	  		
   when CISLO_9B =>
      next_state <= CISLO_9B;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(9) = '1') then
		  next_state <= CISLO_10B;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
	  -- - - - - - - - - - - - - - - - - - - - - - -
	  
   when CISLO_10A =>
      next_state <= CISLO_10A;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(2) = '1') then
		  next_state <= SPRAVNE_CEKEJ;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
	  -- - - - - - - - - - - - - - - - - - - - - - -	
	  
	    -- - - - - - - - - - - - - - - - - - - - - - -
	  
   when CISLO_10B =>
      next_state <= CISLO_10B;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
	  elsif (KEY(8) = '1') then
		  next_state <= SPRAVNE_CEKEJ;
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
	  -- - - - - - - - - - - - - - - - - - - - - - -	
	  
   when SPRAVNE_CEKEJ =>
      next_state <= SPRAVNE_CEKEJ;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_POVOLEN; 
	  elsif (KEY(14 downto 0) /= "000000000000000") then
		  next_state <= CHYBA_CEKEJ;
      end if;
		
   -- - - - - - - - - - - - - - - - - - - - - - -
	
   when TISK_PRISTUP_POVOLEN =>
      next_state <= TISK_PRISTUP_POVOLEN;
      if (CNT_OF = '1') then
         next_state <= KONEC;
      end if;
		
   -- - - - - - - - - - - - - - - - - - - - - - -

   when CHYBA_CEKEJ =>
      next_state <= CHYBA_CEKEJ;
      if (KEY(15) = '1') then
         next_state <= TISK_PRISTUP_ODEPREN; 
      end if;
		
	-- - - - - - - - - - - - - - - - - - - - - - -	
	
   when TISK_PRISTUP_ODEPREN =>
      next_state <= TISK_PRISTUP_ODEPREN;
      if (CNT_OF = '1') then
         next_state <= KONEC;
      end if;
		
   -- - - - - - - - - - - - - - - - - - - - - - -
	
   when KONEC =>
      next_state <= KONEC;
      if (KEY(15) = '1') then
         next_state <= CISLO_1; 
      end if;
		
   -- - - - - - - - - - - - - - - - - - - - - - -
	
   when others =>
      next_state <= CISLO_1;
   end case;
end process next_state_logic;

-- -------------------------------------------------------
-- VÝSTUPNÍ LOGIKA
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TISK_PRISTUP_POVOLEN =>
	  FSM_MX_MEM     <= '1';
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TISK_PRISTUP_ODEPREN =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
   when KONEC =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
	  if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   end case;
end process output_logic;

end architecture behavioral;
