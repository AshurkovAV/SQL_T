declare @sc int = 2059 ---ID номера реестра из новой проги
DECLARE @ReestrMedOrgID INT = 5112 ---ID номера реестра из cтарой проги

INSERT INTO [dbo].[PACIENT]
([FAM],[IM],[OT],[W],[DR],[FAM_P],[IM_P],[OT_P],[W_P],[DR_P]
,[MR],[DOCTYPE],[DOCSER],[DOCNUM],[SNILS],[OKATOG],[OKATOP],[VPOLIS],[SPOLIS],[NPOLIS],[SMO],[SMO_OGRN],[SMO_OK],[SMO_NAM],[NOVOR],[SCHET_ID], ID_PAC)
select fam, im, ot, w, dr, FAM_P, IM_P, OT_P, W_P, DR_P
,mr, DOCTYPE, DOCSER, DOCNUM, SNILS, OKATOG, OKATOP, TypePolicy, SerPolis, Polis, q, Q_OGRN, OKATO_OMS, Q_Name,NOVOR,
sc.ID, pv.IDSLG
from PacientVisit pv 
join ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID AND r.ID = @ReestrMedOrgID
join SCHET sc on sc.ID = @sc
WHERE pv.COMENTP is null

INSERT INTO [dbo].[D3_ZSL] 
([VIDPOM],[NPR_MO],[RSLT],[ISHOD]
 ,[FOR_POM]
 ,[DATE_Z_1],[DATE_Z_2]
,[OS_SLUCH_REGION],[IDSP], LPU
,[D3_SCID], [D3_PID], ZSL_ID
)
SELECT
TypeHelp, [NPR_MO], HelpResult, HelpIshod
,CASE
WHEN TypeSluch = 3 THEN  '2'
ELSE 3
END 
,HelpStart, HelpEnd,
OsobSluch, idsp, sc.CODE_MO,
sc.ID, pa.ID, pv.IDSLG
FROM [dbo].[PacientVisit] pv
join ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID AND r.ID = @ReestrMedOrgID
join PACIENT pa on pv.IDSLG = pa.ID_PAC
join SCHET sc on sc.ID = @sc
WHERE pv.COMENTP is null


INSERT INTO [dbo].[D3_SL] 
([USL_OK],[LPU_1],[PODR],[PROFIL],[DET],[NHISTORY],[DATE_1],[DATE_2],[DS0],[DS1]
,[P_CEL]
,[PRVS]
,[ED_COL]
,IDDOKT
,SL_ID
,D3_ZSLID)

SELECT
ConditionHelp, LPU_1, PODR, pv.Profil, [DetProfil], ISNULL(NHISTORY, pv.ID), HelpStart, HelpEnd, DS0, mkb
,CASE
WHEN TypeSluch = 1 THEN  '1.3'
WHEN TypeSluch = 2 THEN  '1.1'
WHEN TypeSluch = 3 THEN  '2.0'
END 
,MSPID
, ED_COL, 
d.SNILS, 
pv.IDSLG,
zsl.ID
FROM [dbo].[PacientVisit] pv
join ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID AND r.ID = @ReestrMedOrgID
join SCHET sc on sc.ID = @sc
join D3_ZSL zsl on zsl.ZSL_ID = pv.IDSLG
left join DoctorBd d on pv.Doctor = d.id
WHERE pv.COMENTP is null



INSERT INTO [dbo].[D3_USL]
([LPU_1],[PODR],[PROFIL],[DET],[DATE_IN],[DATE_OUT],[DS],[CODE_USL],[KOL_USL],[TARIF],[SUMV_USL],[PRVS],[CODE_MD]
,[VID_VME], D3_ZSLID, D3_SLID, D3_SLGID, COMENTU)
select [PodrMO], u.Otdelenie, u.Profil, u.DetProfil, DateStart, DateEnd, Diagnoz, DISP_CODE, 1, 0, 0, MSPUID, d.SNILS
,[CodUslugi], zsl.ID, sl.ID, sl.SL_ID, ComentUslugi
from Uslugi u
join PacientVisit pv on u.SluchID = pv.id
join D3_SL sl on sl.SL_ID = pv.IDSLG
join D3_ZSL zsl on zsl.ZSL_ID = pv.IDSLG
left join DoctorBd d on u.Doctor = d.id
WHERE pv.COMENTP is null




UPDATE pacientVisit SET COMENTP = 'Выгружен'
from PacientVisit pv 
join ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID
WHERE r.ID = @ReestrMedOrgID