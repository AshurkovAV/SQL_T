select 		--count(distinct hi.pid)
		ppl.fam [�������], ppl.im [���], isnull(ppl.ot, '') [��������], convert(varchar(10),ppl.dr,104) [����_��������], 
		ppl.AdrOmsRegion [�����_������], ppl.AdrOmsRn [�����_�����], ppl.AdrOmsNaspunkt [�����_���������_�����], 
		ppl.AdrOmsUl [�����_�����], ppl.AdrOmsDom [�����_���], ppl.AdrOmsKorp [�����_������], ppl.AdrOmsKv [�����_��������],		-- *
		convert(date,ppl.PrMoDtBeg,104) [����_������������]
		
		 
from ATTP_People ppl
		inner join ATTP_People_HistPrMo hi on ppl.id = hi.pid
		inner join SPR_79_F002 f on ppl.OmsSmo = f.smocod
		left join ATTP_Uch_List u on ppl.PrUchId = u.id
		left join SPR_ATTP_UchTypes ut on u.TypeId=ut.id
		left join SPR_ATTP_UchPodr upodr on u.PodrId=upodr.id

where hi.prmo = 460026
		and hi.PrMoDtEnd is NULL
		AND ds IS NULL
		and hi.[status] = 1		--���������� ������
		and ppl.PrMoDtBeg between '20160101' and '20180701'
		AND ppl.Dr <= '20000101'
ORDER BY [����_������������]