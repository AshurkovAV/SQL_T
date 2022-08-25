select 		--count(distinct hi.pid)
		ppl.fam [Фамилия], ppl.im [Имя], isnull(ppl.ot, '') [Отчество], convert(varchar(10),ppl.dr,104) [Дата_рождения], 
		ppl.AdrOmsRegion [Адрес_регион], ppl.AdrOmsRn [Адрес_район], ppl.AdrOmsNaspunkt [Адрес_населённый_пункт], 
		ppl.AdrOmsUl [Адрес_улица], ppl.AdrOmsDom [Адрес_дом], ppl.AdrOmsKorp [Адрес_корпус], ppl.AdrOmsKv [Адрес_квартира],		-- *
		convert(date,ppl.PrMoDtBeg,104) [Дата_прикрепления]
		
		 
from ATTP_People ppl
		inner join ATTP_People_HistPrMo hi on ppl.id = hi.pid
		inner join SPR_79_F002 f on ppl.OmsSmo = f.smocod
		left join ATTP_Uch_List u on ppl.PrUchId = u.id
		left join SPR_ATTP_UchTypes ut on u.TypeId=ut.id
		left join SPR_ATTP_UchPodr upodr on u.PodrId=upodr.id

where hi.prmo = 460026
		and hi.PrMoDtEnd is NULL
		AND ds IS NULL
		and hi.[status] = 1		--актуальные записи
		and ppl.PrMoDtBeg between '20160101' and '20180701'
		AND ppl.Dr <= '20000101'
ORDER BY [Дата_прикрепления]