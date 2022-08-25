DECLARE @docTab TABLE (id INT, NAME NVARCHAR(50), profil INT, prvs INT, snils NVARCHAR(14), det INT, vidpom INT, idmis INT)
----INSERT INTO @docTab(id,NAME)VALUES(331,'������')
----INSERT INTO @docTab(id,NAME)VALUES(88,'���������� �') --��������� ������
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(444,'��������� �.�.',    53, 35,  '141-347-479 48',0,13, 2600219)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(406,'���������� �',      53, 35,  '138-203-517 36',0,13, 2600008)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(50,'����������',         108, 84, '034-574-091 51',0,13, 2600160)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(443,'�����������',       108, 84, '137-881-294 00',0,13, 2600217)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(216,'������ �',          28, 24,  '132-464-230 28',0,13, 2600188)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(13,'������� �',          75, 55,  '152-583-987 94',0,13, 2600214)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(365,'������ �.�.',       122, 92, '152-443-755 54',0,13, 2600163)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(77,'�������� �.�.',      136, 2,  '126-570-571 61',0,13, 2600147)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(69,'�������� �.�.',      136, 2,  '029-197-986 05',0,13, 2600073)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(350,'��������� �.�.',    136, 2,  '034-571-926 57',0,13, 2600101)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(314,'�������� �.�.',     136, 2,  '029-208-574 65',0,13, 2600063)
														   
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(258,'�������� �.�.',     16, 17,  '140-296-610 41',0,13, 2600083)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(57,'�������� �.�.',      16, 17,  '071-529-745 72',0,13, 2600038)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(366,'������������ �.�.', 122, 92, '140-847-262 56',0,13, 2600058)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(301,'��������� �.�.',    97, 76,  '172-308-755 64',0,12, 2600235)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(452,'��������� �.�.',    97, 76,  '161-682-338 70',0,12, 2600238)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(353,'������� �.�.',      97, 76,  '048-122-582 44',0,12, 2600071)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(16,'�������� �.�.',      97, 76,  '037-931-020 49',0,12, 2600031)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(14,'��������� �.�.',     97, 76,  '131-940-061 26',0,12, 2600216)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(512,'��������� �. �.',   97, 76,  '157-451-673 85',0,12, 2600215)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(35,'������ �. �.',       65, 46,  '037-674-814 89',0,12, 2600012)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(41,'��������� �. �.',    64, 45,  '037-674-818 93',0,13, 2600099)
INSERT INTO @docTab(id,NAME, profil, prvs, snils,det,vidpom,idmis)VALUES(439,'������ �. �.',      64, 45,  '140-173-879 40',0,13, 2600192)

DECLARE @lpu NVARCHAR(6) = '460026'

SELECT 
DISTINCT TOP 1
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
CASE WHEN PATIENTS.SNILS='' THEN NULL ELSE PATIENTS.SNILS END AS SNILS, --����� �������� ��� �������������
NULL OKATOG, --��� ����� ���������� �� �����
NULL OKATOP, --��� ����� ���������� �� �����
-----//����� persan//-----------

--------//������ �������� � ��������//--------
DIPO.SERIQ_POLISA AS DocS1, -- ����� ���������, ��������������� ���� ����������� �� ���
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
doc.vidpom VIDPOM, --��� ����������� ������ ��������� �� ����������� �����
cast(DATA_AMBULAT_PATIENT_COUPON.ED_AIDINGS_FORMS_ID AS INT) FOR_POM, --����� �������� ����������� ������
NULL NPR_MO, --��� ��, ����������� �� ������� (�����������, ������������, ��������������)
NULL NPR_DATE, --���� ����������� �� ������� (�����������, ������������, ��������������)
@lpu LPU, --��� ��
MOTCONSU_EV.DATE_CONSULTATION DATE_Z_1,  MOTCONSU_EV.EV_DATE_CLOSE DATE_Z_2,
NULL KD_Z, --����������������� �������������� (�����-���/��������-���)
NULL VNOV_M, --��� ��� ��������
CAST(ED_TREATMENT_RESULTS.ED_TREATMENT_RESULT_CODE AS INT) RSLT,--��������� ���������
CAST(ED_OUTCOMES.ED_OUTCOMES_CODE AS INT) ISHOD, --����� �����������
NULL OS_SLUCH, --������� ������ ������ ��� ����������� ��������� �� ����������� �������
NULL VB_P, --������� ����������������� ��������

