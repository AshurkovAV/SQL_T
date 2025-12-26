SELECT kf.*
FROM [komorbid_foms$] AS kf
	LEFT JOIN [f_ashur_reestr](2025) k ON kf.Фамилия = k.FAM AND kf.Имя = k.IM AND kf.Отчество = k.OT AND kf.ДР = k.Dr
		LEFT JOIN Perepis AS p ON p.FAM = kf.Фамилия AND p.IM = kf.Имя AND p.OT = kf.Отчество AND p.Dr = kf.ДР
WHERE k.FAM IS NULL AND p.FAM IS NULL
	

