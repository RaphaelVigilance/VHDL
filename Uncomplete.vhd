	debounce_k1: process (clk,k1) --u_rDecnt
	begin
			if(rising_edge(clk))then
				if(rSysrstB = '0')then
					rButtonCnt <= (other => '0');
				else
					if(k1 = '0')then
						if(rButtonCnt(22)='1')then
							rButtonCnt <= rButtonCnt;
						else
							rButtonCnt<=rButtonCnt + 1;
						end if;
					else
						rButtonCnt <= (other => '0');
					end if;
				end if;
			end if;
	end process debounce_1;
