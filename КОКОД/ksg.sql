DECLARE @month INT = 9
-------------------------------------------------------  
    update k set d3_slgid = sl_id
    --select count(*)
    FROM [dbo].[D3_KSG_KPG_OMS] k
    inner join d3_sl_oms sl on k.d3_slid = sl.id
    inner join d3_zsl_oms zsl on sl.d3_zslid=zsl.id
    inner join d3_schet_oms sch on zsl.D3_SCID=sch.id
    where 
    sch.YEAR=2019 and sch.month=@month
    ---------------------
    and (d3_slgid is null or d3_slgid <> sl_id)
-------------------------------------------------------
    update k set [KSG_ID] = newid()
    --select count(*)
    FROM [dbo].[D3_KSG_KPG_OMS] k
        inner join d3_sl_oms sl on k.d3_slid = sl.id
        inner join d3_zsl_oms zsl on sl.d3_zslid=zsl.id
        inner join d3_schet_oms sch on zsl.D3_SCID=sch.id
    where 
      sch.YEAR=2019 and sch.month=@month
      and KSG_ID is null 
----------------------------------------------------------
    update ko set [D3_KSGGID] = [KSG_ID]
    --select count(*)
    FROM [dbo].[D3_SL_KOEF_OMS] ko
      inner join [dbo].[D3_KSG_KPG_OMS] k on k.ID = ko.D3_KSGID
      inner join d3_sl_oms sl on k.d3_slid = sl.id
      inner join d3_zsl_oms zsl on sl.d3_zslid=zsl.id
      inner join d3_schet_oms sch on zsl.D3_SCID=sch.id
    where 
      sch.YEAR=2019 and sch.month=@month
      and (D3_KSGGID is null or D3_KSGGID <> KSG_ID)
----------------------------------------------------------
    update c set [D3_KSGGID] = [KSG_ID]
    --select count(*)
    FROM  [dbo].[D3_CRIT_OMS] c
      inner join [dbo].[D3_KSG_KPG_OMS] k on k.ID = c.D3_KSGID
      inner join d3_sl_oms sl on k.d3_slid = sl.id
      inner join d3_zsl_oms zsl on sl.d3_zslid=zsl.id
      inner join d3_schet_oms sch on zsl.D3_SCID=sch.id
    where 
      sch.YEAR=2019 and sch.month=@month
      ---
      and ([D3_KSGGID] is null or [D3_KSGGID] <> [KSG_ID])