declare @sc int = 7047 ---ID номера реестра из новой проги
DECLARE @ReestrMedOrgID INT = 2123 ---ID номера реестра из cтарой проги

--SELECT * FROM D3_SCHET_OMS AS dso

INSERT INTO [dbo].[D3_PACIENT_OMS]
([FAM],[IM],[OT],[W],[DR],[FAM_P],[IM_P],[OT_P],[W_P],[DR_P]
,[MR],[DOCTYPE],[DOCSER],[DOCNUM],[SNILS],[OKATOG],[OKATOP],[VPOLIS],[SPOLIS],[NPOLIS],[SMO],[SMO_OGRN],[SMO_OK],[SMO_NAM],[NOVOR], [D3_SCID] , ID_PAC)
select fam, im, ot, w, dr, FAM_P, IM_P, OT_P, W_P, DR_P
,mr, DOCTYPE, DOCSER, DOCNUM, SNILS, OKATOG, OKATOP, TypePolicy, SerPolis, Polis, q, Q_OGRN, OKATO_OMS, Q_Name,NOVOR,
sc.ID, pv.IDSLG
from PacientVisit pv 
join ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID AND r.ID = @ReestrMedOrgID
join D3_SCHET_OMS sc on sc.ID = @sc
WHERE pv.COMENTP is NULL-- AND pv.Doctor IN (SELECT id FROM @docTab)

INSERT INTO [dbo].[D3_ZSL_OMS] 
([VIDPOM],[NPR_MO],[RSLT],[ISHOD]
 ,[FOR_POM]
 ,USL_OK
 ,[DATE_Z_1],[DATE_Z_2]
,[OS_SLUCH_REGION],[IDSP], LPU
,[D3_SCID], [D3_PID], ZSL_ID
)
SELECT TypeHelp, 460025, HelpResult, HelpIshod,
CASE WHEN TypeSluch = 3 THEN  '2' ELSE 3 END, pv.ConditionHelp,
HelpStart, HelpEnd, OsobSluch, idsp, sc.CODE_MO, sc.ID, pa.ID, pv.IDSLG
FROM [dbo].[PacientVisit] pv
JOIN ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID AND r.ID = @ReestrMedOrgID
JOIN D3_PACIENT_OMS pa on pv.IDSLG = pa.ID_PAC
JOIN D3_SCHET_OMS sc on sc.ID = @sc
WHERE pv.COMENTP IS NULL --AND pv.Doctor IN (SELECT id FROM @docTab)

INSERT INTO [dbo].[D3_SL_OMS] 
([USL_OK],[LPU_1],[PODR],[PROFIL],[DET],[NHISTORY],[DATE_1],[DATE_2],[DS0],[DS1]
,[P_CEL25],[PRVS],[ED_COL],IDDOKT,SL_ID,D3_ZSLID)
SELECT ConditionHelp, LPU_1, PODR, pv.profil, [DetProfil], ISNULL(NHISTORY, pv.ID), HelpStart, HelpEnd, DS0, mkb
,CASE WHEN TypeSluch = 1 THEN  '1.0'
	  WHEN TypeSluch = 2 THEN  '2.1'
      WHEN TypeSluch = 3 THEN  '1.1'
END , pv.MSPID, ED_COL,d.SNILS,pv.IDSLG,zsl.ID
FROM [dbo].[PacientVisit] pv
JOIN ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID AND r.ID = @ReestrMedOrgID
JOIN D3_SCHET_OMS sc on sc.ID = @sc
JOIN D3_ZSL_OMS zsl on zsl.ZSL_ID = convert(nvarchar(36), pv.IDSLG)
LEFT JOIN DoctorBd d on pv.Doctor = d.id
WHERE pv.COMENTP IS NULL --AND pv.Doctor IN (SELECT id FROM @docTab)


INSERT INTO [dbo].[D3_USL_OMS]
([LPU_1],[PODR],[PROFIL],[DET],[DATE_IN],[DATE_OUT],[DS],[CODE_USL],[KOL_USL],[TARIF],[SUMV_USL],[PRVS],[CODE_MD]
,[VID_VME], D3_ZSLID, D3_SLID, D3_SLGID, COMENTU)
select [PodrMO], u.Otdelenie, u.profil, u.DetProfil, DateStart, DateEnd, Diagnoz, DISP_CODE, 1, 0, 0, u.MSPUID, d.SNILS
,[CodUslugi], zsl.ID, sl.ID, sl.SL_ID, ComentUslugi
from Uslugi u
JOIN PacientVisit pv on u.SluchID = pv.id
JOIN D3_SL_OMS sl on sl.SL_ID =convert(nvarchar(36), pv.IDSLG)
JOIN D3_ZSL_OMS zsl on zsl.ZSL_ID = convert(nvarchar(36), pv.IDSLG)
LEFT JOIN DoctorBd d on u.Doctor = d.id
WHERE pv.COMENTP IS NULL-- AND pv.Doctor IN (SELECT id FROM @docTab)

UPDATE pacientVisit SET COMENTP = GETDATE()
from PacientVisit pv 
join ReestrMedOrgDb r on pv.ReestrMedOrgID = r.ID
WHERE r.ID = @ReestrMedOrgID-- AND pv.Doctor IN (SELECT id FROM @docTab)