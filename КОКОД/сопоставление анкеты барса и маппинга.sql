--UPDATE b SET b.code_usl=replace(b.code_usl,'�','A') 
SELECT distinct b.*--, replace(b.code_usl,'�','A') 
FROM bars_lis b
left join Yamed_Spr_UslCode y on y.ID=b.code_usl
WHERE y.ID IS NULL 
