--DROP TABLE ztemp_spdu_07092023
--DROP TABLE ztemp_dispPlan

---<<<<<<<<<<<<Выгружаем данные по запланированным спискам по временную таблицу ztemp_dispPlan >>>>>>>>>>>>>>>>
SELECT dl.TargetQuarter [квартал], ap.Fam, ap.Im, ap.Ot, 
CAST(ap.Dr AS DATE)dr, 
ap.ENP[номер полиса],
CASE WHEN dl.DispType ='ДВ4' THEN 'ДВ4 Первый этап диспансеризации определенных групп взрослого населения'
  WHEN dl.DispType ='ОПВ' THEN 'ОПВ Профилактические медицинские осмотры взрослого населения'
  WHEN dl.DispType ='УД1' THEN 'УД1 Первый этап углубленной диспансеризации определенных групп взрослого населения'
  ELSE 'нет в справочнике' END [тип], 
  ap.omsSmo, 
  w,
	ISNULL(ap.AdrOmsRn, '-') + ' ' + isnull(ap.AdrOmsNaspunkt, '-') + ' ' + isnull(ap.AdrOmsUl, '-') + ' ' + ISNULL(ap.AdrOmsDom, '-') + ' ' + isnull(ap.AdrOmsKorp, '-')  + ' ' + isnull(ap.AdrOmsKv, '-') addr
INTO ztemp_dispPlan
FROM sql_cod.DocExchange.dbo.[DISP_Lists] dl
	JOIN sql_cod.DocExchange.dbo.ATTP_People AS ap ON ap.ID = dl.PID
WHERE dl.PrMo = 460026 
				AND dl.DispType IN('ДВ4', 'ОПВ', 'УД1')
				AND dl.TargetYear = 2024
				AND dl.TargetQuarter IN (1,2,3,4)
				AND dl.Reserve = 0 
---<<<<<<<<<<<<Выгружаем данные по запланированным спискам по временную таблицу >>>>>>>>>>>>>>>>



SELECT tt.квартал, tt.Fam, tt.Im, tt.Ot, tt.dr,
CASE WHEN w = 1 THEN 'Мужской'
    WHEN w = 2 THEN 'Женский'
    ELSE 'Нет' END [пол], tt.[номер полиса], tt.omsSmo, tt.НАШНОМЕРУЧАСТКА, ''[отметка о вызове], tt.тип, tt.DATE_Z_1, tt.DATE_Z_2, tt.DRNAME, t2.DATE_Z_1 DATE_Z_12, t2.DATE_Z_2 DATE_Z_22, t2.DRNAME DRNAME2
  ,t.tel tel, addr
INTO ztemp_spdu_07092023
FROM (
			SELECT ap.[квартал], ap.Fam, ap.Im, ap.Ot, 
			CAST(ap.Dr AS DATE)dr, 
			ap.[номер полиса],
			[НАШНОМЕРУЧАСТКА], 
			 ap.[тип], ap.omsSmo, 
			  DATE_Z_1, DATE_Z_2,[DRNAME], w,
			addr
			FROM ztemp_dispPlan ap
			LEFT JOIN [test].[dbo].[prikrep_29102021] on fam=[Фамилия] and im=[имя] and ot=[Отчество] and dr=[Дата рождения]

			LEFT JOIN (
				SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2,v017.[DRNAME]
				FROM D3_PACIENT_OMS AS dpo
					JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
					JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
					JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
					left join v017 on v017.IDDR=dzo.RSLT_D  
				WHERE dso2.[YEAR] = 2024 AND dzo.OS_SLUCH_REGION IN(47, 49) AND dso2.NSCHET not LIKE '%ошибки%'
				GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2,v017.[DRNAME]
  
			) AS t2 ON ap.fam=t2.FAM and ap.im=t2.IM and ap.ot=t2.OT and ap.dr=t2.DR

)  as tt

LEFT JOIN (
			SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2,v017.[DRNAME]
			FROM D3_PACIENT_OMS AS dpo
			JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
			JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
			JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
			left join v017 on v017.IDDR=dzo.RSLT_D  
			WHERE dso2.[YEAR] = 2024 AND dzo.OS_SLUCH_REGION IN(48) AND dso2.NSCHET not LIKE '%ошибки%'
			GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2,v017.[DRNAME]  
		) AS t2 ON tt.fam=t2.FAM and tt.im=t2.IM and tt.ot=t2.OT and tt.dr=t2.DR
LEFT JOIN [test].[dbo].[Tel] t ON tt.fam=f and tt.im=i and tt.ot=o and tt.dr=d
ORDER BY tt.НАШНОМЕРУЧАСТКА



SELECT t.*, t2.DS, t2.doc
FROM ztemp_spdu_07092023 t
LEFT JOIN (
      SELECT  ap.Fam, ap.Im, ap.Ot, ap.Dr, dbo.GROUP_CONCAT_DS(DISTINCT DIAG10, N' , ', 1) DS,
          max(ysme.NameWithID) doc
        FROM [SQL_COD].[DocExchange].[dbo].[ATTP_DISP_ACCOUNT] as d
        INNER JOIN [SQL_COD].[DocExchange].[dbo].[ATTP_People] as ap ON d.PID=ap.ID
        LEFT JOIN Yamed_Spr_MedicalEmployee AS ysme ON ysme.SNILS = d.snils
      WHERE ap.active=1 
          AND ap.prmo=460026 
          AND d.MO IN (460026, 460006) 
          AND ap.Ds IS NULL
          AND d.dateend IS NULL  
GROUP BY ap.Fam, ap.Im, ap.Ot, ap.Dr) AS t2 ON t2.Fam = t.fam AND t2.Im = t.im AND t2.Ot = t.ot AND t2.Dr = t.dr