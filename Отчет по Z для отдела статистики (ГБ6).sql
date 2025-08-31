SELECT 
        sum(case when s.ds1 = 'Z01.0' then 1 else 0  end )as  'Z01.0',
        sum(case when s.ds1 = 'Z01.1' then 1 else 0 end )as 'Z01.1',
        sum(case when s.ds1 = 'Z01.2' then 1 else 0 end ) as 'Z01.2',
        sum(case when s.ds1 = 'Z01.3' then 1 else 0 end) as 'Z01.3',
        sum(case when s.ds1 = 'Z01.4' then 1 else 0 end ) as 'Z01.4',
        sum(case when s.ds1 = 'Z01.5' then 1 else 0 end) as 'Z01.5',
        sum(case when s.ds1 = 'Z01.6' then 1 else 0 end) as 'Z01.6',
        sum(case when s.ds1 = 'Z01.8' then 1 else 0 end) as 'Z01.8',
        sum(case when s.ds1 = 'Z02'   then 1 else 0 end) as 'Z02',
        sum(case when s.ds1 = 'Z02.4' then 1 else 0 end) as 'Z02.4',
        sum(case when s.ds1 = 'Z02.5' then 1 else 0 end) as 'Z02.5',
        sum(case when s.ds1 = 'Z02.7' then 1 else 0 end) as 'Z02.7',
        sum(case when s.ds1 = 'Z02.8' then 1 else 0 end) as 'Z02.8',
        
        sum(case when s.ds1 = 'Z03.8' then 1 else 0 end) as 'Z03.8',
        sum(case when s.ds1 = 'Z11.5' then 1 else 0 end) as 'Z11.5',
        sum(case when s.ds1 = 'Z20.8' then 1 else 0 end) as 'Z20.8',
        
        
        sum(case when s.ds1 = 'Z22'   then 1 else 0 end) as 'Z22',
        sum(case when s.ds1 = 'Z22.8' then 1 else 0 end) as 'Z22.8',        
        sum(case when s.ds1 between 'Z23' and 'Z27' then 1 else 0 end) as 'Z23-Z27',
        sum(case when s.ds1 between 'Z30' and 'Z39' then 1 else 0 end) as 'Z30-Z39',
        sum(case when s.ds1 = 'Z72.0' then 1 else 0 end) as 'Z72.0',
        sum(case when s.ds1 = 'Z76.0' then 1 else 0 end) as 'Z76.0'
        
FROM  D3_ZSL_OMS zs 
INNER JOIN D3_PACIENT_OMS p ON zs.D3_PID = p.ID 
INNER JOIN D3_SL_OMS s on s.D3_ZSLID=zs.ID  
JOIN D3_SCHET_OMS AS dso ON dso.ID = zs.D3_SCID
WHERE ((dso.[YEAR] IN (2025) --AND dso.NSCHET LIKE '%+%')
)) AND 
 --year(p.DR) = 2019 
--zs.D3_SCID in (67, 69,72,75,77, 80,84,89,93) AND 
--(datediff(dd,p.DR,s.DATE_1)/365.25)<1
--(datediff(dd,p.DR,s.DATE_1)/365.25)<15    
--((datediff(dd,p.DR,s.DATE_1)/365.25)>=15 and (datediff(dd,p.DR,s.DATE_1)/365.25)<18)
(datediff(dd,p.DR,s.DATE_1)/365.25)>18

 
--число физических лиц

--SELECT COUNT(*)
--FROM  D3_ZSL_OMS zs 
--INNER JOIN D3_PACIENT_OMS p ON zs.D3_PID = p.ID 
--INNER JOIN D3_SL_OMS s on s.D3_ZSLID=zs.ID  
--WHERE zs.D3_SCID in (67, 69,72,75,77, 80,84,89,93) and 
--(datediff(dd,p.DR,s.DATE_1)/365.25)<15  AND 
--ds1 LIKE 'Z%' AND 
--s.DS1_PR IS NOT NULL --в первые в жизни 
----AND ((datediff(dd,p.DR,s.DATE_1)/365.25)>=15 and (datediff(dd,p.DR,s.DATE_1)/365.25)<18)
----AND (datediff(dd,p.DR,s.DATE_1)/365.25)<1
--GROUP BY p.FAM, p.IM, p.OT, p.DR


----число физических лиц за год
--SELECT COUNT(*)
--FROM  D3_ZSL_OMS zs 
--INNER JOIN D3_PACIENT_OMS p ON zs.D3_PID = p.ID 
--INNER JOIN D3_SL_OMS s on s.D3_ZSLID=zs.ID  
--JOIN D3_SCHET_OMS AS dso ON dso.ID = zs.D3_SCID
--WHERE dso.[YEAR] IN (2019) and
----(datediff(dd,p.DR,s.DATE_1)/365.25)<15  AND 
--ds1 LIKE 'Z%' AND 
--s.DS1_PR IS NOT NULL --в первые в жизни 
----AND ((datediff(dd,p.DR,s.DATE_1)/365.25)>=15 and (datediff(dd,p.DR,s.DATE_1)/365.25)<18)
--AND (datediff(dd,p.DR,s.DATE_1)/365.25)<1
--GROUP BY p.FAM, p.IM, p.OT, p.DR




--SELECT P_CEL25,  SUM(kol)kol, SUM(det)det
--	FROM(
--			SELECT 
--					(SELECT v.NameWithID
--					   FROM V025 AS v WHERE v.IDPC = s.P_CEL25)P_CEL25, 
--					 CASE WHEN (datediff(dd,p.DR,s.DATE_1)/365.25)<18 THEN 1 ELSE 0 END det,  
--					 1 kol
        
--			FROM  D3_ZSL_OMS zs 
--			INNER JOIN D3_PACIENT_OMS p ON zs.D3_PID = p.ID 
--			INNER JOIN D3_SL_OMS s on s.D3_ZSLID=zs.ID  
--			JOIN D3_SCHET_OMS AS dso ON dso.ID = zs.D3_SCID
--			WHERE ((dso.[YEAR] IN (2024) AND dso.NSCHET LIKE '%+%'))  
--			AND zs.USL_OK = 3
--			--AND (datediff(dd,p.DR,s.DATE_1)/365.25)>18
--	) AS t1
--GROUP BY P_CEL25