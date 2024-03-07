DECLARE @D3_SCID_old INT = 406--старый реестр где они сейчас
DECLARE @D3_SCID_new INT = 402 --новый реестр куда нужно перенести
--select * 
UPDATE dpo SET dpo.D3_SCID = @D3_SCID_new
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
WHERE dzo.D3_SCID = @D3_SCID_old 
--AND dzo.id =  207166
-- AND dzo.ZSL_ID IN (
--'1a187f45-c976-40f7-89bb-1a5e76dacea3',
--'acc55def-7eb7-4903-b8f9-85f3b7f4ee4c',
--'3bf9556b-9aa0-4753-bed6-750f121afb8b',
--'279b04e6-689d-433e-a43f-187371e06c2a',
--'806eb7ca-0a83-49d6-b0ab-64834fe7b6a9',
--'f56f708a-038b-49db-b12b-2d8ad7715bfb',
--'9A01BACF-F8A3-1B94-E053-350AA8C0B351',
--'eaeda504-fc8c-4f71-af8d-0a6b510496bb',
--'29ac1ddb-acf8-449b-b413-90c12954f94b',
--'6a876732-f8ef-4282-99c8-4c7d7833fe53',
--'9b23bad1-de63-4003-8b23-6ab3ca7f00c3',
--'e1fd35df-35ab-4099-b0cc-3115c0142821',
--'9A01BAD0-0F30-1B94-E053-350AA8C0B351'	
--)
--AND dzo.OS_SLUCH_REGION = 35
--AND dzo.ID IN (138938, 138939, 138940, 138941, 138942, 138943)
--and MEK_COMENT = 'МЭК-Перекрест стационар поликлиника'
 --and EXP_COMENT like 'МЭК - дублирование случаев в рамках одного реестра%'
--AND dzo.USERID IS NULL
--AND dz.ID IN (SELECT id FROM @tab)
--select * 
UPDATE dz SET dz.D3_SCID = @D3_SCID_new
FROM D3_ZSL_OMS AS dz
WHERE dz.D3_SCID = @D3_SCID_old 
--AND dz.id =  207166
--AND dz.ZSL_ID IN (
--'1a187f45-c976-40f7-89bb-1a5e76dacea3',
--'acc55def-7eb7-4903-b8f9-85f3b7f4ee4c',
--'3bf9556b-9aa0-4753-bed6-750f121afb8b',
--'279b04e6-689d-433e-a43f-187371e06c2a',
--'806eb7ca-0a83-49d6-b0ab-64834fe7b6a9',
--'f56f708a-038b-49db-b12b-2d8ad7715bfb',
--'9A01BACF-F8A3-1B94-E053-350AA8C0B351',
--'eaeda504-fc8c-4f71-af8d-0a6b510496bb',
--'29ac1ddb-acf8-449b-b413-90c12954f94b',
--'6a876732-f8ef-4282-99c8-4c7d7833fe53',
--'9b23bad1-de63-4003-8b23-6ab3ca7f00c3',
--'e1fd35df-35ab-4099-b0cc-3115c0142821',
--'9A01BAD0-0F30-1B94-E053-350AA8C0B351'	
--)
--AND dz.OS_SLUCH_REGION = 35
--AND dz.ID IN (138938, 138939, 138940, 138941, 138942, 138943) 
--and MEK_COMENT = 'МЭК-Перекрест стационар поликлиника'
 --and EXP_COMENT like 'МЭК - дублирование случаев в рамках одного реестра%' --AND dz.ID IN (SELECT id FROM @tab)
--AND dz.USERID IS NULL
--AND dz.EXP_COMENT = 'DATE_2 Некорректная дата выписки (больше отчётной даты); '