DECLARE @p1 INT = 9382
--��� ���� � ������ �������� ��������� � ����� �������� ��� ���������
select  s.profil, s.P_CEL25, isnull(p.npolis, p.ENP) npolis, ds1,s.IDDOKT--,COUNT(*)
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
 --  and sch.year=2022 and sch.month=12 AND sch.CODE_MO = 460010
 AND sch.id = @p1
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id    --and zs.usl_ok in (1,2) 
 -- AND zs.id in (1889455, 1887726)
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID AND s.P_CEL25= '1.3' 
WHERE isnull(p.npolis, p.ENP) IN 
(
SELECT isnull(p.npolis, p.ENP)
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
 --  and sch.year=2022 and sch.month=12 AND sch.CODE_MO = 460010
 AND sch.id = @p1
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id    --and zs.usl_ok in (1,2) 
 -- AND zs.id in (1889455, 1887726)
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID AND s.P_CEL25= '1.3' 
--WHERE p.npolis LIKE '4647520890000233'
GROUP BY   isnull(p.npolis, p.ENP)
HAVING COUNT(*) > 1

)



--������� ���, � ���� ������ 1 ������ ���� � ����� ��������� � ��������, �� ���� ����� 1 ������ ���� �� 1.0
SELECT * FROM
(
SELECT 
distinct  ROW_NUMBER() OVER(PARTITION BY p.fam,p.im,isnull(p.ot,''),p.dr, s.PROFIL, s.ds1 order BY p.fam,p.im,isnull(p.ot,''),p.dr, s.PROFIL, s.ds1) 
    n_p_p,
    sch.id, zs.id zslid,p.id as pid, s.id slid, s.nhistory, p.npolis,  p.fam,p.im,isnull(p.ot,'') ot,p.dr,zs.D3_SCID AS zs_schid,p.D3_SCID AS p_schid, s.ds1
--INTO temp_disp_1_3
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
 -- and sch.year=2022 and sch.month=12 and sch.CODE_MO = 460010
 AND sch.id = @p1
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id --and zs.usl_ok in (1,2) 
  --AND zs.id in (1889455, 1887726)
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID AND s.P_CEL25 = '1.3' 
JOIN(--���������� �� �������, ��������, � ���� ���� ����� 1 ������ � ����� ���� ���������� � ���
select  s.profil, s.P_CEL25, isnull(p.npolis, p.ENP) npolis, ds1
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
 --  and sch.year=2022 and sch.month=12 AND sch.CODE_MO = 460010
 AND sch.id = @p1
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id    --and zs.usl_ok in (1,2) 
  --AND zs.id in (1889455, 1887726)
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID AND s.P_CEL25= '1.3' 

GROUP BY  s.profil, s.P_CEL25, isnull(p.npolis, p.ENP), ds1
HAVING COUNT(*) > 1
) t ON t.npolis=isnull(p.NPOLIS, p.enp) AND s.ds1=t.ds1

)tt
ORDER BY  tt.fam,tt.im,tt.ot,tt.dr,tt. n_p_p



--SELECT * FROM temp_disp_1_3_9382


--�������� ����, � ���� ���� ���� ����������
select  s.profil, s.P_CEL25, isnull(p.npolis, p.ENP) npolis, OS_SLUCH_REGION, idsp , zs.id

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id AND sch.id=9382
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id    --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID  AND s.P_CEL25= '1.3' 
 
 
 --UPDATE 
 SELECT  s.profil, s.P_CEL25, isnull(p.npolis, p.ENP) npolis, OS_SLUCH_REGION, idsp , zs.id, usl.ID, usl.KOL_USL,usl.CODE_USL
 FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id AND sch.id=9382
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id    --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID  AND s.P_CEL25= '1.3' 
 JOIN D3_USL_OMS AS usl ON usl.D3_SLID=s.ID
 WHERE s.id IN(
 select DISTINCT s.id

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id AND sch.id=9382
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id    --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID  AND s.P_CEL25= '1.3' 
 JOIN D3_USL_OMS AS usl ON usl.D3_SLID=s.ID
 WHERE usl.KOL_USL IS NOT NULL AND usl.CODE_USL NOT LIKE 'B04.027.001')
 
 
 --BEGIN TRAN --commit tran
 --DELETE FROM USL
 
 --FROM [D3_SCHET_OMS] sch                  
 -- inner join D3_PACIENT_OMS p on p.d3_scid=sch.id AND sch.id=9382
 -- inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id    --and zs.usl_ok in (1,2) --AND zs.id=20906231
 --join D3_SL_OMS s on s.D3_ZSLID=zs.ID  AND s.P_CEL25= '1.3' 
 --JOIN D3_USL_OMS AS usl ON usl.D3_SLID=s.ID
 --WHERE usl.KOL_USL IS NOT NULL AND usl.CODE_USL NOT LIKE 'B04.027.001'
 
 --������!!!
  --UPDATE usl set usl.KOL_USL=1
  --UPDATE zs SET zs.sumv=900.96
-- UPDATE s SET s.tarif=900.96, s.sum_m=900.96
 SELECT zs.sumv, s.tarif, s.SUM_M, s.profil, s.P_CEL25, isnull(p.npolis, p.ENP) npolis, OS_SLUCH_REGION, idsp , zs.id, s.prvs--, usl.ID, usl.KOL_USL,usl.CODE_USL

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id AND sch.id=9382
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id    --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID  AND s.P_CEL25= '1.3' 
 --JOIN D3_USL_OMS AS usl ON usl.D3_SLID=s.ID
-- WHERE usl.KOL_USL IS  NULL
 --WHERE profil=162
 ORDER BY s.profil
 
 
 --60--1268.6
 --108--84 ����--935.47
 --162--45 ����--900.96
 --UPDATE onk SET onk.DS1_T=3
  SELECT zs.sumv, s.tarif, s.SUM_M, s.profil, s.P_CEL25, isnull(p.npolis, p.ENP) npolis, OS_SLUCH_REGION, idsp , zs.id, ds1, onk.stad, onk.DS1_T--, s.prvs, usl.ID, usl.KOL_USL,usl.CODE_USL

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id AND sch.id=9382
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id    --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID  AND s.P_CEL25= '1.0' 
 JOIN D3_ONK_SL_OMS onk ON onk.D3_SLID=s.id
 --JOIN D3_USL_OMS AS usl ON usl.D3_SLID=s.ID
-- WHERE usl.KOL_USL IS  NULL
 --WHERE onk.DS1_T=4
 ORDER BY s.profil
 
 
 
 --�������� LPU � ���
-- UPDATE usl SET usl.lpu='460061'
  SELECT zs.sumv, s.tarif, s.SUM_M, s.profil, s.P_CEL25, isnull(p.npolis, p.ENP) npolis, OS_SLUCH_REGION, idsp , zs.id, ds1, s.prvs, usl.ID, usl.KOL_USL,usl.CODE_USL, usl.lpu--, ds1, ds_onk

FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id AND sch.id=9382
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id    --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID -- AND s.P_CEL25= '1.3' 
 --left JOIN D3_ONK_SL_OMS onk ON onk.D3_SLID=s.id
 JOIN D3_USL_OMS AS usl ON usl.D3_SLID=s.ID
 WHERE usl.LPU IS   NULL
 --WHERE onk.DS1_T=4
  --WHERE onk.id IS null
 ORDER BY s.profil