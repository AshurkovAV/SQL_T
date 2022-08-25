SELECT *
FROM PATIENTS AS p
WHERE p.NOM = 'махова' AND p.PRENOM = 'ольга' AND p.PATRONYME = 'игоревна'

UPDATE d SET d.isDownload = 1
  FROM [EMK].[dbo].[DirectionOdli] d
WHERE StatusOdli = 4 AND isDownload = 0 AND NameFileResult IS NOT NULL