--declare @p1 int=1258
select
	zs.id as ID, zs.sumv as SUMV,'' com-- 'сопутствующий диагноз или осложнения не соответствует полу' com --osn=5.3.1.
FROM D3_ZSL_OMS zs
	join D3_SL_OMS sl on zs.id=sl.D3_ZSLID 
	join D3_PACIENT_OMS p on p.ID = zs.D3_PID
	JOIN D3_DSS_OMS AS dss ON dss.D3_SLID=sl.id
	--join D3_SCHET_OMS sch on sch.id=zs.d3_scid and sch.month=9
where 
	--zs.D3_SCID = @p1
	zs.D3_SCID IN  (1432)
	and 
	         (p.w=1
	                and (
							dss.DS like 'C51%'
							or dss.DS like 'C53%'
							or dss.DS like 'C54%'
							or dss.DS between 'C57' and 'C58.z' 
							or dss.DS like 'D06%'
							or dss.DS between 'D07.0' and 'D07.3'
							or dss.DS between 'D25' and 'D28.z'
							or dss.DS like 'D39%'
							or dss.DS like 'E28%'
							or dss.DS between 'N70' and 'N98.z' 
							or dss.DS in ('N99.2','N99.3','N99.8')
							or dss.DS between 'O00' and 'O99.z'
							or dss.DS between 'Z30' and 'Z39.z'
							or dss.DS like 'S31.4'
							or dss.DS like 'S37.4'
							or dss.DS like 'S37.5'
							or dss.DS like 'S37.6'
							or dss.DS like 'T19.2'
							or dss.DS like 'T19.3'
							or dss.DS like 'Q50%'
						)
	        
	     OR 
	               p.w=2
	               AND
	                (dss.DS like 'C60%'
						OR dss.DS  like 'C61%'
						or dss.DS  between 'C62' and 'C63.z'
						or dss.DS  like 'D07.4'
						or dss.DS  like 'D07.5'
						or dss.DS like 'D07.6'
						or dss.DS  like 'D17.6'
						OR dss.DS  like 'D29%'
						or dss.DS  like 'D40%'
						or dss.DS  like 'E29%'
						or dss.DS  between 'N40' and 'N51.z'
						or dss.DS  like 'S31.2'
						or dss.DS  like 'S31.3'
	                )

		)
group by zs.ID, zs.SUMV