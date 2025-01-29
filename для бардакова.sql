SELECT ap.Fam, ap.Im, ap.Ot, ap.Dr
	FROM ATTP_People AS ap
		JOIN ATTP_DISP_ACCOUNT AS d ON d.PID = ap.ID
WHERE ap.[Active] = 1 
		AND ap.Ds IS NULL
		AND ap.PrMo = 460013
		AND d.MO = 460013
		AND d.DATEEND IS NULL
		AND ap.AdrOmsUl LIKE '%Подлес%'
		