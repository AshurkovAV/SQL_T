SELECT 
ms.code_usl, ms.name, 
(SELECT kun.NameWithID
   FROM [Yamed_Spr_UslCode] AS kun WHERE kun.ID = duo.VID_VME),
(SELECT ysme.NameWithID
   FROM Yamed_Spr_MedicalEmployee AS ysme WHERE ysme.SNILS = dso.IDDOKT), COUNT(*)
FROM D3_ZSL_OMS AS dzo
	JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
	JOIN D3_USL_OMS AS duo ON duo.D3_SLID = dso.ID
	left join medicalServices ms on ms.code_usl =duo.CODE_USL and dso.DATE_2 between ms.dataBegin and isnull(ms.dataend,'20991231')	
WHERE dzo.D3_SCID = 20225 AND dzo.OS_SLUCH_REGION IS NULL
AND dso.P_CEL25 = '2.3'
GROUP BY ms.code_usl, ms.name, duo.VID_VME, dso.IDDOKT



select DISTINCT  
      
     
--,sch.month as [Месяц]        
--  ,sch.YEAR[Год]  
  iddokt  [врач]  
  ,ms.code_usl  
   ,ms.name        
  ,y.namewithid        
  --, s.NHISTORY as [Номер истории]        
  ,count(zs.id)        
       
        
FROM [D3_SCHET_OMS] sch                          
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id        
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id         
join D3_SL_OMS s on s.D3_ZSLID=zs.ID         
join d3_usl_oms usl on usl.D3_SLID=s.id        
join  [medicalServices] ms on ms.[code_usl]=usl.code_usl   AND usl.DATE_IN >=ms.dataBegin AND usl.DATE_OUT<=ISNULL(ms.dataEnd,'20991231')      
left join Yamed_Spr_UslCode y on y.ID=usl.vid_vme        

left join f002 on f002.smocod=p.smo
 --LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
where  sch.code_mo=460026 and sch.year=2023 AND sch.[MONTH] = 1  and isnull(zs.pr_nov,0)=0  
group by iddokt    
  ,ms.code_usl  
   ,ms.name        
  ,y.namewithid