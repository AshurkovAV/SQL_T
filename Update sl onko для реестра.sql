--USE R_EMISZKO_KURSKAYA
IF OBJECT_ID('D3slonkIn_oms', 'V') IS NOT NULL
    DROP VIEW D3slonkIn_oms;
    GO
Create  VIEW [dbo].[D3slonkIn_oms]
AS
 SELECT oios.MOTCONSU_ID, 
on1.ID_REAS AS DS1_T, --����� ���������
on2.ID_St AS STAD, --������ �����������
on3.ID_T AS ONK_T, --�������� Tumor
on4.ID_N AS ONK_N, --�������� Nodus
on5.ID_M AS ONK_M, --�������� Metastasis 
cast(oios.MTSTZ AS INT) MTSTZ, --������� ��������� ��������� ����������
oios.SOD, --��������� �������� ����
oios.K_FR, --���������� ������� ���������� ������� �������
oios.WEI, --����� ���� (��)
oios.HEI,
oios.BSA,
--/////B_PROT
on6.ID_PrOt AS PROT, --��� ���������������� ��� ������
oios.D_PROT, --���� ����������� ���������������� ��� ������
--/////B_PROT
--///ONK_USL
on7.ID_TLech AS USL_TIP, --��� ������
on8.ID_THir AS HIR_TIP, --��� �������������� �������
on9.ID_TLek_L AS LEK_TIP_L, --����� ������������� �������
on10.ID_TLek_V AS  LEK_TIP_V, --���� ������������� �������
oios.PPTR, --������� ���������� ������������ ������� � �������� ��������
on11.ID_TLuch AS LUCH_TIP, --��� ������� �������
	--/////*  */LEK_PR
on12.ID_LEKP AS REGNUM, --������������� �������������� ���������, ������������ ��� ���������� ������������� ����������������� �������
ov.IDDKK AS CODE_SH, --��� ����� ������������� �������
oios.DATE_INJ --���� �������� �������������� ���������
	--/////*  */LEK_PR


 FROM OMS_ONKO_SLUCH  AS oios
LEFT JOIN OMS_N018 AS on1 ON on1.OMS_N018_ID = oios.OMS_N018_ID
LEFT JOIN OMS_N002 AS on2 ON on2.OMS_N002_ID = oios.OMS_N002_ID
LEFT JOIN OMS_N003 AS on3 ON on3.OMS_N003_ID = oios.OMS_N003_ID
LEFT JOIN OMS_N004 AS on4 ON on4.OMS_N004_ID = oios.OMS_N004_ID
LEFT JOIN OMS_N005 AS on5 ON on5.OMS_N005_ID = oios.OMS_N005_ID
LEFT JOIN OMS_N001 AS on6 ON on6.OMS_N001_ID = oios.OMS_N001_ID
LEFT JOIN OMS_N013 AS on7 ON on7.OMS_N013_ID = oios.OMS_N013_ID
LEFT JOIN OMS_N014 AS on8 ON on8.OMS_N014_ID = oios.OMS_N014_ID
LEFT JOIN OMS_N015 AS on9 ON on9.OMS_N015_ID = oios.OMS_N015_ID
LEFT JOIN OMS_N016 AS on10 ON on10.OMS_N016_ID = oios.OMS_N016_ID
LEFT JOIN OMS_N017 AS on11 ON on11.OMS_N017_ID = oios.OMS_N017_ID
LEFT JOIN OMS_N020 AS on12 ON on12.OMS_N020_ID = oios.OMS_N020_ID
LEFT JOIN OMS_V024 AS ov ON ov.OMS_V024_ID = oios.OMS_V024_ID
GO


GRANT INSERT ON [dbo].[D3slonkIn_oms] TO [fer]
GO

GO
GRANT SELECT ON [dbo].[D3slonkIn_oms] TO [fer]
GO

GO
GRANT ALTER ON [dbo].[D3slonkIn_oms] TO [fer]
GO

GO
GRANT UPDATE ON [dbo].[D3slonkIn_oms] TO [fer]
GO

GO
GRANT CONTROL ON [dbo].[D3slonkIn_oms] TO [fer]
GO

GO
GRANT INSERT ON [dbo].[D3slonkIn_oms] TO [iemk_user]
GO

