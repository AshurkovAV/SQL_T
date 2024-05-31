DROP TABLE dbo._N3_spr64_OTDEL
  GO

select --top 100 
--n3_mo.[organization-alias], -- комментировать перед выгрузкой
lower(case WHEN isnull(spr64.[Код], '') = '' then LOWER(newid()) ELSE spr64.[Код] END) 'id',  --формируем GUID если его нет при джойне
--spr64.[Код], -- комментировать перед выгрузкой
mo.hospital_name + ', ' + isnull(n3_mo.[organization-alias], '') 'name', --формируем название как наименование СП + наименование организации
mo.hospital_name + ', ' + isnull(n3_mo.[organization-alias], '') 'organization-alias', --формируем название как наименование СП + альтернативное наименование организации
mo.oid 'depart_oid', -- для головных не заполняется
n3_mo.orgid 'partOf', -- для головных не заполняется
n3_mo.orgid 'orgid', -- для головных равен [Код], для структурных ставить ссылку на код головной, обновить после сборки

(isnull(mo.building_address_post_index, '') +    CASE WHEN isnull(mo.building_address_post_index, '') = '' THEN '' ELSE ', ' END + 
			isnull(mo.building_address_region_name, '') +   CASE WHEN isnull(mo.building_address_region_name, '') = '' THEN '' ELSE ', ' END + 
			isnull(mo.building_address_prefix_area, '') +   CASE WHEN isnull(mo.building_address_prefix_area, '') = '' THEN '' ELSE '. ' END + 
			isnull(mo.building_address_area_name, '') +     CASE WHEN isnull(mo.building_address_area_name, '') = '' THEN '' ELSE ', ' END + 
			isnull(mo.building_address_prefix_street, '') + CASE WHEN isnull(mo.building_address_prefix_street, '') = '' THEN '' ELSE '. ' END + 
			isnull(mo.building_address_street_name, '') +   CASE WHEN isnull(mo.building_address_street_name, '') = '' THEN '' ELSE ', ' END +
			isnull(mo.building_address_house, '')) AS 'Address', -- собираем адрес из справочника СП
'' 'url',
CASE WHEN ISNULL(spr64.phone, '') != '' THEN spr64.phone ELSE '' END 'phone', --если телефона есть в справочнике 64, то оставлем его
n3_mo.ogrn 'ogrn',
case when n3_mo.active = 'false' THEN 'false' ELSE CASE WHEN isnull(mo.depart_liquidation_date, '') != '' THEN 'false' ELSE 'true' END END AS 'active', --если головная организация прекратила действие, то проставляем всем ее СП такой же статус. Если СП прекратило действие - тоже ставим false. Всё остальное true
CASE WHEN mo.depart_type_id = 1 THEN 40  
  WHEN mo.depart_type_id = 2 THEN 2
  WHEN mo.depart_type_id = 3 THEN 158
  WHEN mo.depart_type_id = 4 THEN 71
  WHEN mo.depart_type_id = 5 THEN 74
  ELSE n3_mo.medorgtype END AS 'medorgtype' -- иначе ставим такой же тип как и головной МО


INTO _N3_spr64_OTDEL

from [1.2.643.5.1.13.13.99.2.115] mo

left join [64_Справочник МО_шаблон] spr64 on mo.oid = spr64.[OID структурного подразделения (ФРМО)]
left join _N3_spr64_MO n3_mo on n3_mo.oid = mo.mo_oid

where mo.oid like '1.2.643.5.1.13.13.12.2.46.4342.0.404037.678439' --выбираем Курскую область

--and mo.mo_oid not like '1.2.643.5.1.13.13.12.2.46.15935' 
ORDER BY spr64.[organization-alias]
  GO

SELECT * FROM _N3_spr64_OTDEL