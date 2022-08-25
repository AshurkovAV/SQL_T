select (SELECT CalcKsgTarif.IDKSG from CalcKsgTarif where ID = u.IDKSG),
(select KSGNAME from CalcKsgTarif where ID = u.IDKSG), 
count(*) cnt, sum(u.SUMV_USL) [SUM]   from sluch sl
join usl u on sl.ID = u.SLID and left(u.CODE_USL, 2 ) ='TF'
join schet sc on sl.SCHET_ID = sc.ID
where sl.SCHET_ID IN (8, 7, 9, 12, 13, 16)
AND sl.USL_OK IN  (1) AND YEAR(sl.DATE_2) = 2016
group by u.IDKSG