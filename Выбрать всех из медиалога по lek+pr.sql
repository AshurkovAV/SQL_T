SELECT p.NOM, p.PRENOM, p.PATRONYME,
m.MOTCONSU_ID,
dw.DATA_VVEDENIYA_LEK_PREPAR as 'Дата введения лек препар' ,
v032.Name as 'Код схемы лекарственной терапии',
cast(n020.ID_LEKP as varchar(10))+ ' '+ n020.MNN as 'Регистр. номер лек.препарата', 
vr58.FULLNAME as 'Единица измерения',
dw.DOZA_VVEDENIYA_LEK_PREPAR as 'Доза введения лек. препарата',
vr68.NAME_RUS as 'Путь введения лек. препарата',
cast (dw.KOLICHESTVO_VVEDENIY as int) as 'Количество',
MEDECINS.NOM, MEDECINS.PRENOM
 FROM MOTCONSU m
 JOIN PATIENTS AS p ON p.PATIENTS_ID = m.PATIENTS_ID
 join DATA_W438_D3_LEK_PR_COV_OMS dw on dw.MOTCONSU_ID=m.motconsu_id
 left join V032 v032 on v032.ID=dw.KOD_SHEMY_LECHENIYA
 left join N020 n020 on n020.IDN020=dw.IDENTIFIKATOR_LEK_PREPAR
 left join VR58 vr58 on vr58.ID=dw.EDINICA_IZMERENIYA_DOZY
 left join VR68 vr68 on vr68.ID=dw.PUT_VVEDENIYA_LEK_PREPAR
 JOIN MEDECINS on MEDECINS.MEDECINS_ID = m.MEDECINS_ID
 
-- where  m.motconsu_Id=1576076