GO
GRANT SELECT ON [dbo].[D3slonkIn_oms] TO [iemk_user]
GO

GO
GRANT ALTER ON [dbo].[D3slonkIn_oms] TO [iemk_user]
GO

GO
GRANT UPDATE ON [dbo].[D3slonkIn_oms] TO [iemk_user]
GO

GO
GRANT CONTROL ON [dbo].[D3slonkIn_oms] TO [iemk_user]
GO


IF OBJECT_ID('D3diagIn_oms', 'V') IS NOT NULL
    DROP VIEW D3diagIn_oms;
    GO
Create  VIEW [dbo].[D3diagIn_oms]
AS
SELECT d.MOTCONSU_ID,
d.DATE_CONSULTATION AS DIAG_DATE, --���� ������ ��������� 
d.DIAG_TIP, --��� ���������������� ����������
CASE WHEN d.DIAG_TIP = 1 THEN on1.ID_Mrf ELSE on3.ID_Igh END AS DIAG_CODE , --��� ���������������� ����������
CASE WHEN d.DIAG_TIP = 1 THEN on2.ID_R_M ELSE on4.ID_R_I END  AS DIAG_RSLT , --��� ���������� �����������

cast(d.REC_RSLT AS INT) REC_RSLT --������� ��������� ���������� �����������
FROM OMS_ONKO_DIAG AS d
LEFT JOIN OMS_N007 AS on1 ON on1.OMS_N007_ID = d.OMS_N007_ID
LEFT JOIN OMS_N008 AS on2 ON on2.OMS_N008_ID = d.OMS_N008_ID
LEFT JOIN OMS_N010 AS on3 ON on3.OMS_N010_ID = d.OMS_N010_ID
LEFT JOIN OMS_N011 AS on4 ON on4.OMS_N011_ID = d.OMS_N011_ID
GO

GRANT INSERT ON [dbo].[D3diagIn_oms] TO [fer]
GO

GO
GRANT SELECT ON [dbo].[D3diagIn_oms] TO [fer]
GO

GO
GRANT ALTER ON [dbo].[D3diagIn_oms] TO [fer]
GO

GO
GRANT UPDATE ON [dbo].[D3diagIn_oms] TO [fer]
GO

GO
GRANT CONTROL ON [dbo].[D3diagIn_oms] TO [fer]
GO

GO
GRANT INSERT ON [dbo].[D3diagIn_oms] TO [iemk_user]
GO

GO
GRANT SELECT ON [dbo].[D3diagIn_oms] TO [iemk_user]
GO

GO
GRANT ALTER ON [dbo].[D3diagIn_oms] TO [iemk_user]
GO

GO
GRANT UPDATE ON [dbo].[D3diagIn_oms] TO [iemk_user]
GO

GO
GRANT CONTROL ON [dbo].[D3diagIn_oms] TO [iemk_user]
GO

IF OBJECT_ID('D3naprIn_oms', 'V') IS NOT NULL
    DROP VIEW [D3naprIn_oms];
    GO
Create  VIEW [dbo].[D3naprIn_oms]
AS
SELECT n.MOTCONSU_ID,
n.DATE_CONSULTATION AS NAPR_DATE, --���� �����������
fo.CODE_OMS, --��� ��, ���� ��������� ����������� 
CAST(ov.IDVN AS INT) AS NAPR_V, --��� �����������
CAST(ov2.IDMET AS INT) AS MET_ISSL, --����� ���������������� ������������
fs.OMS_CODE AS NAPR_USL, --����������� ������ (���), ��������� � �����������


on1.ID_CONS AS PR_CONS, --���� ���������� ����������
n.DT_CONS --���� ���������� ����������

FROM OMS_ONKO_NAPR AS n
LEFT JOIN FM_ORG AS fo ON n.FM_ORG_ID = fo.FM_ORG_ID
LEFT JOIN OMS_V028 AS ov ON ov.OMS_V028_ID = n.OMS_V028_ID
LEFT JOIN OMS_V029 AS ov2 ON ov2.OMS_V029_ID = n.OMS_V029_ID
LEFT JOIN FM_SERV AS fs ON fs.FM_SERV_ID = n.FM_SERV_ID
LEFT JOIN OMS_N019 AS on1 ON on1.OMS_N019_ID = n.OMS_N019_ID
go

