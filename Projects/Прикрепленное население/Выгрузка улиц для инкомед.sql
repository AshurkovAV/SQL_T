SELECT uch.Uchastok
,mh.[ID_MO]     
,aupo.NAME
      ,(SELECT fi.FORMALNAME + ' ' + fi.SHORTNAME FROM FIAS_AddressObjects AS fi WHERE fi.AOGUID = [Region])[Region]
      ,Region [Region_Kod]
      ,(SELECT fi.FORMALNAME + ' ' + fi.SHORTNAME FROM FIAS_AddressObjects AS fi WHERE fi.AOGUID = ISNULL([Rn], '00000000-0000-0000-0000-000000000000') AND LIVESTATUS = 1 and AOLEVEL = 3)[Rn]
      ,Rn [Rn_Kod]
      ,(SELECT fi.FORMALNAME + ' ' + fi.SHORTNAME FROM FIAS_AddressObjects AS fi WHERE fi.AOGUID = ISNULL([City], '00000000-0000-0000-0000-000000000000') AND LIVESTATUS = 1 and AOLEVEL = 4)[City]
      ,City City_Kod
      ,(SELECT fi.FORMALNAME + ' ' + fi.SHORTNAME FROM FIAS_AddressObjects AS fi WHERE fi.AOGUID = ISNULL([CityRn], '00000000-0000-0000-0000-000000000000') AND LIVESTATUS = 1 and AOLEVEL = 5)[CityRn]
      ,CityRn CityRn_kod
      ,(SELECT fi.FORMALNAME + ' ' + fi.SHORTNAME FROM FIAS_AddressObjects AS fi WHERE fi.AOGUID = ISNULL([NasPun], '00000000-0000-0000-0000-000000000000')AND LIVESTATUS = 1 and AOLEVEL = 6)[NasPun]
      ,NasPun NasPun_Kod
      ,(SELECT fi.FORMALNAME + ' ' + fi.SHORTNAME FROM FIAS_AddressObjects AS fi WHERE fi.AOGUID = ISNULL([Ul], '00000000-0000-0000-0000-000000000000') AND LIVESTATUS = 1 and AOLEVEL = 7)[Ul]
      ,Ul Ul_kod
      ,(SELECT fi.FORMALNAME + ' ' + fi.SHORTNAME FROM FIAS_AddressObjects AS fi WHERE fi.AOGUID = ISNULL([DopUl], '00000000-0000-0000-0000-000000000000') AND LIVESTATUS = 1 and AOLEVEL in (90,91))[DopUl]
      ,DopUl DopUl_kod
      ,[House]
      ,[DateBeg]
      ,[DateEnd]
      ,[CustomHouse]
      INTO ExportStreet
  FROM [AttachedUchStreet_ONLINE] stret
  INNER JOIN AttachedUchastok_ONLINE AS uch ON uch.ID = stret.UchID
  LEFT JOIN AttachedUchPodr_ONLINE AS aupo ON aupo.ID = uch.PordID
  INNER JOIN mo_hid AS mh ON mh.hid=uch.HID
