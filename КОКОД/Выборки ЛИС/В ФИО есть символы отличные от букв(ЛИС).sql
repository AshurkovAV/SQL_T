--� ��� ���� ������� �������� �� ����
Select 
DISTINCT
 sch.id,
 sch.NSchet as [��� �����], zs.NPR_DATE, zs.NPR_MO, f003.nam_mok
,sch.month as [�����]
,sch.YEAR[���]
,case when p.smo like '46%' then p.smo else '46' end as [����������]   
, p.SMO as [��������� ��������]
,p.VPOLIS, p.SPOLIS, p.NPOLIS, p.enp, p.SMO
,p.fam,p.im,isnull(p.ot,'') 
,p.W as [���]
       --,tmp1.enp, tmp1.smo, tmp1.[��������], tmp1.[�������], tmp1.[���]
 ,p.DR as [���� ��������]
 , p.NPOLIS as [�����]
 , p.SNILS as [�����]
 , zs.DATE_Z_1 [���� ������]
 , zs.DATE_Z_2 [���� ���������]
 , zs.VIDPOM as [��� ������]
 , zs.USL_OK as [������� �������� ���. ������],

 p.fam,  zs.DATE_Z_1 [���� ������]
 , zs.DATE_Z_2 [���� ���������],
 zs.id, zs.SUMV as [��������� ��������� ���. ������]
 ,zs.RSLT AS [���������]
 ,zs.ISHOD
 ,s.iddokt, u.CODE_MD
 ,zs.ishod
 ,u.id
 ,u.code_usl
 ,u.VID_VME
 ,y.name

 ,zs.OPLATA, zs.SUMV, zs.SUMP
 ,p.DOCTYPE, p.DOCSER, p.DOCNUM, p.OKATOG, p.OKATOP, p.DOCDATE, p.DOCORG
 ,p.VPOLIS 
 ,p.ID
 ,zs.OS_SLUCH
 ,p.DOCTYPE, p.DOCSER, p.DOCNUM, p.DOCDATE, p.DOCORG
 
 --,zs.EXP_COMENT
 --,tmp1.enp, tmp1.smo, tmp1.[��������], tmp1.[�������], tmp1.[���]
 --,tmp2.NPOLIS, tmp2.smo, tmp2.[��������], tmp2.�������
--*/
FROM [D3_SCHET_OMS] sch                  
 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
											AND sch.YEAR=2023 
											and sch.id in (10759)
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN D3_USL_OMS u ON u.D3_SLID=s.id
 join V009 rz on rz.IDRMP=zs.RSLT
 left join F011 doc on doc.Id=p.DOCTYPE
 LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
 LEFT  JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
 left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	

WHERE p.fam LIKE '%[^�-��-�]%'
  or p.im LIKE '%[^�-��-�]%'
  or p.ot LIKE '%[^�-��-�]%'
  OR p.im LIKE '%���� ��������:%'