GRANT INSERT ON [dbo].[D3naprIn_oms] TO [fer]
GO

GO
GRANT SELECT ON [dbo].[D3naprIn_oms] TO [fer]
GO

GO
GRANT ALTER ON [dbo].[D3naprIn_oms] TO [fer]
GO

GO
GRANT UPDATE ON [dbo].[D3naprIn_oms] TO [fer]
GO

GO
GRANT CONTROL ON [dbo].[D3naprIn_oms] TO [fer]
GO

GO
GRANT INSERT ON [dbo].[D3naprIn_oms] TO [iemk_user]
GO

GO
GRANT SELECT ON [dbo].[D3naprIn_oms] TO [iemk_user]
GO

GO
GRANT ALTER ON [dbo].[D3naprIn_oms] TO [iemk_user]
GO

GO
GRANT UPDATE ON [dbo].[D3naprIn_oms] TO [iemk_user]
GO

GO
GRANT CONTROL ON [dbo].[D3naprIn_oms] TO [iemk_user]
GO

IF OBJECT_ID('D3UslStomatIn_oms', 'V') IS NOT NULL
    DROP VIEW [D3UslStomatIn_oms];
    GO
Create VIEW [dbo].[D3UslStomatIn_oms]
AS
SELECT ois.KRN_GUID AS [D3_SLGID]
      ,NULL AS [IDSERV] --����� ������ � ������� �����
      ,NULL AS [LPU] --��� ��
      --,NULL AS [LPU_1] --������������� ��
      --,NULL AS [PODR] --��� ���������
      ,NULL AS [PROFIL] --������� ����������� ������
      ,s.oms_code AS [VID_VME] --��� ������������ �������������
      ,case when s.AGE_TO <= 18 then 1 else 0 end AS  [DET] --������� �������� �������
      ,FM_BILL.BILL_DATE AS [DATE_IN] --���� ������ �������� ������
      ,FM_BILL.BILL_DATE AS [DATE_OUT] --���� ��������� �������� ������      
      ,MKB.CODE AS [DS]
      ,s.oms_code AS [CODE_USL]
      ,ois.CNT AS [KOL_USL]
     -- ,ois.[TARIF]
      ,ois.PRICE AS [SUMV_USL]
      ,ov.IDSPEC AS [PRVS]
      ,medecins.SNILS AS[CODE_MD]
      ,NULL AS [NPL]
      ,s.LABEL AS [COMENTU]
      ,FM_BILL.MOTCONSU_ID      
FROM FM_BILLDET AS ois
JOIN FM_BILL on FM_BILL.FM_BILL_ID = ois.FM_BILL_ID
JOIN MOTCONSU on FM_BILL.MOTCONSU_ID = MOTCONSU.MOTCONSU_ID
JOIN MEDECINS on MEDECINS.MEDECINS_ID = ois.MEDECINS_ID
LEFT JOIN FM_SERV s ON ois.FM_SERV_ID = s.FM_SERV_ID
LEFT JOIN SPECIALISATION AS s1 ON s1.SPECIALISATION_ID = MEDECINS.SPECIALISATION_ID
LEFT JOIN OMS_V021 AS ov ON ov.OMS_V021_ID = s1.OMS_V021_ID
LEFT JOIN DATA_DIAGNOSIS DD on DD.MOTCONSU_ID = MOTCONSU.MOTCONSU_ID AND dd.VID_ZABOLEVANIQ = 0 AND DD.N_LINE = 1
LEFT JOIN CIM10 MKB on MKB.CIM10_ID = DD.SS_LKA_CIM10
--WHERE ois.DATEUSL > = '20180101' -- ois.OMI_INVOICES_ID = 78
--AND ois.OMI_INVOICES_EV_ID = 938325

GO

GRANT INSERT ON [dbo].[D3UslStomatIn_oms] TO [fer]
GO

GO
GRANT SELECT ON [dbo].[D3UslStomatIn_oms] TO [fer]
GO

GO
GRANT ALTER ON [dbo].[D3UslStomatIn_oms] TO [fer]
GO

GO
GRANT UPDATE ON [dbo].[D3UslStomatIn_oms] TO [fer]
GO

GO
GRANT CONTROL ON [dbo].[D3UslStomatIn_oms] TO [fer]
GO

