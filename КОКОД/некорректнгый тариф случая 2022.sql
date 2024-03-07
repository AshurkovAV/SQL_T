--некорректный тариф случая 2022
select distinct zsl.ID ,zsl.sumv, calc.lek
--from 
FROM [D3_SCHET_OMS] sch                  
inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id  
inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
JOIN D3_KSG_KPG_OMS ks  ON sl.id = ks.D3_SLID
left join [CalcKsg] calc on calc.K_KSG=ks.N_KSG and sl.DATE_2 between calc.DATEBEG and isnull(calc.DATEEND,'20991231')
left join SprBZTSZ bt on bt.USL_OK=zsl.usl_ok and sl.DATE_2 between bt.DBEG and bt.DEND
left join M001_ksg m1 on m1.IDDS=sl.DS1 

WHERE sl.TARIF<>round (convert(numeric(12,2),bt.BZTSZ) * ks.KOEF_Z *( (1-isnull(calc.lek,1)) + isnull(calc.lek,1)*isnull(case when calc.up is not null then 1 else ks.koef_up end,1)* 
CASE WHEN zsl.usl_ok=2 or calc.up is not null THEN 1.00  ELSE ISNULL(ks.KOEF_U,1.00) END  * ks.KOEF_D) +convert(numeric(12,2),bt.BZTSZ)* 
ks.KOEF_D  * case when isnull(ks.IT_SL,0)=0 then 0 else ks.IT_SL end ,2)
and sch.id=3920
and sl.DATE_2>='20220101'
--AND zsl.ID=3911950


--select * from [CalcKsg] where year(datebeg)=2022