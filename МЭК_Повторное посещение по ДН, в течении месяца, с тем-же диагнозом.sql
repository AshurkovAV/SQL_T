ALTER PROCEDURE [dbo].[p_autoMEK_ReDN]
  @scid int 
 
AS
  --exec p_autoMEK_ReDN @p1

  declare @year int
  declare @period date

  select 
    distinct @year = sch.YEAR,@period = sch.period
  from [D3_SCHET_OMS] sch
  where
    sch.id = @scid

  ;with z as 
    (  
      SELECT ROW_NUMBER() OVER (PARTITION BY p.FAM,p.IM,p.OT,p.DR,sl.ds,YEAR(zsl.DATE_z_2),MONTH(zsl.DATE_z_2) 
                    ORDER BY p.FAM,p.IM,p.OT,p.DR,sl.ds,zsl.DATE_Z_2,zsl.id) RN
                    ,p.FAM,p.IM,p.OT,p.DR,zsl.ID, zsl.DATE_Z_1, zsl.DATE_Z_2,zsl.SUMV,zsl.VIDPOM,sl.ds,zsl.os_sluch_region
      FROM [D3_SCHET_OMS] sch                  
        inner join D3_PACIENT_OMS p on p.d3_scid = sch.id 
          inner join D3_ZSL_OMS zsl on zsl.D3_PID = p.id
            cross apply
              (
              select
                sl.d3_zslid,left(sl.DS1,3) ds
                ,count(*) kol
              from d3_sl_oms sl 
              where 
                sl.d3_zslid=zsl.id
              group by 
                sl.d3_zslid,left(sl.DS1,3)
              ) sl

        left join d3_sank_oms sank 
            on sank.D3_ZSLID = zsl.id 
            and sank.s_tip = 1
      where
        zsl.OS_SLUCH_REGION IN (59,63)
        and sank.ID is null
        and sch.period = @period
    )
  

  SELECT 
    Distinct 
    zsl.ID
    ,zsl.SUMV
    ,'Повторное посещение по ДН, в течении месяца, с тем-же диагнозом' com
  FROM [D3_SCHET_OMS] sch                  
    inner join D3_PACIENT_OMS p on p.d3_scid = sch.id 
      inner join D3_ZSL_OMS zsl on zsl.D3_PID = p.id
        inner join z 
            on z.ID = zsl.ID 
            and z.RN > 1

        left join d3_sank_oms sank 
            on sank.D3_ZSLID = zsl.id 
            and sank.S_TIP = 1 
  WHERE  
    sank.ID is null