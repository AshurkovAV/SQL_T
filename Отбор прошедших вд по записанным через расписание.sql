DECLARE @ztemp_rec TABLE (
	[NOM] [varchar](50) NULL,
	[PRENOM] [varchar](100) NULL,
	[PATRONYME] [varchar](100) NULL,
	[NE_LE] [date] NULL,
	[DATE_START] [date] NULL,
	[NAME] [varchar](100) NOT NULL
)

DECLARE @d DATE = GETDATE()+1
--130151 - Котова
--130001 - Асеева
INSERT INTO @ztemp_rec(NOM,PRENOM,PATRONYME,NE_LE,DATE_START,NAME)
SELECT p2.NOM, p.PRENOM, p.PATRONYME, p2.NE_LE, p.DATE_START, ps.NAME
		FROM Sql_miac.G_EMISZKO_KGB6.dbo.PLANNING AS p
		JOIN Sql_miac.G_EMISZKO_KGB6.dbo.PATIENTS AS p2 ON p.PATIENTS_ID=p2.PATIENTS_ID
		JOIN Sql_miac.G_EMISZKO_KGB6.dbo.PL_SUBJ AS ps ON p.PL_SUBJ_ID = ps.PL_SUBJ_ID
		WHERE NE_LE < '20010101'-- p.KRN_CREATE_USER_ID IN(130151, 130001)
		AND CAST(p.DATE_CONS AS DATE) = @d AND p.DATE_CANCEL IS NULL

SELECT pr1.FAM, pr1.IM, pr1.OT, cast(pr1.DR AS DATE), date_start, NAME, AdrOmsRn, AdrOmsUl, AdrOmsDom, AdrOmsKorp, AdrOmsKv, cast(pr2.DATE_Z_2 AS DATE), 
CASE WHEN os_sluch_region = 22 THEN 'Диспанс. вз.' 
     WHEN os_sluch_region = 37 THEN 'Кал. вз.'
     WHEN os_sluch_region = 47 THEN 'Диспанс. вз. 2019' 
     WHEN os_sluch_region = 49 THEN 'ПО взр. 2019'
     WHEN os_sluch_region = 36 THEN 'Мамо. вз.'ELSE 'ПО взр.' END
FROM (

SELECT rec.*, pr.OKSM, pr.AdrOmsRegion, pr.AdrOmsRn, pr.AdrOmsNaspunkt, pr.AdrOmsUl, pr.AdrOmsDom, pr.AdrOmsKorp, pr.AdrOmsKv, pr.NameWithID, nam_smok, pr.Enp
--(SELECT f.namewithid FROM medic2.dbo.f003 f WHERE f.mcod=pr.PrMo)
FROM(SELECT * FROM @ztemp_rec AS zr	) AS rec
LEFT JOIN (
	SELECT p.*, f.NameWithID, nam_smok
	FROM [SQL_COD].[DocExchange].[dbo].[ATTP_People] p
	JOIN [SQL_COD].[DocExchange].[dbo].[SPR_79_F002] smo ON p.omssmo = smo.smocod
	JOIN [SQL_COD].[DocExchange].[dbo].SPR_79_F003 f ON f.mcod = p.prmo) pr ON rec.NOM = pr.Fam AND rec.PRENOM = pr.Im AND rec.PATRONYME = pr.Ot AND rec.NE_LE = pr.dr
) AS rec
LEFT JOIN (SELECT [FAM],[IM],[OT],[W],[DR],[DOCTP],[DOCS],[DOCN],[DOCDT],[DOCORG]
           FROM SQL_FOMS.SRZ.[dbo].[People] p) pr1 ON rec.NOM = pr1.Fam AND rec.PRENOM = pr1.Im AND rec.PATRONYME = pr1.Ot AND rec.NE_LE = pr1.dr
LEFT JOIN (SELECT [elmed_alt].[dbo].[F011].DocName, [elmed_alt].[dbo].[F011].IDDoc
             FROM [elmed_alt].[dbo].[F011]) AS f ON f.IDDoc = pr1.DOCTP
JOIN (SELECT fam, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2, dzo.OS_SLUCH_REGION
FROM [SERVER_elmed].[elmed].[dbo].D3_ZSL_OMS AS dzo
JOIN [SERVER_elmed].[elmed].[dbo].D3_PACIENT_OMS AS dpo ON dpo.ID = dzo.D3_PID
WHERE YEAR(dzo.DATE_Z_2) = 2019 AND dzo.OS_SLUCH_REGION IN (22,9,38,37,47,49)) AS pr2 ON rec.NOM = pr2.Fam AND rec.PRENOM = pr2.Im AND rec.PATRONYME = pr2.Ot AND rec.NE_LE = pr2.dr


