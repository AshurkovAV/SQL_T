update zsl set npr_date=date_1
select zsl.id,npr_date,date_1,code_usl
FROM D3_PACIENT_OMS p
			inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id 
				inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
				 JOIN d3_usl_oms usl ON usl.D3_SLID=sl.id
				 where p.D3_SCID  in  (9374,9382,9395)
					 and npr_date>date_1