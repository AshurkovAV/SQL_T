SELECT *
FROM PATIENTS AS p
WHERE p.NOM = '������' AND p.PRENOM = '�����' AND p.PATRONYME = '��������'

UPDATE d SET d.isDownload = 1
  FROM [EMK].[dbo].[DirectionOdli] d
WHERE StatusOdli = 4 AND isDownload = 0 AND NameFileResult IS NOT NULL