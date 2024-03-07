BEGIN TRAN --commit tran --rollback

DECLARE @D3_SCID_old INT = /*8836*/ /*9040*/ /*9230*/ /*9550*/ 14954  --старый реестр где они сейчас
DECLARE @D3_SCID_new INT = /*8684*/ /*8909*/ /*9397*/ /*9439*/ 18419  --новый реестр куда нужно перенести

UPDATE dpo SET dpo.D3_SCID = @D3_SCID_new

--SELECT dpo.id pid,dpo.D3_SCID p_sc
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
--JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
--JOIN temp_lis_mur_01_24_4431 z ON z.zsl_id = dzo.zsl_id --AND dpo.D3_SCID IN (5449,5688)
--JOIN temp_kokod_10_V_4745_1 z ON dpo.ID = z.PID AND z.schettype LIKE 'C'
--JOIN temp_lis_duble_8 z ON dpo.ID = z.pid --дубли ЛИС
--JOIN ztemp_lis_dnr_072022 z ON dpo.ID = z.D3_PID --днр ЛИС
--JOIN ztemp_digCdelete_112023_65 z ON dpo.ID = z.pid --перекресты
--JOIN ztemp_desh_Cdelete_012023_ds_ks_625 z ON dpo.ID = z.pid --AND z.ds_onk IS  null--дешевые
  -- JOIN [temp_lis_mur_9_6428_1] z ON dpo.ID = z.pid  --перенос МУР 
--JOIN temp_du_05_h z ON dpo.ID = z.pid
--JOIN ztemp_desh_Cdelete_102021_ks_new_1 z ON dpo.ID = z.pid  --80 ztemp_desh_Cdelete_022021_new
--JOIN ztemp_lis_0522 z ON dpo.ID = z.pid --объемы
--JOIN ztemp_protocol_11023 z ON dpo.ID = z.pid --протол
--JOIN temp_lis_duble_6_26 z ON dpo.ID = z.pid --лис перекрест
WHERE dzo.D3_SCID in /*9550*/ (18443) --AND ds_onk IS   null-- IN(Select 
--						--sch.month,nschet
--						id

--						FROM [D3_SCHET_OMS] sch  
--						WHERE YEAR=2022  AND nschet LIKE 'дешевые'
--						) AND dso.DS_ONK IS  NULL

UPDATE dz SET dz.D3_SCID = @D3_SCID_new --, dz.pr_nov=1--, sump=null
--SELECT *
FROM D3_ZSL_OMS AS dz
--JOIN ztemp_digCdelete_112023_65 z ON dz.id = z.zslid --перекресты
--JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dz.ID
--JOIN temp_lis_mur_01_24_4431 z ON z.zsl_id = dz.zsl_id --AND dz.D3_SCID IN (5449,5688)
--JOIN temp_lis_duble_8 z ON dz.id = z.zslid --дубли ЛИС
--JOIN ztemp_lis_dnr_072022 z ON dz.id = z.izslid --днр ЛИС
--JOIN ztemp_desh_Cdelete_012023_ds_ks_625 z ON dz.id = z.zslid-- AND z.ds_onk IS   null--дешевые
--JOIN [temp_lis_mur_9_6428_1] z ON dz.id = z.zslid --перенос МУР
--JOIN  ztemp_desh_Cdelete_052022_ds_80 z ON dz.id = z.zslid --дешевые
--JOIN temp_kokod_10_V_4745_1 z ON dz.id = z.zslid AND z.schettype LIKE 'C'
--JOIN  ztemp_covid_112021 z ON dz.id = z.zslid --ковид
--JOIN ztemp_lis_0522 z ON dz.id = z.zslid --V
--JOIN ztemp_protocol_11023 z ON dz.id = z.zslid --протокольные
--JOIN temp_lis_duble_6_26 z ON dz.id = z.zslid 
WHERE dz.D3_SCID in (18443) --AND ds_onk IS   null --(Select 
--						--sch.month,nschet
--						id

--						FROM [D3_SCHET_OMS] sch  
--						WHERE YEAR=2022  AND nschet LIKE 'дешевые'
--						) AND dso.DS_ONK IS  NULL



--rollback
--select * from  ztemp_protocol_08022
--SELECT * FROM lis_032022_17306
