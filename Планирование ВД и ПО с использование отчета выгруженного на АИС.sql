DROP TABLE ztemp_spdu_20052025
SELECT tt.квартал, tt.Fam, tt.Im, tt.Ot, tt.dr,
CASE WHEN w = 1 THEN 'Мужской'
    WHEN w = 2 THEN 'Женский'
    ELSE 'Нет' END [пол], tt.[номер полиса], tt.НАШНОМЕРУЧАСТКА, ''[отметка о вызове], tt.тип, tt.DATE_Z_1, tt.DATE_Z_2, tt.DRNAME, t2.DATE_Z_1 DATE_Z_12, t2.DATE_Z_2 DATE_Z_22, t2.DRNAME DRNAME2
  ,t.tel tel, addr
INTO ztemp_spdu_20052025
FROM (


SELECT dl.TargetQuarter [квартал], dl.Fam, dl.Im, dl.Ot, 
CAST(dl.Dr AS DATE)dr, 
dl.ENP[номер полиса],
[НАШНОМЕРУЧАСТКА], 
CASE WHEN dl.DispType ='ДВ4' THEN 'ДВ4 Первый этап диспансеризации определенных групп взрослого населения'
  WHEN dl.DispType ='ОПВ' THEN 'ОПВ Профилактические медицинские осмотры взрослого населения'
  WHEN dl.DispType ='УД1' THEN 'УД1 Первый этап углубленной диспансеризации определенных групп взрослого населения'
  WHEN dl.DispType ='ДР1_Ж' THEN 'Репродуктивка женская'
  WHEN dl.DispType ='ДР1_М' THEN 'Репродуктивка мужская'
  ELSE 'нет в справочнике' END [тип],
  DATE_Z_1, DATE_Z_2,[DRNAME], w,
  

ISNULL(dl.AdrOmsRn, '-') + ' ' + isnull(dl.AdrOmsNaspunkt, '-') + ' ' + isnull(dl.AdrOmsUl, '-') + ' ' + ISNULL(dl.AdrOmsDom, '-') + ' ' + isnull(dl.AdrOmsKorp, '-')  + ' ' + isnull(dl.AdrOmsKv, '-') addr
FROM [elmed].[dbo].[Списки диспансеризации для МО (По отчетному году)_20-мая-2025 16-36-13] dl

LEFT JOIN [test].[dbo].[prikrep_29102021] p on dl.fam=p.[Фамилия] and im=p.[имя] and ot=p.[Отчество] and dr=p.[Дата рождения]

LEFT JOIN (
SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2,v017.[DRNAME]
FROM D3_PACIENT_OMS AS dpo
	JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
			JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
				left join v017 on v017.IDDR=dzo.RSLT_D  
WHERE dso2.[YEAR] = 2025 AND dzo.OS_SLUCH_REGION IN(47, 49) AND dso2.NSCHET not LIKE '%ошибки%' 
GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2,v017.[DRNAME]
  
) AS t2 ON dl.fam=t2.FAM and dl.im=t2.IM and dl.ot=t2.OT and dl.dr=t2.DR


WHERE dl.DispType !='ДР1_Ж' AND dl.DispType !='ДР1_М'

)  as tt

LEFT JOIN (
SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2,v017.[DRNAME]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
left join v017 on v017.IDDR=dzo.RSLT_D  
WHERE dso2.[YEAR] = 2025 AND dzo.OS_SLUCH_REGION IN(48) AND dso2.NSCHET not LIKE '%ошибки%'
GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2,v017.[DRNAME]
  
) AS t2 ON tt.fam=t2.FAM and tt.im=t2.IM and tt.ot=t2.OT and tt.dr=t2.DR
LEFT JOIN [test].[dbo].[Tel] t ON tt.fam=f and tt.im=i and tt.ot=o and tt.dr=d
ORDER BY tt.НАШНОМЕРУЧАСТКА



SELECT t.*, t2.DS, p.enp
FROM ztemp_spdu_20052025 t
LEFT JOIN (
      SELECT  d.fam, d.Im, d.Ot, d.Dr, dbo.GROUP_CONCAT_DS(DISTINCT D.ДУ_МКБ10_Код , N' , ', 1) DS
        
      FROM du AS d 
        
      WHERE d .ДУ_Окончание IS null 
        
GROUP BY d.Fam, d.Im, d.Ot, d.Dr) AS t2 ON t2.Fam = t.fam AND t2.Im = t.im AND t2.Ot = t.ot AND t2.Dr = t.dr
LEFT JOIN Prikrep AS p ON p.Фамилия = t.fam AND p.Имя = t.im AND p.Отчество = t.ot AND p.Дата_рождения = t.dr
WHERE t.[нашномеручастка] is not NULL