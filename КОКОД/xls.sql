SELECT a.*
--UPDATE zsl SET EXP_COMENT = a.[Комментарий]
FROM D3_ZSL_OMS AS zsl
JOIN a AS a ON a.[Подробности] = 'ZSL_ID: '+ zsl.ZSL_ID AND zsl.D3_SCID = 2090

--AND a.[Комментарий] <> 'Не заполнено поле характер заболевания C_ZAB' AND a.[Комментарий] <> 'Не заполнено обязательное поле C_ZAB'

 AND a.[Комментарий]  LIKE '%ДУ%'-- AND a.[Комментарий] not like  'В Федер. регистре COVID19 отсутствует соответствующая запись'
-- AND a.[Комментарий]  not LIKE 
-- 'По приказу мин. здрав. РФ от 29.03.2019г. N173н,лица страдающие отдельными хрон. неинфек. и инфек. заболеваниями,подлежат дисп. наблюдению'
----JOIN D3_SL_OMS AS sl ON sl.D3_ZSLID = zsl.ID

--DROP TABLE a

--SELECT * 
----delete a
--FROM a
----WHERE a.[Комментарий] = 'дублирование случаев в рамках одного реестра'
--GROUP BY 
--zsl.SUMV

--SELECT * FROM a AS a

