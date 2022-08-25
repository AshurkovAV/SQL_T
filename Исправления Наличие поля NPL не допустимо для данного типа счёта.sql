--Наличие поля NPL не допустимо для данного типа счёта
UPDATE usl SET npl = null
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
      --SL---------------------------------------------------------------------
      inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
        ----OnkSl---------------------------------------------
        inner join D3_USL_OMS usl on sl.id=usl.D3_SLID
      ---------------------------------------------------------------------------
where 
  p.D3_SCID = 5518 and
  --------------------
  sch.SchetType in ('DA','DB','DF','DO','DP','DS','DU','DV','T','RDA','RDB')
  and usl.npl is not null