SELECT 
sum(case when s.ds1 between 'Z00' and 'Z99%' then 1 
                        else 0  end )as  'Z00-Z99',
    sum(case when s.ds1 between 'Z00' and 'Z13%' then 1 
                        else 0 end )as 'Z00-Z13',
       sum( case when s.ds1 like 'Z02.7' then 1 else 0 end ) as 'Z02.7',
       sum(case when s.ds1 between 'Z20' and 'Z29%' then 1 else 0 end) as 'Z20-Z29',
        sum(case when s.ds1 like 'Z22' then 1 else 0 end ) as 'Z22',
        sum(case when s.ds1 between 'Z30' and 'Z39%' then 1 else 0 end) as 'Z30-Z39',
        sum(case when s.ds1 between 'Z40' and 'Z54%' then 1 else 0 end) as 'Z40-Z54',
        sum(case when s.ds1 like 'Z50' then 1 else 0 end) as 'Z50',
       sum( case when s.ds1 like 'Z51.5' then 1 else 0 end) as 'Z51.5',
        sum(case when s.ds1 between 'Z55' and 'Z65%' then 1 else 0 end) as 'Z55-Z65',
        sum(case when s.ds1 between 'Z70' and 'Z76%' then 1 else 0 end) as 'Z70-Z76',
        sum(case when s.ds1 like 'Z72' then 1 else 0 end) as 'Z72',
        sum(case when s.ds1 between 'Z80' and 'Z90%' then 1 else 0 end) as 'Z80-Z90',
        sum(case when s.ds1 between 'Z80' and 'Z84%' then 1 else 0 end) as 'Z80-Z84',
        sum(case when (s.ds1 like 'Z93.2' or s.ds1 like 'Z93.2') then 1 else 0 end) as 'Z93.2-Z93.3'
        
FROM  D3_ZSL_OMS zs 
INNER JOIN D3_PACIENT_OMS p ON zs.D3_PID = p.ID 
INNER JOIN D3_SL_OMS s on s.D3_ZSLID=zs.ID
JOIN D3_SCHET_OMS AS dso ON dso.ID = zs.D3_SCID  
WHERE dso.[YEAR] IN (2021) AND  
--zs.D3_SCID in (2127,2136,2141, 2146,2152,2155, 2159, 2162, 2170) AND 
 --(datediff(dd,p.DR,s.DATE_1)/365.25)<1  
--(datediff(dd,p.DR,s.DATE_1)/365.25)<15  
 --((datediff(dd,p.DR,s.DATE_1)/365.25)>15 and (datediff(dd,p.DR,s.DATE_1)/365.25)<18)
(datediff(dd,p.DR,s.DATE_1)/365.25)>18  
