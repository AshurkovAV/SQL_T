CREATE PROCEDURE [dbo].[Getepicriz_po_zak_sluch] 
	@motconsu_id int
AS
BEGIN
	--DECLARE @motconsu INT = 1496975
  SELECT
	--Данные пациента
	  da.MOTCONSU_ID 'MOTCONSU_ID ',
		REPLACE((convert(varchar(10),da.DATE_CONSULTATION,112) + convert(varchar(5), convert(time,
		da.DATE_CONSULTATION))), ':','') + '+0300' AS'effectiveTime_value',
    da.PATIENTS_ID as 'PATIENTS_ID',
    da.SNILS_PACIENTA AS 'SNILS_PATIENTS',
		pat.NOM AS 'PATIENTS_NOM',
    pat.PRENOM AS 'PATIENTS_PRENOM',
     pat.PATRONYME AS 'PATIENTS_PATRONYME',
	  CONVERT(VARCHAR(10), pat.ne_le, 112) AS 'BirthTime_Value',
		(select case 
		when pat.POL=0 THEN '1'
		when pat.POL=1 THEN '2'
		ELSE 'не определен' 
		END) AS 'PATIENTS_POL_CODE',
		(select case 
		when pat.POL=0 THEN 'Мужской'
		when pat.POL=1 THEN 'Женский'
		ELSE 'не определен' 
		END) AS 'PATIENTS_POL',
		-- Данные организации
		'nullFlavor="NI"' AS 'NI_nullFlavor',
	(SELECT IEMK_OID FROM FM_ORG WHERE FM_ORG_ID = 1)  AS 'MO_OID',
	(SELECT ORGN FROM FM_ORG WHERE FM_ORG_ID = 1)  AS 'ORG_OGRN',
	'8(4712)-54-57-35' AS 'ORG_TELEFON',
		da.NAIMENOVANIE_MO AS 'ORG_NAME',
		da.ADRES_MO AS 'ADDRESS_ORG',
	 '46' AS 'providerOrganization_addr_state',
		--Данные врача
   REPLACE((convert(varchar(10), da.DATE_CONSULTATION ,112) + convert(varchar(5), convert(time, da.DATE_CONSULTATION ))), ':','') + '+0300' AS 'AUTHOR_DATE_SIGN',
	 da.SNILS_VRACHA AS 'AUTHOR_SNILS',
		da.vrach AS 'AUTHOR_ID', 
		da.DOLZHNOST_VRACHA AS 'AUTHOR_DOLZGNOST_CODE',
    n.DOLZGNOST_MED_PERSONALA AS 'AUTHOR_DOLZGNOST_NAME',
		ltrim(rtrim(med.NOM)) AS 'AUTHOR_NOM',
    CASE WHEN LEN (ltrim(rtrim(substring(med.PRENOM, 0, charindex(' ', med.PRENOM))))) = 0 THEN med.PRENOM ELSE (    ltrim(rtrim(substring(med.PRENOM, 0, charindex(' ', med.PRENOM))))) END AS 'AUTHOR_PRENOM',
    ltrim(rtrim(substring(med.PRENOM, charindex(' ', med.PRENOM) +1, (len(med.PRENOM) + charindex(' ', med.PRENOM))))) AS 'AUTHOR_PATRONYME',
		 
			--данные заместителя врача
			REPLACE((convert(varchar(10), da.DATE_CONSULTATION ,112) + convert(varchar(5), convert(time, da.DATE_CONSULTATION))), ':','') + '+0300' AS 'SIGNED_DOCTOR_DATE_SIGN',
		da.ZAVEDUYUSCHIY AS 'SIGNED_DOCTOR_ID',
	     da.SNILS_ZAV_ AS 'SIGNED_DOCTOR_SNILS',
			da.DOLZHNOST_ZAV_ AS 'SIGNED_DOCTOR_ZAVEDUYSHII',
			nsz.DOLZGNOST_MED_PERSONALA AS 'NAME_DOCTOR_ZAVEDUYSHII',
	    ltrim(rtrim(meds.NOM)) AS 'DOCTOR_ZAVEDUYSHII_NOM',
    --                <!-- R [1..1] Имя -->
    CASE WHEN LEN (ltrim(rtrim(substring(meds.PRENOM, 0, charindex(' ', meds.PRENOM))))) = 0 THEN meds.PRENOM ELSE (ltrim(rtrim(substring(meds.PRENOM, 0, charindex(' ', meds.PRENOM))))) END AS 'DOCTOR_ZAVEDUYSHII_PRENOM',
    --                <!-- [1..1] Отчество -->
    ltrim(rtrim(substring(meds.PRENOM, charindex(' ', meds.PRENOM) +1, (len(meds.PRENOM) + charindex(' ', meds.PRENOM))))) AS 'DOCTOR_ZAVEDUYSHII_PATRONYME',
		
   --Кодирование источника оплаты
	 da.ISTOCHNIK_OPLATY AS 'CODE_IST_OPL',
   nip.FULL_NAME AS 'NAME_IST_OPL',
	 
	 -- Тип документа
	 	da.TIP_DOKUMENTA_OSNOVANIYA AS 'TYPE_OMS',
  ndo.NAME AS 'NAME_OMS',
	
	 -- Тип полиса ОМС
	 da.VID_POLISA_OMS AS  'TYPE_POLICE',
	 npt.NAME AS 'TYPE_POLICE_NAME',
	 
	 --- Полис 
	dipo.NOMER_POLISA AS 'PATIENTS_NOMER_POLISA',
	da.NAIMENOVANIE_SMO as 'ORG_NAME_STRAH',
	 convert(varchar(10), dipo.DATA_V_DAHI ,112) AS 'DATE_START',
	 --Сведение о событие
		da.TIP_DOKUMENTIRUEMOGO_SOBY AS 'TYPE_CODE_SOB',
	  nts.TYPE AS 'NAME_DOC_SOB',
		REPLACE((convert(varchar(10), da.DATA_OTKRYTIYA_SLUCHAYA ,112) + convert(varchar(5), convert(time, da.DATA_OTKRYTIYA_SLUCHAYA ))), ':','') + '+0300' AS 'DATE_SLUCHAYA_START',
		REPLACE((convert(varchar(10), da.DATA_ZAKRYTIYA_SLUCHAYA ,112) + convert(varchar(5), convert(time, da.DATA_ZAKRYTIYA_SLUCHAYA ))), ':','') + '+0300' AS 'DATE_SLUCHAYA_END',
							
				--Форма оказания медицинской помощи
				da.FORMA_OKAZANIYA_MP AS 'CODE_FORM_POM',
				o14.FRMMPNAME AS 'NAME_FORM_POM',

				-- Вид медицинской помощи
				da.VID_OKAZANIYA_MP AS 'CODE_VID_MP',
				o8.VMPNAME AS 'NAME_VID_MP',
				
				--Условия оказания медицинской помощи
				da.USLOVIYA_OKAZANIYA_MP AS 'CODE_USL_OK',
				o6.UMPNAME AS 'NAME_USL_OK',
				
				--Сведения о случае оказания медицинской помощи
				da.MKB_SLUCHAYA AS 'CODE_MKB',
				(select case 
		      when da.PORYADOK_OBRASCHENIYA = 0 THEN 'первично'
		      when da.PORYADOK_OBRASCHENIYA = 1 THEN 'повторно'
		      ELSE 'не определен' 
		         END) AS  'NAME_P_OBR',
				da.CEL_ AS 'NAME_CEL_',
				ndo.NAME AS 'NAME_OMS',
				convert(varchar(10),da.DATE_CONSULTATION,112) AS 'DATE_SLUCHAYA',
				
				-- Порядок обращения
				da.PORYADOK_OBRASCHENIYA AS 'CODE_P_OBR',
				da.DIAGNOZ_TEKST AS 'NAME_MKB'
				
