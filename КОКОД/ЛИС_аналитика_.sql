SELECT distinct t.MONTH
	,t.nam_mok,
    t.code_usl
	,t.ms_name
	 ,t.VID_VME
	 , y_name
	 ,count (distinct id) [���-�� ��� ������� �������� �� �����]
	 ,sum(case when idsp in (35,36) and pr_nov=0 then 0 else sumv end) [������ �� �����]
	 ,count (distinct  case when sank is not null then id end) [����� �� ���],		
sum(case when sank is not null then sumv end) [����� �� ��� �� �����],		
count(distinct  case when sank is null then id end) [���-�� ���������� ��� �������], 		
sum(case when sank is null then case when idsp in (35,36) and pr_nov=0 then 0 else sumv end end) [�������� �� �����]		
,count (distinct  case when s_osn in ('1.6.2.') then id end ) [����� �� ������� � 10 ������]		
--,count (distinct case when sank.s_osn in ('5.3.2.','1.6.2.') then zs.id end ) [����� �� �������]		
,isnull(sum (case when  s_osn in ('1.6.2.')  then sumv end),0) [����� �� ������� �� ����� � 10 ��� ]					 
FROM 
	(Select distinct
		sch.NSchet as [��� �����], zs.NPR_DATE, zs.NPR_MO, f003.nam_mok
	    ,sch.month	--as [�����]
		,sch.YEAR[���]
		,case when p.smo like '46%' then p.smo else '46' end as [����������]   
		, p.fam, p.im, isnull(p.ot,'') AS ot
		,p.W as [���]
		,p.DR as [���� ��������]
		, p.NPOLIS as [�����]
		, p.SNILS as [�����]
		, zs.DATE_Z_1 [���� ������]
		, zs.DATE_Z_2 [���� ���������]
		,zs.id
		,zs.IDSP
		,zs.PR_NOV
		, zs.SUMV as [��������� ��������� ���. ������]
		, s.iddokt  
		,u.code_usl
		,sank.id sank, sank.s_osn s_osn  --, v.UMPNAME
	,ms.name AS ms_name 
		,u.VID_VME
		, y.name AS y_name
		,zs.OPLATA, zs.SUMV, zs.SUMP
	  ,	replace(replace(zs.EXP_COMENT, CHAR(10), ''), CHAR(13), '') [����������� ���]

	FROM [D3_SCHET_OMS] sch                  
	 inner join D3_PACIENT_OMS p on p.d3_scid=sch.id
	 inner join D3_ZSL_OMS zs on zs.D3_PID=p.id AND sch.code_mo=460061 
	 --AND sch.month=11
	 AND sch.YEAR=2022  
	--and sch.id IN (9063, 8867, 8643, 8453, 8225, 8109, 6907, 5627)	/*���*/   --(SELECT  * FROM D3_SCHET_OMS AS sch where sch.year=2022 and sch.NSCHET LIKE '%���%')
	AND sch.id IN (4375, 5379, 5596, 5602, 5595, 6855, 6856, 7074, 7075, 7076, 8222, 8235, 8236, 8446, 8470, 8501, 8587, 8667, 8685, 8727, 8866, 8913, 8916, 9025, 9068)  /*��� �� ��������*/
	join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
	  JOIN D3_USL_OMS u ON u.D3_SLID=s.id

  		left join [dbo].[D3_SANK_OMS] sank 		
					on sank.[D3_ZSLID]=zs.id
					and sank.s_tip=1
	join V009 rz on rz.IDRMP=zs.RSLT
	left join F011 doc on doc.Id=p.DOCTYPE
	LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
	left JOIN medicalServices AS ms ON ms.code_usl=u.CODE_USL AND u.DATE_IN >=ms.dataBegin AND u.DATE_OUT<=ISNULL(ms.dataEnd,'20991231') AND ms.code_usl  BETWEEN 'R01.001.008' AND 'R01.001.036'
	left join Yamed_Spr_UslCode y on y.ID=u.vid_vme	
	INNER JOIN tmp_redkie tr ON tr.code = u.VID_VME   /*������*/
	--INNER JOIN tmp_rutina tr ON tr.code = u.VID_VME   /*������*/
	--INNER JOIN tmp_uniq tr ON tr.code = u.VID_VME     /*����������*/
	WHERE   sank.id is null	
	AND u.VID_VME = 'A09.05.009'
	AND u.DATE_IN
)t
group by 	t.month	
, t.nam_mok													
,t.code_usl
,t.ms_name
 ,t.VID_VME
 , y_name
ORDER BY  t.nam_mok	
		,t.VID_VME