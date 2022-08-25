declare @reestrid int = 5124
SELECT ID,  'IDCASE' IM_POL, 'SLUCH' BAS_EL,   NULL IDSERV, 
	   'Код МКБ 10 не соответствует профилю мед.помощи (Проверка Z у специалистов)' COMMENT
FROM PacientVisit t
where ConditionHelp = 3 and TypeSluch = 2 and PROFIL = 65 and MKB like 'Z%' and MKB <> 'Z01.0'
	  and MKB not between 'Z30' and 'Z35.9' and MKB not between 'Z39.0' and 'Z39.2'
and ReestrMedOrgID = @reestrid
UNION
SELECT ID,  'IDCASE' IM_POL, 'SLUCH' BAS_EL,   NULL IDSERV, 
	   'Код МКБ 10 не соответствует профилю мед.помощи (Проверка Z у специалистов)' COMMENT
FROM PacientVisit t
where ConditionHelp = 3 and TypeSluch = 2 and PROFIL in (162, 163) and MKB like 'Z%' and MKB <> 'Z01.1'
	  and MKB not between 'Z30' and 'Z35.9' and MKB not between 'Z39.0' and 'Z39.2'
and ReestrMedOrgID = @reestrid
UNION
SELECT ID,  'IDCASE' IM_POL, 'SLUCH' BAS_EL,   NULL IDSERV, 
	   'Код МКБ 10 не соответствует профилю мед.помощи (Проверка Z у специалистов)' COMMENT
FROM PacientVisit t
where ConditionHelp = 3 and TypeSluch = 2 and PROFIL in (63, 85, 86, 87, 88, 89, 90) and MKB like 'Z%' and MKB <> 'Z01.2'
	  and MKB not between 'Z30' and 'Z35.9' and MKB not between 'Z39.0' and 'Z39.2'
and ReestrMedOrgID = @reestrid
UNION
SELECT ID,  'IDCASE' IM_POL, 'SLUCH' BAS_EL,   NULL IDSERV, 
	   'Код МКБ 10 не соответствует профилю мед.помощи (Проверка Z у специалистов)' COMMENT
FROM PacientVisit t
where ConditionHelp = 3 and TypeSluch = 2 and PROFIL in (136, 137) and MKB like 'Z%' and MKB <> 'Z01.4' 
      and MKB not between 'Z30' and 'Z35.9' and MKB not between 'Z39.0' and 'Z39.2'
      and ReestrMedOrgID = @reestrid