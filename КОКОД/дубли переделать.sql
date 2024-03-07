--*
--������, 30.05.2019
--update, kat, 26.06.2019
--������� � ���� ��, ��� ����������� ������������� �����
--������������ ������� �������� ���.������ � ����� ������� (KOKOD, ���, ����� ����)
declare @p1 int =160
  
select 
  ID, SUMV, '' com
  --,month, year, lpu, d3_scid, id, fam, im, ot, dr,os_sluch_region,IDDOKT, ct, z.DATE_2
from(
  select 
    distinct *
    ,count(id)over(PARTITION BY FAM, IM, OT, dr, DATE_2, PROFIL, lpu,IDDOKT) ct --���������� ����� ��������� �� 1 ���� � ������ ��������
  from(
    select 
      distinct
      zs.ID, zs.SUMV, pa.FAM, pa.IM, pa.OT, dr, sl.DATE_2 
      ,sc.MONTH, sc.YEAR, sl.DS1, zs.USL_OK, sl.PROFIL, sl.P_CEL25, zs.D3_SCID, zs.LPU, pa.smo--, mek_coment
      ,zs.os_sluch_region,sl.IDDOKT --9999 ��� ��� ��������
    from 
      D3_ZSL_OMS zs
        join D3_SCHET_OMS sc on sc.id=zs.D3_SCID
                  and zs.lpu in (460003,460010,460061,460039)
                 and zs.os_sluch_region IS NULL
                 --AND ISNULL(zs.MEK_COUNT,0)=0
                 and d3_scid=@p1 
        join D3_SL_OMS sl on sl.d3_zslid=zs.id AND sl.lpu_1<>302
        join D3_PACIENT_OMS pa on pa.ID = zs.D3_PID
    where 
      zs.usl_ok=3
    )z
  )z
where
	ct>=2
	--and d3_scid=@p1 
	--AND z.[YEAR]=2019
group by
	ID, SUMV  
 -- order by fam, im, ot

 union
 -------------------
 select 
  ID, SUMV, '' com
  --,month, year, lpu, d3_scid, id, fam, im, ot, dr,os_sluch_region,IDDOKT, ct, z.DATE_2
from(
  select 
    distinct *
    ,count(id)over(PARTITION BY spolis, npolis, DATE_2, PROFIL, lpu,IDDOKT) ct --���������� ����� ��������� �� 1 ���� � ������ ��������
  from(
    select 
      distinct
      zs.ID, zs.SUMV, pa.spolis, pa.npolis, sl.DATE_2 
      ,sc.MONTH, sc.YEAR, sl.DS1, zs.USL_OK, sl.PROFIL, sl.P_CEL25, zs.D3_SCID, zs.LPU, pa.smo--, mek_coment
      ,zs.os_sluch_region,sl.IDDOKT --9999 ��� ��� ��������
    from 
      D3_ZSL_OMS zs
        join D3_SCHET_OMS sc on sc.id=zs.D3_SCID
                  and zs.lpu in (460003,460010,460061,460039)
                 and zs.os_sluch_region IS NULL
                 --AND ISNULL(zs.MEK_COUNT,0)=0
                 and d3_scid=@p1 
        join D3_SL_OMS sl on sl.d3_zslid=zs.id AND sl.lpu_1<>302
        join D3_PACIENT_OMS pa on pa.ID = zs.D3_PID
    where 
      zs.usl_ok=3
    )z
  )z
where
	ct>=2
	--and d3_scid=@p1 
	--AND z.[YEAR]=2019
group by
	ID, SUMV  
 -- order by fam, im, ot