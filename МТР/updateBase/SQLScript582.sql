BEGIN TRAN
BEGIN TRY
DECLARE @ErrorMessage NVARCHAR(4000)
		DECLARE @ErrorSeverity INT
		DECLARE @ErrorState INT
		
EXEC [dbo].[versionСheck] 581


INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0210
--DECLARE @AccountID INT =24172
--Взаимное несоответствие исхода заболевания, результата обращения(При RSLT={102, 103, 104, 105, 106, 109} ISHOD не должен быть равен 101 )
SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM [ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    

join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v009 v9 on v9.id= Result
 join v012 v12 on v12.id=Outcome
where v9.IDRMP IN (102,103,104,105,106,109) 
AND v12.IDIZ  IN (101)', N'003K.00.0210_Взаимное несоответствие исхода заболевания, результата обращения(При RSLT={102, 103, 104, 105, 106, 109} ISHOD не должен быть равен 101 )', N'003K.00.0210_Взаимное несоответствие исхода заболевания, результата обращения(При RSLT={102, 103, 104, 105, 106, 109} ISHOD не должен быть равен 101 )', N'Взаимное несоответствие исхода заболевания, результата обращения', 1, 0.0000, 4, 1.0000,  9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0200
--DECLARE @AccountID INT =24172
--Взаимное несоответствие исхода заболевания, результата обращения (При RSLT  {407, 408, 409, 410, 411, 412, 413, 414, 417} ISHOD не равен 402)
SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM [ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    

join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v009 v9 on v9.id= Result
 join v012 v12 on v12.id=Outcome
where v9.IDRMP  IN (407,408,409,410,411,412,413,414,417) 
AND v12.IDIZ  not IN (402)', N'003K.00.0200_Взаимное несоответствие исхода заболевания, результата обращения (При RSLT  {407, 408, 409, 410, 411, 412, 413, 414, 417} ISHOD не равен 402)', N'003K.00.0200_Взаимное несоответствие исхода заболевания, результата обращения (При RSLT  {407, 408, 409, 410, 411, 412, 413, 414, 417} ISHOD не равен 402)', N'Взаимное несоответствие исхода заболевания, результата обращения', 1, 0.0000, 4, 1.0000,  9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0220
--Взаимное несоответствие исхода заболевания, результата обращения (При RSLT={202, 203, 204, 205, 206, 207, 208} исход не должен быть равен 201
--DECLARE @AccountID INT =24172
SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result 
  FROM [ZFactMedicalEvent] z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    

join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v009 v9 on v9.id= Result
 join v012 v12 on v12.id=Outcome
where v9.IDRMP IN (202,203,204,205,206,207,208) 
AND v12.IDIZ  IN (201)', N'003K.00.0220_Взаимное несоответствие исхода заболевания, результата обращения (При RSLT={202, 203, 204, 205, 206, 207, 208} исход не должен быть равен 201', N'003K.00.0220_Взаимное несоответствие исхода заболевания, результата обращения (При RSLT={202, 203, 204, 205, 206, 207, 208} исход не должен быть равен 201', N'Взаимное несоответствие исхода заболевания, результата обращения', 1, 0.0000, 4, 1.0000,  9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent],  [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0190
--Взаимное несоответствие исхода заболевания, результата обращения
--DECLARE @AccountID INT =24172


--убрал 305 и 308
SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    

join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
  AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v009 v9 on v9.id= Result
 join v012 v12 on v12.id=Outcome
where v9.IDRMP=306 
AND v12.IDIZ NOT IN (314, 315, 317, 318, 321, 322, 323, 324, 325, 332, 333, 334, 335, 336, 343, 344, 347, 348, 349,  350,
                     351, 353, 355, 356, 357, 358, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374)', N'003K.00.0190_При ISHOD=306 RSLT  равен {314,315,317,318,321,322,323,324,325,332,333,334,335,336,343,344,347,348,349,350,351,353,355,356,357,358,361,362,363,364,365,366,367,368,369,370,371,372,373,374}', N'003K.00.0190_При ISHOD=306 RSLT  равен {314,315,317,318,321,322,323,324,325,332,333,334,335,336,343,344,347,348,349,350,351,353,355,356,357,358,361,362,363,364,365,366,367,368,369,370,371,372,373,374}', N'Взаимное несоответствие исхода заболевания, результата обращения', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0500
--DECLARE @AccountID INT =24172
--Несоответствие специальности виду оказываемой медицинской помощи
----VIDPOM={12, 13, 31}
--Значение PRVS не должно входить в множество {100, 101, 206, 207, 208, 209, 210, 213, 217, 219, 221, 223, 224, 226, 227, 228, 230, 231, 233, 281, 284}
SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    

join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v021 v21 ON v21.Id = z.SpecialityCodeV021 
 
where ( v21.IDSPEC  IN (100, 101, 206, 207, 208, 209, 210, 213, 217, 219, 221, 223, 224, 226, 227, 228, 230, 231, 233, 281, 284) 
AND zsl.AssistanceType IN (12, 13, 31) )', N'003K.00.0500_При VIDPOM={12, 13, 31} Значение PRVS не должно входить в множество {100, 101, 206, 207, 208, 209, 210, 213, 217, 219, 221, 223, 224, 226, 227, 228, 230, 231, 233, 281, 284}', N'003K.00.0500_При VIDPOM={12, 13, 31} Значение PRVS не должно входить в множество {100, 101, 206, 207, 208, 209, 210, 213, 217, 219, 221, 223, 224, 226, 227, 228, 230, 231, 233, 281, 284}', N'Несоответствие специальности виду оказываемой медицинской помощи', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0510
--DECLARE @AccountID INT =24172
--Несоответствие специальности виду оказываемой медицинской помощи При VIDPOM={21, 22, 23}  Значение PRVS должно входить в множество {66, 283, 4, 49}
SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    

join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v021 v21 ON v21.Id = z.SpecialityCodeV021 
 
where ( v21.IDSPEC NOT IN (66, 283, 4, 49) 
AND zsl.AssistanceType IN (21, 22, 23) )', N'003K.00.0510_При VIDPOM={21, 22, 23}  Значение PRVS должно входить в множество {66, 283, 4, 49}', N'003K.00.0510_При VIDPOM={21, 22, 23}  Значение PRVS должно входить в множество {66, 283, 4, 49}', N'Несоответствие специальности виду оказываемой медицинской помощи', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0490
--DECLARE @AccountID INT =24172
--Несоответствие специальности виду оказываемой медицинской помощи
--
SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    

join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v021 v21 ON v21.Id = z.SpecialityCodeV021 
 
where  v21.IDSPEC  IN (42, 67, 82, 83,
   1, 7, 14, 16, 29, 30, 34, 42, 51, 52, 53, 54, 63, 64, 67, 73, 74, 82, 83,
   85, 86, 88, 96, 97, 98, 99, 234, 280)

  AND zsl.AssistanceType IN (11, 12, 13, 31,32,33) ', N'003K.00.0490_При VIDPOM={11, 12, 13; 31, 32,33} Значение PRVS не должно входить в множество {42,67,82,83,1,7,14,16,29,30,34,42,51,52,53,54,63,64,67,73,74,82,83,85,86,88,96,97,98,99 234,280}', N'003K.00.0490_При VIDPOM={11, 12, 13; 31, 32,33} Значение PRVS не должно входить в множество {42,67,82,83,1,7,14,16,29,30,34,42,51,52,53,54,63,64,67,73,74,82,83,85,86,88,96,97,98,99 234,280}', N'Несоответствие специальности виду оказываемой медицинской помощи', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0490
--DECLARE @AccountID INT =24172
--Несоответствие специальности виду оказываемой медицинской помощи
--
SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    

join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v021 v21 ON v21.Id = z.SpecialityCodeV021 
 
where  v21.IDSPEC  IN (42, 67, 82, 83,
   1, 7, 14, 16, 29, 30, 34, 42, 51, 52, 53, 54, 63, 64, 67, 73, 74, 82, 83,
   85, 86, 88, 96, 97, 98, 99, 234, 280)

  AND zsl.AssistanceType IN (11, 12, 13, 31,32,33) ', N'003K.00.0830_Детская кардиология, Детская онкология, Детская урология-андрология, Детская хирургия, Детская эндокринология, Педиатрия, Стоматология детская} должно применяться только для пациента младше 18 лет.', N'003K.00.0830_Детская кардиология, Детская онкология, Детская урология-андрология, Детская хирургия, Детская эндокринология, Педиатрия, Стоматология детская} должно применяться только для пациента младше 18 лет.', N'Специальность врача не соответствует возрасту пациента', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0840
--Значение специальности врача «Акушерство и гинекология» должно применяться только для пола пациента W=2
SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result
--,a.Destination
--,zsl.AcceptPrice
  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    
  JOIN   FactPerson pe ON pe.PersonId=fp.PersonalId    
join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v021 v21 ON v21.Id = z.SpecialityCodeV021 
 
where  v21.IDSPEC  IN (2, 207)   AND  pe.Sex = 1 ', N'003K.00.0840_Специальность врача не соответствует полу  пациента(Значение специальности врача «Акушерство и гинекология» должно применяться только для пола пациента W=2', N'003K.00.0840_Специальность врача не соответствует полу  пациента(Значение специальности врача «Акушерство и гинекология» должно применяться только для пола пациента W=2', N'Специальность врача не соответствует полу  пациента', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0850
--Значение специальности врача «Неонатология» должно применяться только для пациента младше 1 года.
SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result
--,a.Destination
--,zsl.AcceptPrice
  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    
  JOIN   FactPerson pe ON pe.PersonId=fp.PersonalId    
join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v021 v21 ON v21.Id = z.SpecialityCodeV021 
 
where  v21.IDSPEC  IN (37) and  dbo.f_GetAge(pe.Birthday,z.EventBegin)>=1 ', N'003K.00.0850_Специальность врача не соответствует полу  пациента(Значение специальности врача «Неонатология» должно применяться только для пациента младше 1 года.)', N'003K.00.0850_Специальность врача не соответствует полу  пациента(Значение специальности врача «Неонатология» должно применяться только для пациента младше 1 года.)', N'Специальность врача не соответствует полу  пациента', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0860
--Значение специальности врача из множества {Кардиология, Онкология, Урология, Эндокринология} должно применяться только для пациентов  18 лет и старше
SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result
--,a.Destination
--,zsl.AcceptPrice
  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId  and  fp.AccountId=@AccountID    
  JOIN   FactPerson pe ON pe.PersonId=fp.PersonalId    
join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v021 v21 ON v21.Id = z.SpecialityCodeV021 
 
where  v21.IDSPEC  IN (25, 41, 84, 92) and  dbo.f_GetAge(pe.Birthday,z.EventBegin) < 18 ', N'003K.00.0860_Специальность врача не соответствует полу  пациента(Значение специальности врача из множества {Кардиология, Онкология, Урология, Эндокринология} должно применяться только для пациентов  18 лет и старше.)', N'003K.00.0860_Специальность врача не соответствует полу  пациента(Значение специальности врача из множества {Кардиология, Онкология, Урология, Эндокринология} должно применяться только для пациентов  18 лет и старше.)', N'Специальность врача не соответствует полу  пациента', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0870
--Значение специальности врача «Терапия» может применяться только для пациентов  от 15 лет и старше.
--DECLARE @AccountID INT = 2584

SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result
--,a.Destination
--,zsl.AcceptPrice
  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId  and  fp.AccountId=@AccountID    
  JOIN   FactPerson pe ON pe.PersonId=fp.PersonalId    
join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v021 v21 ON v21.Id = z.SpecialityCodeV021 
 
where  v21.IDSPEC  IN (76) and  dbo.f_GetAge(pe.Birthday,z.EventBegin) < 15 ', N'003K.00.0870_Специальность врача не соответствует полу  пациента(Значение специальности врача «Терапия» может применяться только для пациентов  от 15 лет и старше)', N'003K.00.0870_Специальность врача не соответствует полу  пациента(Значение специальности врача «Терапия» может применяться только для пациентов  от 15 лет и старше)', N'Специальность врача не соответствует полу  пациента', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0880
--Значение специальности врача «Гериатрия» может применяться только для пациентов от 65 лет и старше. 
--DECLARE @AccountID INT = 2584

SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result
--,a.Destination
--,zsl.AcceptPrice
  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId  and  fp.AccountId=@AccountID    
  JOIN   FactPerson pe ON pe.PersonId=fp.PersonalId    
join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join v021 v21 ON v21.Id = z.SpecialityCodeV021 
 
where  v21.IDSPEC  IN (11) and  dbo.f_GetAge(pe.Birthday,z.EventBegin) < 65 ', N'003K.00.0880_Специальность врача не соответствует полу  пациента(Значение специальности врача «Гериатрия» может применяться только для пациентов от 65 лет и старше. )', N'003K.00.0880_Специальность врача не соответствует полу  пациента(Значение специальности врача «Гериатрия» может применяться только для пациентов от 65 лет и старше. )', N'Специальность врача не соответствует полу  пациента', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0890
--Значение специальностей в услуге {Детская кардиология, Детская онкология, Детская урология-андрология, Детская хирургия, Детская эндокринология, Педиатрия, Стоматология детская} применяется только для пациента младше 18 лет. 
--DECLARE @AccountID INT = 2584

SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    
  JOIN   FactPerson pe ON pe.PersonId=fp.PersonalId    
join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
  AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join  ZFactMedicalServices usl on usl.ZmedicalEventId=z.ZmedicalEventId 
 join v021 v21 ON v21.Id = usl.SpecialityCodeV021 
 
where  v21.IDSPEC  IN (18, 20, 21, 22, 49, 68)

  AND  dbo.f_GetAge(pe.Birthday,z.EventBegin)>= 18', N'003K.00.0890_Специальность{Детская кардиология,Детская онкология,Детская урология-андрология,Детская хирургия,Детская эндокринология,Педиатрия,Стоматология детская} должно применяться только для пациента младше 18 лет.', N'003K.00.0890_Специальность{Детская кардиология,Детская онкология,Детская урология-андрология,Детская хирургия,Детская эндокринология,Педиатрия,Стоматология детская} должно применяться только для пациента младше 18 лет.', N'Специальность  врача в услуге не соответствует полу  пациента', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0900
--Значение специальности врача «Акушерство и гинекология» в услуге должно применяться только для пола пациента W=2
--DECLARE @AccountID INT = 2584

SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    
  JOIN   FactPerson pe ON pe.PersonId=fp.PersonalId    
join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
   AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join  ZFactMedicalServices usl on usl.ZmedicalEventId=z.ZmedicalEventId 
 join v021 v21 ON v21.Id = usl.SpecialityCodeV021 
 
    where  v21.IDSPEC  IN (2, 207)   AND  pe.Sex = 1 ', N'003K.00.0900_Значение специальности врача «Акушерство и гинекология» должно применяться только для пола пациента W=2
', N'003K.00.0900_Значение специальности врача «Акушерство и гинекология» должно применяться только для пола пациента W=2
', N'Специальность  врача в услуге не соответствует полу  пациента', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0910
--Значение специальности врача  «Неонатология» в услуге должно применяться только для пациента младше 1 года.
--DECLARE @AccountID INT = 2584

SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    
  JOIN   FactPerson pe ON pe.PersonId=fp.PersonalId    
join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
    AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join  ZFactMedicalServices usl on usl.ZmedicalEventId=z.ZmedicalEventId 
 join v021 v21 ON v21.Id = usl.SpecialityCodeV021 
 
where  v21.IDSPEC  IN (37) and  dbo.f_GetAge(pe.Birthday,z.EventBegin)>=1 ', N'003K.00.0910_Значение специальности врача «Неонатология» должно применяться только для пациента младше 1 года. Возраст пациента вычисляется на дату начала случая', N'003K.00.0910_Значение специальности врача «Неонатология» должно применяться только для пациента младше 1 года. Возраст пациента вычисляется на дату начала случая
', N'Специальность врача в услуге не соответствует возрасту пациента', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0920
--Значение специальностей врача {Кардиология, Онкология, Урология, Эндокринология} в услуге должно применяться только для пациентов  от 18 лет и старше.
--DECLARE @AccountID INT = 2584

SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    
  JOIN   FactPerson pe ON pe.PersonId=fp.PersonalId    
join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join  ZFactMedicalServices usl on usl.ZmedicalEventId=z.ZmedicalEventId 
 join v021 v21 ON v21.Id = usl.SpecialityCodeV021 
 
where  v21.IDSPEC  IN (25, 41, 84, 92) and  dbo.f_GetAge(pe.Birthday,z.EventBegin) < 18 ', N'003K.00.0920_Значение специальности врача из множества {Кардиология, Онкология, Урология, Эндокринология} должно применяться только для пациентов  от 18 лет и старше. Возраст пациента вычисляется на дату начала случая', N'003K.00.0920_Значение специальности врача из множества {Кардиология, Онкология, Урология, Эндокринология} должно применяться только для пациентов  от 18 лет и старше. Возраст пациента вычисляется на дату начала случая
', N'Специальность врача в улсуге не соответствует  возрасту пациента', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0930
--Значение специальности врача «Терапия» в услуге может применяться только для пациентов  от 15 лет и старше.
--DECLARE @AccountID INT = 2584

SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    
  JOIN   FactPerson pe ON pe.PersonId=fp.PersonalId    
join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
 AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join  ZFactMedicalServices usl on usl.ZmedicalEventId=z.ZmedicalEventId 
 join v021 v21 ON v21.Id = usl.SpecialityCodeV021 
 
where  v21.IDSPEC  IN (76) and  dbo.f_GetAge(pe.Birthday,z.EventBegin) < 15 ', N'003K.00.0930_Значение специальности врача «Терапия» может применяться только для пациентов  от 15 лет и старше.Возраст пациента вычисляется на дату начала случая', N'003K.00.0930_Значение специальности врача «Терапия» может применяться только для пациентов  от 15 лет и старше.Возраст пациента вычисляется на дату начала случая
', N'Специальность врача в улсуге не соответствует  возрасту пациента', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0940
--Значение специальности врача «Гериатрия» в услуге может применяться только для пациентов от 65 лет и старше. 
--DECLARE @AccountID INT = 2584

SELECT z.ZmedicalEventId--, p.AccountId,p.ExternalId   
--,fp.AccountId , fp.externalid
--,v9.[IDRMP],v12.[IDIZ]
--,Outcome,Result

  FROM ZFactMedicalEvent z
  JOIN ZslFactMedicalEvent AS zsl ON zsl.ZslMedicalEventId =z.ZslMedicalEventId --and zfme.acceptprice>0
  JOIN FactPatient AS fp ON fp.PatientId = zsl.PatientId and  fp.AccountId=@AccountID    
  JOIN   FactPerson pe ON pe.PersonId=fp.PersonalId    
join FactTerritoryAccount a on a.TerritoryAccountId=fp.AccountId 
  AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
 join  ZFactMedicalServices usl on usl.ZmedicalEventId=z.ZmedicalEventId 
 join v021 v21 ON v21.Id = usl.SpecialityCodeV021 
 
where  v21.IDSPEC  IN (11) and  dbo.f_GetAge(pe.Birthday,z.EventBegin) < 65 ', N'003K.00.0940_Значение специальности врача «Гериатрия» может применяться только для пациентов от 65 лет и старше. Возраст пациента вычисляется на дату начала случая', N'003K.00.0940_Значение специальности врача «Гериатрия» может применяться только для пациентов от 65 лет и старше. Возраст пациента вычисляется на дату начала случая', N'Специальность врача в улсуге не соответствует  возрасту пациента', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0590 Несоответствие диагноза возрасту пациента
--Ошибка фиксируется при указании диагноза  из рубрики Р МКБ-10 для пациента старше 1 года

--DECLARE @AccountId  INT=25571

 
 SELECT             
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,ze.AssistanceConditions
 -- , m.IDDS
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
       AND p.AccountId=@AccountId        
    
  AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
   JOIN   FactPerson pe ON pe.PersonId=p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId 
         --AND e.ZmedicalEventId = 244344
    INNER JOIN M001 AS m ON  m.Id = e.DiagnosisGeneral --основной
                       

WHERE   m.IDDS LIKE ''P%'' AND dbo.f_GetAge(pe.Birthday,ze.EventBeginZ1) > 1 ', N'003K.00.0590_Ошибка фиксируется при указании диагноза  из рубрики Р МКБ-10 для пациента старше 1 года. Возраст пациента вычисляется на дату начала законченного случая', N'003K.00.0590_Ошибка фиксируется при указании диагноза  из рубрики Р МКБ-10 для пациента старше 1 года. Возраст пациента вычисляется на дату начала законченного случая', N'Несоответствие диагноза возрасту пациента', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0600 Несоответствие диагноза возрасту пациента
--Ошибка фиксируется при указании диагноза  из рубрики Р МКБ-10 для пациента старше 1 года

--DECLARE @AccountId  INT=25571

 
 SELECT             
 DISTINCT e.ZmedicalEventId
   
 --,a.[Date]
 --,p.AccountId, p.ExternalId
 --,ze.AssistanceConditions
 -- , m.IDDS
      
 FROM FactTerritoryAccount a --счета            
 INNER JOIN FactPatient p on a.TerritoryAccountId = p.AccountId   
       AND p.AccountId=@AccountId        
    
    AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
   JOIN   FactPerson pe ON pe.PersonId=p.PersonalId                   
 INNER JOIN ZslFactMedicalEvent ze on ze.[PatientId] = p.[PatientId]    
      --   AND ze.[AssistanceConditions]  <> 4
 INNER JOIN ZFactMedicalEvent AS e ON e.ZslMedicalEventId=ze.ZslMedicalEventId 
         --AND e.ZmedicalEventId = 244344
    INNER JOIN M001 AS m ON  m.Id = e.DiagnosisPrimary --первичный
                       

WHERE   m.IDDS LIKE ''P%'' AND dbo.f_GetAge(pe.Birthday,ze.EventBeginZ1) > 1 ', N'003K.00.0600_Ошибка фиксируется при указании диагноза  из рубрики Р МКБ-10 для пациента старше 1 года. Возраст пациента вычисляется на дату начала законченного случая', N'003K.00.0600_Ошибка фиксируется при указании диагноза  из рубрики Р МКБ-10 для пациента старше 1 года. Возраст пациента вычисляется на дату начала законченного случая', N'Несоответствие диагноза возрасту пациента', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0120
--SUMMAP = SUMMAV-( SANK_MEK+ SANK_MEE+ SANK_EKMP)

SELECT DISTINCT sl.ZmedicalEventId
                 
  FROM FactTerritoryAccount a
 JOIN FactPatient AS p ON a.TerritoryAccountId=p.AccountId
  AND p.AccountId=@AccountId
  AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
  JOIN ZslFactMedicalEvent AS zsl ON zsl.PatientId = p.PatientId
 JOIN [ZFactMedicalEvent] sl ON sl.ZslMedicalEventId=zsl.ZslMedicalEventId
WHERE a.AcceptPrice<>a.Price-(a.MECPenalties+a.MEEPenalties+a.EQMAPenalties)', N'003K.00.0120_Сумма, принятая к оплате по счету, не соответствует сумме, выставленной к оплате по счету, с учетом санкций', N'003K.00.0120_Сумма, принятая к оплате по счету, не соответствует сумме, выставленной к оплате по счету, с учетом санкций случая', N'Сумма, принят к оплате по счету,не соответствует сумме,выставленной к оплате по счету с учетом санкц', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0130 SUMMAV должна быть равна сумме значений SUMV всех законченных случаев, включенных в счет
--SUMMAV должна быть равна сумме значений SUMV всех законченных случаев, включенных в счет


SELECT sl.ZmedicalEventId
--,  ksg.*


  FROM FactTerritoryAccount a
 JOIN FactPatient AS p ON a.TerritoryAccountId=p.AccountId
   AND p.AccountId=@AccountId
  AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
  JOIN ZslFactMedicalEvent AS zsl ON zsl.PatientId = p.PatientId
 JOIN [ZFactMedicalEvent] sl ON sl.ZslMedicalEventId=zsl.ZslMedicalEventId
WHERE a.TerritoryAccountId IN 
    (
      SELECT a.TerritoryAccountId--,a.Price,SUM(zsl.Price)--DISTINCT sl.ZmedicalEventId
      --,  ksg.*


        FROM FactTerritoryAccount a
       JOIN FactPatient AS p ON a.TerritoryAccountId=p.AccountId
        JOIN ZslFactMedicalEvent AS zsl ON zsl.PatientId = p.PatientId
       --JOIN [ZFactMedicalEvent] sl ON sl.ZslMedicalEventId=zsl.ZslMedicalEventId
      GROUP BY a.TerritoryAccountId,a.Price
      having a.Price<>SUM(zsl.Price))', N'003K.00.0130_SUMMAV должна быть равна сумме значений SUMV всех законченных случаев, включенных в счет', N'003K.00.0130_SUMMAV должна быть равна сумме значений SUMV всех законченных случаев, включенных в счет', N'Сумма, выстав к оплате по счету, не равна сумме выставлен к оплате сумм по всем закон случаям', 1, 0.0000, 4, 1.0000, 9, 2)

INSERT [dbo].[FactExpertCriterion] ([Code], [Weight], [Reason], [PG], [Type], [IsEnable], [DateBegin], [DateEnd], [Scope], [Query], [Description], [Comments], [Name], [IsAuto], [PenaltyPercent], [ErrorScope], [RefusalPercent], [Version], [Group]) VALUES (N'', 1, 53, N'', 1, 1, CAST(0x0000AAF800000000 AS DateTime), NULL, 2, N'--003K.00.0140
--Сумма, принятая к оплате по счету, не равна сумме принятых к оплате сумм по всем законченным случаям



SELECT sl.ZmedicalEventId
--,  ksg.*


  FROM FactTerritoryAccount a
 JOIN FactPatient AS p ON a.TerritoryAccountId=p.AccountId
    AND p.AccountId=@AccountId            
      AND ( (year(a.date)=2019 AND MONTH(a.[Date]) >=11 ) OR (year(a.date)>2019 ) )
  JOIN ZslFactMedicalEvent AS zsl ON zsl.PatientId = p.PatientId
 JOIN [ZFactMedicalEvent] sl ON sl.ZslMedicalEventId=zsl.ZslMedicalEventId
WHERE a.TerritoryAccountId IN 
    (
      SELECT a.TerritoryAccountId--,a.AcceptPrice,SUM(zsl.AcceptPrice)--DISTINCT sl.ZmedicalEventId
      --,  ksg.*
    FROM FactTerritoryAccount a
       JOIN FactPatient AS p ON a.TerritoryAccountId=p.AccountId
        JOIN ZslFactMedicalEvent AS zsl ON zsl.PatientId = p.PatientId
       --JOIN [ZFactMedicalEvent] sl ON sl.ZslMedicalEventId=zsl.ZslMedicalEventId
      GROUP BY a.TerritoryAccountId,a.AcceptPrice
      having a.AcceptPrice<>SUM(zsl.AcceptPrice))', N'003K.00.0140_SUMMAP должна быть равна сумме значений SUMP всех законченных случаев, включенных в счет', N'003K.00.0140_SUMMAP должна быть равна сумме значений SUMP всех законченных случаев, включенных в счет', N'Сумма, принятая к оплате по счету, не равна сумме принятых к оплате сумм по всем законченным случаям', 1, 0.0000, 4, 1.0000,  9, 2)

EXEC [dbo].[versionUpdate] 582
COMMIT TRAN;		
END TRY
		BEGIN CATCH			
			SET @ErrorMessage= ERROR_MESSAGE()
			SET @ErrorSeverity= ERROR_SEVERITY()
			SET @ErrorState= ERROR_STATE()
			RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState)
			IF (@@trancount > 0) ROLLBACK TRAN						
		END CATCH
IF (@@trancount > 0) ROLLBACK TRAN;