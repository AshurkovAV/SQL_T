--declare @p1 int =4444;
update p set p.OKATOG='38000000000'
--SELECT 	zs.id as ID, zs.sumv as SUMV, ''com,p.OKATOG,p.id
--p.OKATOG,o.ter+o.kod1+o.kod2+o.kod3
from   D3_SCHET_OMS sch
		 join D3_PACIENT_OMS p on sch.id=p.[D3_SCID] --and sch.id=@p1
		 join D3_ZSL_OMS zs on p.id=zs.D3_PID 
		-- left join O002 o on o.ter+o.kod1+o.kod2+o.kod3=p.OKATOG
	WHERE p.OKATOG is not null and 
--	o.ter is null and 
	zs.zsl_id IN
	
	('0F1FF17A-F99F-CAC2-E063-A9690801797B',
'0FD2C612-8444-57BE-E063-A9690801C9EA',
'0FD2C612-844B-57BE-E063-A9690801C9EA')
	
	
	
				--вспомогательная выборка
				(SELECT distinct '''' + zsl_id + ''',' --,dzo.EXP_COMENT
				 FROM D3_ZSL_OMS AS dzo 
				   WHERE dzo.D3_SCID IN  (18444)--AND dzo.id=27093800
				   and dzo.EXP_COMENT LIKE  '% Некорректный код места жительства по ОКАТО (OKATOG); %'
                 )




