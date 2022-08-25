/****** Скрипт для команды SelectTopNRows из среды SSMS  ******/
SELECT   isnull(fam, '') + ' ' + isnull(Im , '') + ' ' +  isnull(ot,'') + ' ' + CONVERT(NVARCHAR(10), dr, 102),
AdrOmsRn, AdrOmsNaspunkt, AdrOmsUl, AdrOmsDom, AdrOmsKorp, AdrOmsKv, 
(SELECT sf.mcod + ' ' + sf.nam_mok FROM SPR_79_F003 AS sf WHERE sf.mcod = PrMo) 
  FROM [DocExchange].[dbo].[ATTP_People]
WHERE PrMoDtBeg = '20150901' 
AND (AdrOmsUl LIKE '%юзна%' 
	OR AdrOmsUl LIKE '%республиканск%'
    OR AdrOmsUl LIKE '%убровинског%'
OR AdrOmsUl LIKE '%Красина%'
OR AdrOmsUl LIKE '%Рабочая%'
OR AdrOmsUl LIKE '%Краснознаменная%'
OR AdrOmsUl LIKE '%Интернациональная%'
OR AdrOmsUl LIKE '%Герцена%'
OR AdrOmsUl LIKE '%Бутко%'
OR AdrOmsUl LIKE '%Вокзальная%'
OR AdrOmsUl LIKE '%Социалистическая%'
OR AdrOmsUl LIKE '%Станционная%'
OR AdrOmsUl LIKE '%Ухтомского%'
OR AdrOmsUl LIKE '%Щигровская%'
OR AdrOmsUl LIKE '%Цурюпы%'
OR AdrOmsUl LIKE '%Орджоникидзе%'
OR AdrOmsUl LIKE '%Восточная%'
OR AdrOmsUl LIKE '%Коммунальная%'
OR AdrOmsUl LIKE '%Железнодорожная%'
OR AdrOmsUl LIKE '%Локомотивная%'
OR AdrOmsUl LIKE '%Пушкинская%'
OR AdrOmsUl LIKE '%Клюквинская%'
OR AdrOmsUl LIKE '%Весенняя%'
OR AdrOmsUl LIKE '%Агрегат%'
OR AdrOmsUl LIKE '%Каширцева%'
OR AdrOmsUl LIKE '%Кооперативная%'
OR AdrOmsUl LIKE '%Линейная%'
OR AdrOmsUl LIKE '%Воздушная%'
OR AdrOmsUl LIKE '%Шубина%'
OR AdrOmsUl LIKE '%Подлесная%'
OR AdrOmsUl LIKE '%Тенист%'
)  

AND PrMo != 460026 -- PrMoSpos IS NOT NULL and PrMoComment IS NOT NULL 
AND AdrOmsRn = 'Курск'
AND dr < '20000101' --взрослое население
--GROUP BY PrMo
ORDER BY AdrOmsUl, AdrOmsDom