-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetIstrumental_issledovanie] 
@motconsu_id int	
	
AS
BEGIN
--DECLARE @motconsu INT
	 SELECT
	--Данные пациента
	  di.MOTCONSU_ID 'MOTCONSU_ID ',
		REPLACE((convert(varchar(10),di.DATE_CONSULTATION,112) + convert(varchar(5), convert(time,
		di.DATE_CONSULTATION))), ':','') + '+0300' AS'effectiveTime_value',
		convert(varchar(10),di.DATE_CONSULTATION,112) AS 'DATE_CONSULTATION',
    di.PATIENTS_ID as 'PATIENTS_ID',
    pat.SNILS AS 'SNILS_PATIENTS',
		pat.NOM AS 'PATIENTS_NOM',
    pat.PRENOM AS 'PATIENTS_PRENOM',
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
		pat.ADRES_FAKTIHESKIJ AS 'PATIENTS_ADRES',
		-- Данные организации
		'nullFlavor="NI"' AS 'NI_nullFlavor',
	di.LPU_OFORMITEL  AS 'MO_OID',
		di.NAIMENOVANIE_LPU_OFORMITE AS 'ORG_NAME',
		di.ADRES_OFORMITELYA AS 'ADRES_ORG',
	 '46' AS 'providerOrganization_addr_state', 
		--Данные врача//данные врача придавшего юр силу
		di.vrach AS 'AUTHOR_ID', 
		di.DOLZGNOST_VRACH AS 'AUTHOR_DOLZGNOST_CODE',
    n.DOLZGNOST_MED_PERSONALA AS 'AUTHOR_DOLZGNOST_NAME',
		ltrim(rtrim(med.NOM)) AS 'AUTHOR_NOM',
    CASE WHEN LEN (ltrim(rtrim(substring(med.PRENOM, 0, charindex(' ', med.PRENOM))))) = 0 THEN med.PRENOM ELSE (    ltrim(rtrim(substring(med.PRENOM, 0, charindex(' ', med.PRENOM))))) END AS 'AUTHOR_PRENOM',
    ltrim(rtrim(substring(med.PRENOM, charindex(' ', med.PRENOM) +1, (len(med.PRENOM) + charindex(' ', med.PRENOM))))) AS 'AUTHOR_PATRONYME',
           --- Тип исследования
           di.METOD_ISSLED as 'KOD_METOD_ISSLED',
           nm.Name as 'NAME_METOD_ISSLED',
           
    ---сведения об исполнителе инструментального исследования
    di.UCHASTNIK as 'ISPOLNITEL_ID', 
    di.DOLZGNOST_UCHASTNIK as 'DOLZGNOST_ISPOLNITEL_CODE',
    nszd.DOLZGNOST_MED_PERSONALA as 'DOLZGNOST_ISPOLNITEL_NAME',
    ltrim(rtrim(meds.NOM)) AS 'ISPOLNITEL_NOM',
    CASE WHEN LEN (ltrim(rtrim(substring(meds.PRENOM, 0, charindex(' ', meds.PRENOM))))) = 0 THEN med.PRENOM ELSE (    ltrim(rtrim(substring(meds.PRENOM, 0, charindex(' ', meds.PRENOM))))) END AS 'ISPOLNITEL_PRENOM',
    
    -- сведения о случае оказания медицинской помощи
    REPLACE((convert(varchar(10),di.DATA_NACHALA_ISSLEDOVANIY,112) + convert(varchar(5), convert(time,
		di.DATA_NACHALA_ISSLEDOVANIY))), ':','') + '+0300' AS 'DATA_NACHALA_ISSLEDOVANIY',
    di.DIAGNOZ_OPISANIE AS 'DIAGNOZ_OPISANIE',
    
    -- Вид обращения
    (select case 
		when di.PORYADOK_OBRASCHENIYA=0 THEN 'Первичный'
		when di.PORYADOK_OBRASCHENIYA=1 THEN 'Повторный'
		ELSE 'не определен' 
		END) AS 'PORYADOK_OBRASCHENIYA_NAME',
		  (select case 
		when di.PORYADOK_OBRASCHENIYA=0 THEN '1'
		when di.PORYADOK_OBRASCHENIYA=1 THEN '2'
		ELSE 'не определен' 
		END) AS 'CODE_PORYADOK_OBRASCHENIYA',
		-- Место оказания медицинской помощи
		di.MESTO_PROVED AS 'CODE_MESTO_PROVED',
		np.NAME AS 'MESTO_PROVED',
		--Кодирование исследования
		dp.KOD AS 'KOD_ISLEDOVANIYA',
    ns.FULLNAME AS 'NAME_ISLEDOVANIYA',
   
   
     di.ZAKLYUCHENIE as 'ZAKLYUCHENIE',
	 di.PROTOKOL as 'PROTOKOL',
	 di.REKOMENDACII AS 'REKOMENDACII',
	 --патология
	 dpp.NAIMENOVANIE_PATOLOGII AS 'NAIMENOVANIE_PATOLOGII'
	 			
FROM DATA_W438_PROTOKOL_ISSLED   di
 LEFT JOIN MOTCONSU AS m ON m.MOTCONSU_ID = di.MOTCONSU_ID
 LEFT JOIN  DATA_W438_PATALOGII_PROT AS dpp ON dpp.MOTCONSU_ID = di.MOTCONSU_ID
 LEFT JOIN PATIENTS AS pat ON pat.PATIENTS_ID = di.PATIENTS_ID
LEFT JOIN MEDECINS AS med ON med.MEDECINS_ID = di.vrach
LEFT JOIN NSI_DOLZGNOST AS n ON n.CODE_NSI_DOLZGNOST = di.DOLZGNOST_VRACH
LEFT JOIN NSI_DOLZGNOST AS nsz ON nsz.CODE_NSI_DOLZGNOST=di.DOLZGNOST_NAPRAV
LEFT JOIN NSI_FSIDI_METHODS AS nm ON nm.ID = di.METOD_ISSLED
LEFT JOIN MEDECINS AS meds ON meds.MEDECINS_ID = di.UCHASTNIK
LEFT JOIN NSI_DOLZGNOST AS nszd ON nszd.CODE_NSI_DOLZGNOST = di.DOLZGNOST_UCHASTNIK
LEFT JOIN DATA_W438_ISSLED_PROTOKOL AS dp on dp.MOTCONSU_ID = di.MOTCONSU_ID
LEFT JOIN  NSI_FSIDI_SPR AS ns ON ns.ID=dp.KOD
LEFT JOIN  NSI_MEDHELP_PLACES AS np ON np.ID=di.MESTO_PROVED
WHERE di.MOTCONSU_ID = @motconsu_id
END


GO


GRANT CONTROL ON [dbo].[GetIstrumental_issledovanie] TO [iemk_user]

GRANT ALTER ON [dbo].[GetIstrumental_issledovanie] TO [iemk_user]

GRANT EXECUTE ON [dbo].[GetIstrumental_issledovanie] TO [iemk_user]