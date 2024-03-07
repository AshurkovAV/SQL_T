--declare @p1 int =1
--update usl set usl.vid_vme=sl.METOD_HMP
select 
 sch.id, usl.vid_vme,sl.METOD_HMP,sl.date_2,sl.nhistory --VID_VME  не из справочника V019 при ВМП
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
    inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id and zsl.D3_SCID=sch.id
      inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
        inner join D3_USL_OMS usl on sl.id=usl.D3_SLID
        --------------------------------------------
        --left join nsi.dbo.V019 v019 on usl.vid_vme=v019.IDHM AND sl.DATE_2 BETWEEN v019.DATEBEG AND v019.DATEEND
where 
 sch.year=2020 AND sch.month=4
  ---------------
  and usl.vid_vme not like sl.METOD_HMP
 --and usl.vid_vme is not null
  --and v019.IDHM is null
  and zsl.vidpom=32