GO
GRANT INSERT ON [dbo].[D3UslStomatIn_oms] TO [iemk_user]
GO

GO
GRANT SELECT ON [dbo].[D3UslStomatIn_oms] TO [iemk_user]
GO

GO
GRANT ALTER ON [dbo].[D3UslStomatIn_oms] TO [iemk_user]
GO

GO
GRANT UPDATE ON [dbo].[D3UslStomatIn_oms] TO [iemk_user]
GO

GO
GRANT CONTROL ON [dbo].[D3UslStomatIn_oms] TO [iemk_user]
GO

IF OBJECT_ID('D3zslallIn_oms', 'V') IS NOT NULL
    DROP VIEW D3zslallIn_oms;
    GO
Create VIEW [dbo].[D3zslallIn_oms]
AS

SELECT 
DISTINCT
--MOTCONSU.MOTCONSU_ID, MOTCONSU.MOTCONSU_EV_ID,
--MOTCONSU_ev.MOTCONSU_ID, MOTCONSU_EV.MOTCONSU_EV_ID,
--MOTCONSU.KRN_GUID, MOTCONSU_EV.KRN_GUID,
----------//������ persan//-----------
PATIENTS.PATIENTS_ID ID_PAC, --��� ������ � ��������
PATIENTS.NOM FAM, --������� ��������
PATIENTS.PRENOM IM, --��� ��������
PATIENTS.PATRONYME OT,-- �������� ��������
(CASE	WHEN PATIENTS.POL = 0 THEN 1
		WHEN PATIENTS.POL = 1 THEN 2 
		ELSE 3 END) W, --��� ��������
PATIENTS.NE_LE DR, PATIENTS.TEL, NULL DOST, --��� ��������� ������������� ��������
NULL FAM_P, NULL IM_P, NULL OT_P, NULL W_P, NULL DR_P, NULL DOST_P,
NULL MR, 
(CASE	WHEN PATIENTS.VID_DOKUMENTA = 10 THEN 3
		WHEN PATIENTS.VID_DOKUMENTA = 21 THEN 14 
		ELSE 28 END) DOCTYPE, 
PATIENTS.SERIQ_DOKUMENTA AS DOCSER, -- ����� ���������, ��������������� �������� �������� ��� �������������
PATIENTS.PASPORT_N AS DOCNUM,  --����� ���������, ��������������� �������� �������� ��� �������������
KEM_V_DAN [DOCORG],
KOGDA_V_DAN [DOCDATE],
CASE WHEN PATIENTS.SNILS='' THEN NULL ELSE PATIENTS.SNILS END AS SNILS, --����� �������� ��� �������������
NULL OKATOG, --��� ����� ���������� �� �����
NULL OKATOP, --��� ����� ���������� �� �����
-----//����� persan//-----------

--------//������ �������� � ��������//--------
CASE WHEN DIPO.SERIQ_POLISA = '' THEN NULL ELSE DIPO.SERIQ_POLISA END AS DocS1, -- ����� ���������, ��������������� ���� ����������� �� ���
DIPO.NOMER_POLISA AS DocN1, -- ����� ���������, ��������������� ���� ����������� �� ���
NULL ST_OKATO, --������ �����������  ����������� ����� ���������� ������ ���� ��� ������� ������� ������� ��� ������� ������
ORG.CODE_OMS AS SMO, -- ���������� ����� ���. 
ORG.ORGN SMO_OGRN, --���� ���
NULL SMO_OK, --����� ���������� ����������� 
ORG.SHORT_LABEL AS SMO_NAM, --������������ ���
NULL NOVOR, --������� �������������
--------//����� �������� � ��������//--------

