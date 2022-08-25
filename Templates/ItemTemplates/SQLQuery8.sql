(SELECT db.FAM + ' ' + im + ' ' + ot  FROM DoctorBd AS db WHERE db.id = u.CODE_MDLPU), 
(SELECT scd.NameWithId FROM v015 AS scd WHERE scd.id = u.MSPUID)