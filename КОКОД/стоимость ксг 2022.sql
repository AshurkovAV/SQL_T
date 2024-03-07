Select 
distinct v23.NameWithID, bt.BZTSZ,v23.KOEF_Z,calc.lek,calc.up,cm.KUS, upr.upr,calc.LEK

 ,round (convert(numeric(12,2),bt.BZTSZ) * v23.KOEF_Z *
        ( (1-isnull(calc.lek,1)) + isnull(calc.lek,1)*isnull(case when calc.up is not null or  v23.k_ksg like 'ds%' then 1 else cm.KUS end,1)* ISNULL(upr.upr,1.00)),2)
         [now]





FROM  v023 v23    --AND year(v23.DATEBEG)>=2019
 left join [CalcKsg] calc on calc.K_KSG=v23.[K_KSG] AND YEAR(calc.[DATEend])=2023 AND MONTH(calc.[DATEend])=12
left join SprBZTSZ bt on bt.USL_OK=case when v23.k_ksg like 'st%' then 1 else 2 END AND YEAR(bt.[DBEG])=2023 AND MONTH(dend)=12
LEFT JOIN [CalcUprk] upr ON upr.[IDKSG]=v23.K_KSG AND MONTH(tend)=12 AND YEAR(tend)=2023
LEFT JOIN CalcMok AS cm ON cm.KOD_LPU='460061' AND YEAR(cm.dateend)=2023 AND MONTH(cm.dateend)=12
WHERE   --sch.id IN (1751,1747,1746)-- and zs.pr_nov=0-- AND  --AND zs.DATE_Z_2 BETWEEN '20200914' AND '20200920'  AND 

						 YEAR(v23.DATEBEG)=2023 --AND bt.dend LIKE '20221231'
						 --AND v23.[K_KSG]='st36.013'
						 
						 
						--SELECT * FROM [CalcUprk] WHERE YEAR(tbeg)=2023  order by idksg AND K_KSG LIKE 'st36.018'
						--select * from SprBZTSZ
						--SELECT * FROM [CalcKsg] calc WHERE YEAR(calc.[DATEend])=2023  order by K_KSG AND K_KSG LIKE 'st36.018'--AND MONTH(calc.[DATEend])=12
						--select * from CalcMok AS cm where year(datestart)=2023 and kod_lpu=460061