----//������ �������� � ����������� ������//----
MOTCONSU_EV.MOTCONSU_ID IDCASE, --����� ������ � ������� �������
3 USL_OK, --������� �������� ���. ������
--doc.vidpom 
null VIDPOM, --��� ����������� ������ ��������� �� ����������� �����
--CASE WHEN SUBSTRING(OMS_CODE,11,1) = '3' AND MKB.CODE NOT LIKE 'Z%' THEN 2 ELSE CAST(DATA_AMBULAT_PATIENT_COUPON.ED_AIDINGS_FORMS_ID AS INT) END FOR_POM, --����� �������� ����������� ������
DATA_AMBULAT_PATIENT_COUPON.OMS_V014_ID FOR_POM,
NULL NPR_MO, --��� ��, ����������� �� ������� (�����������, ������������, ��������������)
NULL NPR_DATE, --���� ����������� �� ������� (�����������, ������������, ��������������)
'460026' LPU, --��� ��
CAST(MOTCONSU_EV.DATE_CONSULTATION as date) DATE_Z_1,  CAST(MOTCONSU_EV.EV_DATE_CLOSE as date) DATE_Z_2,
NULL KD_Z, --����������������� �������������� (�����-���/��������-���)
NULL VNOV_M, --��� ��� ��������
 CASE WHEN MOTCONSU.DATE_CONSULTATION >= '20191010' AND ED_TREATMENT_RESULT_CODE IS NULL THEN ov5.IDRMP
      	ELSE CAST(ED_TREATMENT_RESULT_CODE AS INT) END AS [RSLT], --��������� ���������
      CASE WHEN MOTCONSU.DATE_CONSULTATION >= '20191010' AND ED_OUTCOMES_CODE IS NULL THEN ov4.IDIZ 
      	ELSE CAST(ED_OUTCOMES_CODE AS INT ) END AS [ISHOD], --����� �����������
NULL OS_SLUCH, --������� ������ ������ ��� ����������� ��������� �� ����������� �������
NULL VB_P, --������� ����������������� ��������

----//������ �������� � ������//----
MOTCONSU.KRN_GUID SL_ID, --������������� ������
CAST(301 AS NVARCHAR(3)) LPU_1, --������������� ��
NULL PODR, --��� ���������
--doc.profil 
NULL PROFIL, --������� ����������� ������
NULL PROFIL_K, --������� �����
--doc.det 
NULL DET, --������� �������� �������
CASE WHEN CAST(MOTCONSU.DATE_CONSULTATION AS DATE) < = '20191009' THEN 
	CASE WHEN CAST(DATA_AMBULAT_PATIENT_COUPON.ED_AIDINGS_FORMS_ID AS INT) = 2 THEN '1.1'
ELSE
	CASE WHEN SUBSTRING(OMS_CODE,11,1) = '1' AND MKB.CODE NOT LIKE 'Z%' THEN '1.0'     
		 WHEN SUBSTRING(OMS_CODE,11,1) = '2' AND MKB.CODE LIKE 'Z%' THEN '2.1' 
		 WHEN SUBSTRING(OMS_CODE,11,1) = '3' AND MKB.CODE NOT LIKE 'Z%' THEN '1.1' ELSE 
		 	CASE WHEN MKB.CODE LIKE 'Z%' THEN '2.1' ELSE '1.0' END 
	END END	 
	ELSE  ov2.IDPC END P_CEL,--���� ���������

CAST(DATA_AMBULAT_PATIENT_COUPON.DATA164_ID AS VARCHAR(50)) NHISTORY,--����� ������� �������/ ������ ������������� ��������/ ����� ������ ������ ����������� ������
NULL P_PER, --������� �����������/ ��������
CAST(MOTCONSU.DATE_CONSULTATION AS DATE) DATE_1,  CAST(MOTCONSU.DATE_CONSULTATION AS DATE) DATE_2,
NULL KD, --����������������� �������������� (�����-���/��������-���)
MKB1.CODE DS0,
MKB.CODE AS DS1,
NULL DS2, 
CASE WHEN MKB.CODE LIKE 'Z%' THEN NULL ELSE 
	CASE WHEN dd.STATISTIKA = 0 THEN 1  
	     WHEN dd.STATISTIKA = 1 THEN 2
	     WHEN dd.STATISTIKA = 2 THEN 3
	     ELSE 1 END END C_ZAB,--�������� ��������� �����������
CASE WHEN DATA_AMBULAT_PATIENT_COUPON.DN = 0 THEN 1 
     WHEN DATA_AMBULAT_PATIENT_COUPON.DN = 1 THEN 2
     WHEN DATA_AMBULAT_PATIENT_COUPON.DN = 2 THEN 3
     WHEN DATA_AMBULAT_PATIENT_COUPON.DN = 3 THEN 4
     WHEN DATA_AMBULAT_PATIENT_COUPON.DN = 4 THEN 6
     ELSE DATA_AMBULAT_PATIENT_COUPON.DN END DN,          