FROM DATA_W438_EPIK_ZAK_AMB   da
LEFT JOIN MOTCONSU AS m ON m.MOTCONSU_ID = da.MOTCONSU_ID
LEFT JOIN PATIENTS AS pat ON pat.PATIENTS_ID = da.PATIENTS_ID
LEFT JOIN (SELECT * FROM DATA_INS_POLICIES_OMI WHERE IS_MAIN = 1 AND DEYSTVUYUSCHIY = 1) 
dipo ON dipo.PATIENTS_ID = pat.PATIENTS_ID
LEFT JOIN MEDECINS AS med ON med.MEDECINS_ID = da.vrach
LEFT JOIN NSI_DOLZGNOST AS n ON n.CODE_NSI_DOLZGNOST = da.DOLZHNOST_VRACHA
LEFT JOIN MEDECINS AS meds ON meds.MEDECINS_ID = da.ZAVEDUYUSCHIY
LEFT JOIN NSI_DOLZGNOST AS nsz ON nsz.CODE_NSI_DOLZGNOST=da.DOLZHNOST_ZAV_
LEFT JOIN  NSI_ISTOCHNIK_OPLATY AS nip ON nip.ID=da.ISTOCHNIK_OPLATY
LEFT JOIN NSI_DOCS_OSNOVANIE AS ndo ON ndo.ID = da.TIP_DOKUMENTA_OSNOVANIYA
LEFT JOIN NSI_OMS_POLICE_TYPE AS npt ON npt.ID = da.VID_POLISA_OMS
LEFT JOIN NSI_TYPE_SOBITIE AS nts ON nts.ID=da.TIP_DOKUMENTIRUEMOGO_SOBY
LEFT JOIN OMS_V014 AS o14 ON o14.OMS_V014_ID = da.FORMA_OKAZANIYA_MP
LEFT JOIN OMS_V008 AS o8 ON o8.OMS_V008_ID = da.VID_OKAZANIYA_MP
LEFT JOIN OMS_V006 AS o6 ON o6.OMS_V006_ID = 	da.USLOVIYA_OKAZANIYA_MP


WHERE da.MOTCONSU_ID = @motconsu_id
END

GO



GRANT EXECUTE ON [dbo].[Getepicriz_po_zak_sluch] TO [iemk_user]

GRANT ALTER ON [dbo].[Getepicriz_po_zak_sluch] TO [iemk_user]

GRANT CONTROL ON [dbo].[Getepicriz_po_zak_sluch] TO [iemk_user]
GO
