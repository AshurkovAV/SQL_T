SELECT pr.id, pr.OTDELEN, pr.fam, pr.im, pr.ot, pr.dr, pr.plat, pr.ds1,						
pr.date_napr, pr.code_usl1, pr.code_usl2, pr.date_2 						
, t.* 						
FROM proverka_gista pr						
LEFT JOIN 		(Select DISTINCT				
				 sch.SchetType as [Тип счета]		
				,sch.month as [Месяц]		
				  ,sch.YEAR[Год]		
				  , p.fam,p.im,isnull(p.ot,'') ot		
				-- ,p.W as [Пол]		
				  ,p.DR 		
				  ,zs.id		
				  , zs.NPR_DATE		
				  --, s.PODR as [Подразделение]		
				 , s.DS1 		
				 , s.DATE_1, s.DATE_2, usl.CODE_USL, usl.VID_VME		
						
				FROM [D3_SCHET_OMS] sch                  		
				 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id		
				 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id 		
				join D3_SL_OMS s on s.D3_ZSLID=zs.ID 		
				join d3_usl_oms usl on usl.D3_SLID=s.id		
				join (select distinct code_usl,name 		
					  from [medicalServices]	
					   WHERE year(dataBegin) = 2022) ms on ms.[code_usl]=usl.code_usl 	AND   usl.code_usl like 'R01.001.006%'
				left join Yamed_Spr_UslCode y on y.ID=usl.vid_vme		
						
				where  sch.code_mo=460061 		
						AND sch.month=1 
						AND sch.YEAR=2022
						and zs.usl_ok=3
               ) t ON t.fam = pr.fam AND t.im = pr.im AND t.ot = isnull(pr.ot,'') AND pr.dr=t.dr AND t.NPR_DATE=pr.date_napr AND t.DATE_2=pr.date_2						
WHERE t.fam IS NULL AND 
pr.date_napr<'20220201'	AND pr.OTDELEN NOT IN ('1ХО','2ХО','ОКПТХ','ООУ','ГИН','ТО','ОКМТ','ООГШ','ДС')	AND pr.date_2<'20220201' AND pr.plat=0	
ORDER BY pr.OTDELEN	
		 				
		 				
