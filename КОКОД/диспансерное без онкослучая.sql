BEGIN TRAN --commit tran
INSERT INTO [D3_ONK_SL_OMS] (
      [D3_SLID]
      ,[D3_SLGID]
      ,[DS1_T]
      ,[STAD]
 
)
SELECT  --ds1,iddokt,
     s.id
      ,s.SL_ID
    ,4
    ,t.stad
--BEGIN TRAN --commit tran
--UPDATE s SET s.P_CEL25='1.0', dn=null
SELECT distinct sch.id AS shit,kp.fam+' '+kp.im+' '+ kp.ot  fio,  zs.ID AS zslid, s.id AS slid, s.NHISTORY, s.DATE_1, p.fam, p.im, s.ds1, mos.DS_NAME, onk.stad ,t.stad
--into temp_disp_10
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2022 and sch.month=10 --and sch.id in (8454)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id    and zs.usl_ok in (3) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID   
 JOIN temp_disp_10 t ON t.slid=s.id
 left join D3_ONK_SL_OMS onk on onk.D3_SLID=s.id
 LEFT JOIN kokod_podr AS kp ON kp.IDDOCT=dbo.f_digit_only(iddokt) AND zs.usl_ok=kp.usl_ok
 LEFT JOIN M001_oplata_status AS mos ON mos.IDDS=s.ds1
WHERE --s.P_CEL25  LIKE '1.3'
onk.DS1_T IS NULL AND s.P_CEL25  LIKE '1.3' --AND 
                                            
                                          --  select * from temp_disp_5