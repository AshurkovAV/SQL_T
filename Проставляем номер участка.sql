use elmed
go

SELECT dl.TargetQuarter [квартал], ap.Fam, ap.Im, ap.Ot, 
CAST(ap.Dr AS DATE)[дата рождения], 
ap.ENP[номер полиса],
[НАШНОМЕРУЧАСТКА], 
CASE WHEN dl.DispType ='ДВ4' THEN 'ДВ4 Первый этап диспансеризации определенных групп взрослого населения'
	WHEN dl.DispType ='ОПВ' THEN 'ОПВ Профилактические медицинские осмотры взрослого населения'
	WHEN dl.DispType ='УД1' THEN 'УД1 Первый этап углубленной диспансеризации определенных групп взрослого населения'
	ELSE 'нет в справочнике' END [тип], 
ISNULL(ap.phone, t.tel)tel,

ISNULL(ap.AdrOmsRn, '-') + ' ' + isnull(ap.AdrOmsNaspunkt, '-') + ' ' + isnull(ap.AdrOmsUl, '-') + ' ' + ISNULL(ap.AdrOmsDom, '-') + ' ' + isnull(ap.AdrOmsKorp, '-')  + ' ' + isnull(ap.AdrOmsKv, '-') addr
FROM sql_cod.DocExchange.dbo.[DISP_Lists] dl
JOIN sql_cod.DocExchange.dbo.ATTP_People AS ap ON ap.ID = dl.PID
LEFT JOIN [test].[dbo].[prikrep_29102021] on fam=[Фамилия] and im=[имя] and ot=[Отчество] and dr=[Дата рождения]
LEFT JOIN [test].[dbo].[Tel] t ON fam=f and im=i and ot=o and dr=d
WHERE dl.PrMo = 460026 
AND dl.DispType IN('ДВ4', 'ОПВ', 'УД1')
--AND dl.RejectTFReasonId IS null
AND dl.TargetYear = 2023
AND dl.TargetQuarter IN (1,2,3,4)
AND dl.Reserve = 0 
ORDER BY [НАШНОМЕРУЧАСТКА]