NULL CODE_MES1,
NULL CODE_MES2,
NULL KSG_KPG, 
NULL REAB,
--doc.prvs
 NULL PRVS,
'V021' VERS_SPEC, 
medecins.SNILS IDDOKT,
NULL ED_COL,
NULL TARIF, 
----//����� �������� � ������//----



CASE WHEN ORG.CODE_OMS LIKE '46%' AND DATA_AMBULAT_PATIENT_COUPON.ED_AIDINGS_FORMS_ID != 2 THEN 25 
	 WHEN                             DATA_AMBULAT_PATIENT_COUPON.ED_AIDINGS_FORMS_ID  = 2 THEN 29	 
ELSE 25 END IDSP, --��� ������� ������ ����������� ������
NULL SUMV, --�����, ������������ � ������
NULL OPLATA, --��� ������
NULL SUMP, --�����, �������� � ������ ��� (�����)
NULL SANK_IT --����� ������� �� ������������ ������

----//����� �������� � ����������� ������//----

,CASE WHEN s.SPECIALISATION_ID IN (30,126,127,128,129,130,137,146, 187) THEN 1 ELSE 0 END stomat
,CASE WHEN n.MOTCONSU_ID IS NOT NULL THEN 1 ELSE 0 END napr
,CASE WHEN onkoslush.MOTCONSU_ID IS NOT NULL THEN 1 ELSE 0 END onko
,CASE WHEN oiod.MOTCONSU_ID IS NOT NULL THEN 1 ELSE 0 END diag
--,doc.NAME
--INTO reestrmedialog042019_1

FROM dbo.FM_BILL
JOIN dbo.FM_BILLDET on FM_BILL.FM_BILL_ID = FM_BILLDET.FM_BILL_ID
LEFT JOIN MEDECINS MEDECINS_SERV on FM_BILLDET.MEDECINS_ID = MEDECINS_SERV.MEDECINS_ID
LEFT JOIN dbo.FM_SERV on FM_SERV.FM_SERV_ID = FM_BILLDET.FM_SERV_ID
JOIN MOTCONSU on FM_BILL.MOTCONSU_ID = MOTCONSU.MOTCONSU_ID
JOIN MOTCONSU MOTCONSU_EV on MOTCONSU_EV.MOTCONSU_ID = FM_BILL.MOTCONSU_EV_ID
JOIN DATA_AMBULAT_PATIENT_COUPON ON DATA_AMBULAT_PATIENT_COUPON.MOTCONSU_ID = MOTCONSU_EV.MOTCONSU_ID
LEFT JOIN MEDDEP ON MEDDEP.MEDDEP_ID = ISNULL(DATA_AMBULAT_PATIENT_COUPON.VRACH_OTDELENIE, MOTCONSU_EV.MEDDEP_ID)
JOIN MEDECINS on MEDECINS.MEDECINS_ID = MOTCONSU_EV.MEDECINS_ID
JOIN PATIENTS on PATIENTS.PATIENTS_ID = MOTCONSU.PATIENTS_ID
LEFT JOIN SPECIALISATION AS s ON s.SPECIALISATION_ID = MEDECINS.SPECIALISATION_ID
LEFT JOIN (SELECT * FROM DATA_INS_POLICIES_OMI WITH (NOLOCK) WHERE IS_MAIN = 1 ) DIPO ON DIPO.PATIENTS_ID = PATIENTS.PATIENTS_ID
LEFT JOIN FM_ORG ORG WITH (NOLOCK) ON ORG.FM_ORG_ID = DIPO.SMO
LEFT JOIN DATA_DIAGNOSIS DD on DD.MOTCONSU_ID = MOTCONSU.MOTCONSU_ID AND dd.VID_ZABOLEVANIQ = 0 AND DD.N_LINE = 1
LEFT JOIN CIM10 MKB on MKB.CIM10_ID = DD.SS_LKA_CIM10
LEFT JOIN DATA_DIAGNOSIS DD1 on DD.MOTCONSU_ID = MOTCONSU_EV.MOTCONSU_ID AND dd.VID_ZABOLEVANIQ = 2
LEFT JOIN CIM10 MKB1 on MKB1.CIM10_ID = DD1.SS_LKA_CIM10
LEFT JOIN FM_DEP on FM_DEP.FM_DEP_ID = ISNULL(MEDDEP.FM_DEP_ID, MOTCONSU_EV.FM_DEP_ID)
LEFT JOIN ED_TREATMENT_RESULTS ED_TREATMENT_RESULTS ON ED_TREATMENT_RESULTS.ED_TREATMENT_RESULT_ID = DATA_AMBULAT_PATIENT_COUPON.ED_TREATMENT_RESULT_ID 
LEFT JOIN ED_OUTCOMES ED_OUTCOMES ON ED_OUTCOMES.ED_OUTCOMES_ID = DATA_AMBULAT_PATIENT_COUPON.ED_OUTCOMES_ID
LEFT JOIN ED_RECEPTION_TYPES AS ert ON ert.ED_RECEPTION_TYPE_ID = DATA_AMBULAT_PATIENT_COUPON.VID_PRIEMA
LEFT JOIN OMS_V012 AS ov4 ON DATA_AMBULAT_PATIENT_COUPON.OMS_V012_ID = ov4.OMS_V012_ID
LEFT JOIN OMS_V009 AS ov5 ON DATA_AMBULAT_PATIENT_COUPON.OMS_V009_ID = ov5.OMS_V009_ID
LEFT JOIN OMS_V025 AS ov2 ON DATA_AMBULAT_PATIENT_COUPON.OMS_V025_ID = ov2.OMS_V025_ID

