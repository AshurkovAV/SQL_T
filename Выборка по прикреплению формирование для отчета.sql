DECLARE @ztemp_rec TABLE (
	[NOM] [varchar](50) NULL,
	[PRENOM] [varchar](100) NULL,
	[PATRONYME] [varchar](100) NULL,
	[NE_LE] [date] NULL,
	[DATE_START] [date] NULL,
	[NAME] [varchar](100) NOT NULL
)

DECLARE @d DATE = GETDATE()
--130151 - Котова
--130001 - Асеева
INSERT INTO @ztemp_rec(NOM,PRENOM,PATRONYME,NE_LE,DATE_START,NAME)
SELECT p2.NOM, p.PRENOM, p.PATRONYME, p2.NE_LE, p.DATE_START, ps.NAME
		FROM Sql_miac.G_EMISZKO_KGB6.dbo.PLANNING AS p
		JOIN Sql_miac.G_EMISZKO_KGB6.dbo.PATIENTS AS p2 ON p.PATIENTS_ID=p2.PATIENTS_ID
		JOIN Sql_miac.G_EMISZKO_KGB6.dbo.PL_SUBJ AS ps ON p.PL_SUBJ_ID = ps.PL_SUBJ_ID
		WHERE --p.KRN_CREATE_USER_ID IN(130151, 130001)
		 CAST(p.DATE_CONS AS DATE) = @d AND p.DATE_CANCEL IS NULL

SELECT *
FROM (

SELECT rec.*, pr.OKSM, pr.AdrOmsRegion, pr.AdrOmsRn, pr.AdrOmsNaspunkt, pr.AdrOmsUl, pr.AdrOmsDom, pr.AdrOmsKorp, pr.AdrOmsKv, pr.NameWithID, nam_smok, pr.Enp
--(SELECT f.namewithid FROM medic2.dbo.f003 f WHERE f.mcod=pr.PrMo)
FROM(SELECT * FROM @ztemp_rec AS zr	) AS rec
LEFT JOIN (
	SELECT p.*, f.NameWithID, nam_smok
	FROM [SQL_COD].[DocExchange].[dbo].[ATTP_People] p
	JOIN [SQL_COD].[DocExchange].[dbo].[SPR_79_F002] smo ON p.omssmo = smo.smocod
	JOIN [SQL_COD].[DocExchange].[dbo].SPR_79_F003 f ON f.mcod = p.prmo) pr ON rec.NOM = pr.Fam AND rec.PRENOM = pr.Im AND rec.PATRONYME = pr.Ot AND rec.NE_LE = pr.dr

WHERE pr.PrMo != 460026) AS rec
LEFT JOIN (SELECT [FAM],[IM],[OT],[W],[DR],[DOCTP],[DOCS],[DOCN],CAST(DOCDT AS DATE)DOCDT,[DOCORG]
           FROM SQL_FOMS.SRZ.[dbo].[People] p) pr1 ON rec.NOM = pr1.Fam AND rec.PRENOM = pr1.Im AND rec.PATRONYME = pr1.Ot AND rec.NE_LE = pr1.dr
LEFT JOIN (SELECT [medic2].[dbo].[F011].DocName, [medic2].[dbo].[F011].IDDoc
             FROM [medic2].[dbo].[F011]) AS f ON f.IDDoc = pr1.DOCTP


