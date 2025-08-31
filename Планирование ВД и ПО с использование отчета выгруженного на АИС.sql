DROP TABLE ztemp_spdu_20052025
SELECT tt.�������, tt.Fam, tt.Im, tt.Ot, tt.dr,
CASE WHEN w = 1 THEN '�������'
    WHEN w = 2 THEN '�������'
    ELSE '���' END [���], tt.[����� ������], tt.���������������, ''[������� � ������], tt.���, tt.DATE_Z_1, tt.DATE_Z_2, tt.DRNAME, t2.DATE_Z_1 DATE_Z_12, t2.DATE_Z_2 DATE_Z_22, t2.DRNAME DRNAME2
  ,t.tel tel, addr
INTO ztemp_spdu_20052025
FROM (


SELECT dl.TargetQuarter [�������], dl.Fam, dl.Im, dl.Ot, 
CAST(dl.Dr AS DATE)dr, 
dl.ENP[����� ������],
[���������������], 
CASE WHEN dl.DispType ='��4' THEN '��4 ������ ���� ��������������� ������������ ����� ��������� ���������'
  WHEN dl.DispType ='���' THEN '��� ���������������� ����������� ������� ��������� ���������'
  WHEN dl.DispType ='��1' THEN '��1 ������ ���� ����������� ��������������� ������������ ����� ��������� ���������'
  WHEN dl.DispType ='��1_�' THEN '������������� �������'
  WHEN dl.DispType ='��1_�' THEN '������������� �������'
  ELSE '��� � �����������' END [���],
  DATE_Z_1, DATE_Z_2,[DRNAME], w,
  

ISNULL(dl.AdrOmsRn, '-') + ' ' + isnull(dl.AdrOmsNaspunkt, '-') + ' ' + isnull(dl.AdrOmsUl, '-') + ' ' + ISNULL(dl.AdrOmsDom, '-') + ' ' + isnull(dl.AdrOmsKorp, '-')  + ' ' + isnull(dl.AdrOmsKv, '-') addr
FROM [elmed].[dbo].[������ ��������������� ��� �� (�� ��������� ����)_20-���-2025 16-36-13] dl

LEFT JOIN [test].[dbo].[prikrep_29102021] p on dl.fam=p.[�������] and im=p.[���] and ot=p.[��������] and dr=p.[���� ��������]

LEFT JOIN (
SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2,v017.[DRNAME]
FROM D3_PACIENT_OMS AS dpo
	JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
		JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
			JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
				left join v017 on v017.IDDR=dzo.RSLT_D  
WHERE dso2.[YEAR] = 2025 AND dzo.OS_SLUCH_REGION IN(47, 49) AND dso2.NSCHET not LIKE '%������%' 
GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2,v017.[DRNAME]
  
) AS t2 ON dl.fam=t2.FAM and dl.im=t2.IM and dl.ot=t2.OT and dl.dr=t2.DR


WHERE dl.DispType !='��1_�' AND dl.DispType !='��1_�'

)  as tt

LEFT JOIN (
SELECT dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2,v017.[DRNAME]
FROM D3_PACIENT_OMS AS dpo
JOIN D3_ZSL_OMS AS dzo ON dzo.D3_PID = dpo.ID
JOIN D3_SL_OMS AS dso ON dso.D3_ZSLID = dzo.ID
JOIN D3_SCHET_OMS AS dso2 ON dso2.ID = dzo.D3_SCID
left join v017 on v017.IDDR=dzo.RSLT_D  
WHERE dso2.[YEAR] = 2025 AND dzo.OS_SLUCH_REGION IN(48) AND dso2.NSCHET not LIKE '%������%'
GROUP BY  dpo.FAM, dpo.IM, dpo.OT, dpo.DR, dzo.DATE_Z_1, dzo.DATE_Z_2,v017.[DRNAME]
  
) AS t2 ON tt.fam=t2.FAM and tt.im=t2.IM and tt.ot=t2.OT and tt.dr=t2.DR
LEFT JOIN [test].[dbo].[Tel] t ON tt.fam=f and tt.im=i and tt.ot=o and tt.dr=d
ORDER BY tt.���������������



SELECT t.*, t2.DS, p.enp
FROM ztemp_spdu_20052025 t
LEFT JOIN (
      SELECT  d.fam, d.Im, d.Ot, d.Dr, dbo.GROUP_CONCAT_DS(DISTINCT D.��_���10_��� , N' , ', 1) DS
        
      FROM du AS d 
        
      WHERE d .��_��������� IS null 
        
GROUP BY d.Fam, d.Im, d.Ot, d.Dr) AS t2 ON t2.Fam = t.fam AND t2.Im = t.im AND t2.Ot = t.ot AND t2.Dr = t.dr
LEFT JOIN Prikrep AS p ON p.������� = t.fam AND p.��� = t.im AND p.�������� = t.ot AND p.����_�������� = t.dr
WHERE t.[���������������] is not NULL