LEFT JOIN (SELECT d.MOTCONSU_ID 
           FROM OMS_ONKO_DIAG  d
           GROUP BY d.MOTCONSU_ID ) AS oiod ON MOTCONSU.MOTCONSU_ID = oiod.MOTCONSU_ID           
LEFT JOIN (SELECT os.MOTCONSU_ID 
			FROM OMS_ONKO_SLUCH os
			GROUP BY os.MOTCONSU_ID ) AS onkoslush ON MOTCONSU.MOTCONSU_ID = onkoslush.MOTCONSU_ID
LEFT JOIN (SELECT n.MOTCONSU_ID 
			FROM OMS_ONKO_NAPR n
			GROUP BY n.MOTCONSU_ID ) AS n ON MOTCONSU.MOTCONSU_ID = n.MOTCONSU_ID
--JOIN @docTab doc ON doc.SNILS = MEDECINS.SNILS
WHERE 
--CAST(MOTCONSU.DATE_CONSULTATION AS DATE) >='20210701'AND CAST(MOTCONSU.DATE_CONSULTATION AS DATE) <= '20210731' 
-- MKB.CODE NOT LIKE 'c%'
--s.SPECIALISATION_ID IN (30,126,127,128,129,130,137,146, 187) AND 
 ISNULL(FM_BILLDET.CANCEL, 0) = 0 and ISNULL(FM_BILLDET.FREE_PAY, 0) = 0 AND FM_BILLDET.DONE = 1 AND ISNULL(FM_BILLDET.CANCEL, 0) = 0 AND ISNULL(FM_BILLDET.BLOCKED, 0) != 1
--ORDER BY PATIENTS.NOM, PATIENTS.PRENOM, PATIENTS.PATRONYME, CAST(MOTCONSU_EV.DATE_CONSULTATION AS DATE)



GO



GRANT INSERT ON [dbo].[D3zslallIn_oms] TO [fer]
GO

GO
GRANT SELECT ON [dbo].[D3zslallIn_oms] TO [fer]
GO

GO
GRANT ALTER ON [dbo].[D3zslallIn_oms] TO [fer]
GO

GO
GRANT UPDATE ON [dbo].[D3zslallIn_oms] TO [fer]
GO

GO
GRANT CONTROL ON [dbo].[D3zslallIn_oms] TO [fer]
GO

GO
GRANT INSERT ON [dbo].[D3zslallIn_oms] TO [iemk_user]
GO

GO
GRANT SELECT ON [dbo].[D3zslallIn_oms] TO [iemk_user]
GO

GO
GRANT ALTER ON [dbo].[D3zslallIn_oms] TO [iemk_user]
GO

GO
GRANT UPDATE ON [dbo].[D3zslallIn_oms] TO [iemk_user]
GO

GO
GRANT CONTROL ON [dbo].[D3zslallIn_oms] TO [iemk_user]
GO
