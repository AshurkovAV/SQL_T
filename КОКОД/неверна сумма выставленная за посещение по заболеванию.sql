DECLARE @p1 INT=560;
SELECT distinct zsl.id as ID, zsl.sumv as SUMV,''com, sl.profil,pr.prname,  sl.iddokt, w.fio,sl.nhistory,p.fam,p.im,p.ot,date_z_1 --неверна сумма выставленная за посещение по заболеванию

from D3_SCHET_OMS sch
  inner  join D3_PACIENT_OMS p on sch.id=p.D3_SCID
  inner join D3_ZSL_OMS zsl on zsl.D3_PID=p.id
  inner join D3_SL_OMS sl on sl.D3_ZSLID=zsl.ID
  left join v002 pr on sl.profil=pr.idpr 
  left join [workerkokod] w on w.snils=dbo.p_digit_only( sl.iddokt)
  
where 
sch.id  in (560,562)--@p1
  and sl.p_cel25='1.0' 
  and zsl.usl_ok=3
  and year(zsl.date_z_2)=2020
  -------------------
  and zsl.sumv not in 
    (
      --404.5,535.74,355.25,730.84,673.04,421.44,533.33,378.46,306.24,495.90,294.94,252.83,305.16,415.30
      265.81,352.04,233.44,480.25,442.26,
      276.94,350.46,248.69,201.24,325.87,
      193.81,166.14,200.53,272.90
    )
	and sch.code_mo not in (460025,460020,460064,460068,460144,460088)