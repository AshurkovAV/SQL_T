SELECT (SELECT ads.FAM + ' ' + ads.IM + ' ' + ads.OT
          FROM AttachedDoctorSpr AS ads WHERE ads.SNILS = (SELECT doc.SNILS
          FROM sql_online.[ELMED_ONLINE].[dbo].AttachedUchDoct_ONLINE doc WHERE doc.ID = ID_DOCT)),
          (SELECT doc.SNILS
          FROM sql_online.[ELMED_ONLINE].[dbo].AttachedUchDoct_ONLINE doc WHERE doc.ID = ID_DOCT),
           COUNT(*)
  FROM sql_online.[ELMED_ONLINE].[dbo].[AttachedPeople_ONLINE]
WHERE id_mo = 460026
GROUP BY ID_DOCT