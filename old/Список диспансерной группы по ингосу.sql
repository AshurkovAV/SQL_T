SELECT pv.FAM, im, ot, 
cast(dr AS DATE)dr, pv.Polis, pv.MKB, pv.Profil, (SELECT v.PRNAME
                                                           FROM V002 AS v WHERE v.IDPR = profil),  
cast(pv.HelpStart AS DATE)
FROM PacientVisit AS pv
WHERE pv.ConditionHelp = 3 AND pv.OsobSluch IN(1,22,9)
AND pv.Q = 46003 AND pv.HelpResult in (353,357,358)