----//������ �������� � ������//----
MOTCONSU.KRN_GUID SL_ID, --������������� ������
CAST(301 AS NVARCHAR(3)) LPU_1, --������������� ��
NULL PODR, --��� ���������
doc.profil PROFIL, --������� ����������� ������
NULL PROFIL_K, --������� �����
doc.det DET, --������� �������� �������
--CASE WHEN ert.ED_RECEPTION_TYPE_CODE = '1'   AND MOTCONSU_EV.DATE_CONSULTATION <= '20190418' THEN '1.0'
--	 WHEN ert.ED_RECEPTION_TYPE_CODE = '1.1' AND MOTCONSU_EV.DATE_CONSULTATION <= '20190418' THEN '2.1'
--	 WHEN ert.ED_RECEPTION_TYPE_CODE = '1.2' AND MOTCONSU_EV.DATE_CONSULTATION <= '20190418' THEN '2.6'
--     WHEN ert.ED_RECEPTION_TYPE_CODE = '1.3' AND MOTCONSU_EV.DATE_CONSULTATION <= '20190418' THEN '1.0'
--     WHEN ert.ED_RECEPTION_TYPE_CODE = '13'  AND MOTCONSU_EV.DATE_CONSULTATION <= '20190418' THEN '1.3'
--     WHEN ert.ED_RECEPTION_TYPE_CODE = '3.0' AND MOTCONSU_EV.DATE_CONSULTATION <= '20190418' THEN '1.0'
--     WHEN ert.ED_RECEPTION_TYPE_CODE = '2.0' AND MOTCONSU_EV.DATE_CONSULTATION <= '20190418' THEN '1.1'
--     WHEN ert.ED_RECEPTION_TYPE_CODE = '2'   AND MOTCONSU_EV.DATE_CONSULTATION <= '20190418' THEN '2.1'
--     ELSE '1.0' END P_CEL,--���� ��������� 
--CASE WHEN SUBSTRING(OMS_CODE,11,1) = '1' THEN '1.0'     
--     WHEN SUBSTRING(OMS_CODE,11,1) = '2' AND MKB.CODE LIKE 'Z%' THEN '2.1' 
--     WHEN SUBSTRING(OMS_CODE,11,1) = '3' THEN '1.1' ELSE '1.0' END P_CEL,--���� ���������

CAST(DATA_AMBULAT_PATIENT_COUPON.DATA164_ID AS VARCHAR(50)) NHISTORY,--����� ������� �������/ ������ ������������� ��������/ ����� ������ ������ ����������� ������
NULL P_PER, --������� �����������/ ��������
FM_BILL.BILL_DATE DATE_1,  FM_BILL.BILL_DATE DATE_2,
NULL KD, --����������������� �������������� (�����-���/��������-���)
MKB1.CODE DS0,
MKB.CODE AS DS1,
NULL DS2, 
CASE WHEN MKB.CODE LIKE 'Z%' THEN NULL ELSE 
	CASE WHEN dd.STATISTIKA = 0 THEN 1  
	     WHEN dd.STATISTIKA = 1 THEN 2
	     WHEN dd.STATISTIKA = 2 THEN 3
	     ELSE 1 END END C_ZAB,--�������� ��������� �����������
CASE WHEN (ert.ED_RECEPTION_TYPE_CODE = '13'  AND MOTCONSU_EV.DATE_CONSULTATION <= '20190418' OR 
           ert.ED_RECEPTION_TYPE_CODE = '1.3' AND MOTCONSU_EV.DATE_CONSULTATION > '20190418')  THEN 
           	CASE WHEN dd.STATISTIKA = 2 THEN  1
           	     WHEN dd.STATISTIKA = 1 THEN  2
           	ELSE 3 END END DN,
NULL CODE_MES1,
NULL CODE_MES2,
NULL KSG_KPG, 
NULL REAB,
doc.prvs PRVS,
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
,doc.NAME
INTO reestrmedialog042019_4

