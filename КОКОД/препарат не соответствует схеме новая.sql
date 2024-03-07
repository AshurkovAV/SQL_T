DECLARE @p1 INT=348
--лекарственный препарат не соотвествует схеме

SELECT DISTINCT --zs.id,s.ID,REGNUM, zs.SUMV
sch.month,sch.id, zs.ID, zs.SUMV, '' com
--  ,p.fam, p.im, p.dr, zs.DATE_Z_1, zs.DATE_Z_2, crit.CRIT 
 ,REGNUM--, lp.code_sh, n021.*,case when REGNUM=n021.[ID_LEKP] then 1 else 0 end
FROM [D3_SCHET_OMS] sch                  
  join D3_PACIENT_OMS p on p.d3_scid=sch.id --and sch.id=@p1 
          and sch.year=2021
        and sch.month=7
  join D3_ZSL_OMS zs on zs.D3_PID=p.id
  join D3_SL_OMS s on s.D3_ZSLID=zs.ID  
  join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id  
  join D3_ONK_USL_OMS ou on ou.D3_ONKSLID=onk.id  
  join D3_LEK_PR_OMS lp on lp.D3_ONKUSLID=ou.id  
  JOIN [N021] n021 ON n021.[CODE_SH]=lp.[CODE_SH]  AND zs.DATE_Z_2 BETWEEN n021.DATEBEG AND ISNULL(n021.DATEEND,'22000101')
  --LEFT JOIN v024 ON v024.IDDKK=lp.CODE_SH AND YEAR(v024.DATEBEG)=YEAR(date_z_2)
  --LEFT JOIN v024 v24 ON v24.IDDKK=n021.CODE_SH AND YEAR(v24.DATEBEG)=YEAR(date_z_2)
  --LEFT JOIN n021 n21 ON n21.[CODE_SH]=lp.[CODE_SH] and lp.REGNUM=n21.[ID_LEKP] AND zs.DATE_Z_2 BETWEEN n21.DATEBEG AND ISNULL(n21.DATEEND,'22000101')
  LEFT JOIN D3_KSG_KPG_OMS AS ksg ON ksg.D3_SLID=s.ID
  LEFT JOIN D3_CRIT_OMS AS crit ON crit.D3_KSGID=ksg.ID
--WHERE s.nhistory like '916/03368'
group by sch.month,sch.id,zs.ID, zs.SUMV, REGNUM
having sum(case when REGNUM=n021.[ID_LEKP] then 1 else 0 end)=0