FROM SQL_MIAC.G_EMISZKO_KGB6.dbo.FM_BILL
JOIN SQL_MIAC.G_EMISZKO_KGB6.dbo.FM_BILLDET on FM_BILL.FM_BILL_ID = FM_BILLDET.FM_BILL_ID
LEFT JOIN SQL_MIAC.G_EMISZKO_KGB6.dbo.MEDECINS MEDECINS_SERV on FM_BILLDET.MEDECINS_ID = MEDECINS_SERV.MEDECINS_ID
LEFT JOIN SQL_MIAC.G_EMISZKO_KGB6.dbo.FM_SERV on FM_SERV.FM_SERV_ID = FM_BILLDET.FM_SERV_ID
join SQL_MIAC.G_EMISZKO_KGB6.dbo.MOTCONSU on FM_BILL.MOTCONSU_ID = MOTCONSU.MOTCONSU_ID
join SQL_MIAC.G_EMISZKO_KGB6.dbo.MOTCONSU MOTCONSU_EV on MOTCONSU_EV.MOTCONSU_ID = FM_BILL.MOTCONSU_EV_ID
JOIN SQL_MIAC.G_EMISZKO_KGB6.dbo.DATA_AMBULAT_PATIENT_COUPON ON DATA_AMBULAT_PATIENT_COUPON.MOTCONSU_ID = MOTCONSU_EV.MOTCONSU_ID
LEFT JOIN SQL_MIAC.G_EMISZKO_KGB6.dbo.MEDDEP ON MEDDEP.MEDDEP_ID = ISNULL(DATA_AMBULAT_PATIENT_COUPON.VRACH_OTDELENIE, MOTCONSU_EV.MEDDEP_ID)
JOIN SQL_MIAC.G_EMISZKO_KGB6.dbo.MEDECINS on MEDECINS.MEDECINS_ID = MOTCONSU_EV.MEDECINS_ID
JOIN SQL_MIAC.G_EMISZKO_KGB6.dbo.PATIENTS on PATIENTS.PATIENTS_ID = MOTCONSU.PATIENTS_ID
LEFT JOIN (SELECT * FROM SQL_MIAC.G_EMISZKO_KGB6.dbo.DATA_INS_POLICIES_OMI WITH (NOLOCK) WHERE IS_MAIN = 1 ) DIPO ON DIPO.PATIENTS_ID = PATIENTS.PATIENTS_ID
LEFT JOIN SQL_MIAC.G_EMISZKO_KGB6.dbo.FM_ORG ORG WITH (NOLOCK) ON ORG.FM_ORG_ID = DIPO.SMO
LEFT JOIN SQL_MIAC.G_EMISZKO_KGB6.dbo.DATA_DIAGNOSIS DD on DD.MOTCONSU_ID = MOTCONSU.MOTCONSU_ID AND dd.VID_ZABOLEVANIQ = 0 AND DD.N_LINE = 1
LEFT JOIN SQL_MIAC.G_EMISZKO_KGB6.dbo.CIM10 MKB on MKB.CIM10_ID = DD.SS_LKA_CIM10
LEFT JOIN SQL_MIAC.G_EMISZKO_KGB6.dbo.DATA_DIAGNOSIS DD1 on DD.MOTCONSU_ID = MOTCONSU_EV.MOTCONSU_ID AND dd.VID_ZABOLEVANIQ = 2
LEFT JOIN SQL_MIAC.G_EMISZKO_KGB6.dbo.CIM10 MKB1 on MKB1.CIM10_ID = DD1.SS_LKA_CIM10
LEFT JOIN SQL_MIAC.G_EMISZKO_KGB6.dbo.FM_DEP on FM_DEP.FM_DEP_ID = ISNULL(MEDDEP.FM_DEP_ID, MOTCONSU_EV.FM_DEP_ID)
LEFT JOIN SQL_MIAC.G_EMISZKO_KGB6.dbo.ED_TREATMENT_RESULTS ED_TREATMENT_RESULTS ON ED_TREATMENT_RESULTS.ED_TREATMENT_RESULT_ID = DATA_AMBULAT_PATIENT_COUPON.ED_TREATMENT_RESULT_ID 
LEFT JOIN SQL_MIAC.G_EMISZKO_KGB6.dbo.ED_OUTCOMES ED_OUTCOMES ON ED_OUTCOMES.ED_OUTCOMES_ID = DATA_AMBULAT_PATIENT_COUPON.ED_OUTCOMES_ID
LEFT JOIN SQL_MIAC.G_EMISZKO_KGB6.dbo.ED_RECEPTION_TYPES AS ert ON ert.ED_RECEPTION_TYPE_ID = DATA_AMBULAT_PATIENT_COUPON.VID_PRIEMA
JOIN @docTab doc ON doc.SNILS = MEDECINS.SNILS
WHERE --MOTCONSU_EV.DATE_CONSULTATION >= '2019-03-01' AND MOTCONSU_EV.DATE_CONSULTATION <= '2019-03-31'-- and MOTCONSU_EV.EV_DATE_CLOSE <= '2019-03-31'
FM_BILL.BILL_DATE >='20190401'AND FM_BILL.BILL_DATE <= '20190430'
--AND MEDECINS.MEDECINS_ID IN(2600238)--2600160
AND ISNULL(FM_BILLDET.CANCEL, 0) = 0 and ISNULL(FM_BILLDET.FREE_PAY, 0) = 0 AND FM_BILLDET.DONE = 1 AND isnull(FM_BILLDET.CANCEL, 0) = 0 AND isnull(FM_BILLDET.BLOCKED, 0) != 1
--AND MEDECINS.MEDECINS_ID IN(2600235, 2600071)--2600160
ORDER BY PATIENTS.NOM, PATIENTS.PRENOM, PATIENTS.PATRONYME, MOTCONSU_EV.DATE_CONSULTATION

--ALTER TABLE reestrmedialog042019_1 ALTER COLUMN SL_ID NVARCHAR(36) COLLATE Cyrillic_General_CI_AS NOT NULL;  

