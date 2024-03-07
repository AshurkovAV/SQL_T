/*SELECT DISTINCT  f003.nam_mok, npolis, sch.id AS schid_old,usl.CODE_USL,zs.id AS zslid,p.ID AS pid,p.fam,p.im,p.ot,p.dr, usl.VID_VMe, p.npolis,usl.DATE_IN,usl.DATE_OUT,zs.sumv
--zs.id izslid, s.id slid,p.ID D3_PID
--INTO ztemp_lis_dnr_072022
--sch.id, zs.id, usl.CODE_USL, usl.VID_VME,ms.ishod,zs.ISHOD
FROM [D3_SCHET_OMS] sch                  
  inner join D3_PACIENT_OMS p on p.d3_scid=sch.id 
  and sch.year=2022 and sch.month=9 AND   sch.id   IN (8523)
  inner join D3_ZSL_OMS zs on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id --and zs.usl_ok in (1,2) --AND zs.id=20906231
 join D3_SL_OMS s on s.D3_ZSLID=zs.ID 
 JOIN d3_usl_oms usl ON usl.D3_SLID=s.id
left join Yamed_Spr_UslCode u on u.id=usl.vid_vme
LEFT JOIN f003 ON f003.mcod=zs.NPR_MO
WHERE npolis LIKE '%днр%' OR npolis LIKE '%нет%' OR npolis LIKE ''
ORDER BY fam, im, ot
*/

SELECT DISTINCT  row_number() OVER(ORDER BY name ASC)  AS [id]
				--,f003.nam_mok  
				,CONCAT(p.fam,' ',p.im,' ',p.ot) AS [ФИО]
				,p.dr AS [Дата рождения]
				,npolis AS [Полис]
				,usl.DATE_IN AS [Дата взятия]
				,f003.nam_mok AS [Направившая МО]
				,usl.DATE_IN AS [Дата направления]
				,usl.VID_VME AS [Код услуги]
				,u.name AS [Наименование услуги]
				,usl.CODE_MD AS [СНИЛС врача]

FROM	   [D3_SCHET_OMS] sch                  
inner join D3_PACIENT_OMS p		on p.d3_scid=sch.id 
			and sch.year=2022 and sch.month=9 AND   sch.id   IN (8523)
inner join D3_ZSL_OMS zs		on zs.D3_PID=p.id  and zs.[D3_SCID]=sch.id --and zs.usl_ok in (1,2) --AND zs.id=20906231
join D3_SL_OMS s				on s.D3_ZSLID=zs.ID 
JOIN d3_usl_oms usl				ON usl.D3_SLID=s.id
left join Yamed_Spr_UslCode u	on u.id=usl.vid_vme
LEFT JOIN f003					ON f003.mcod=zs.NPR_MO
WHERE npolis LIKE '%днр%' OR npolis LIKE '%нет%' OR npolis LIKE ''
/*ORDER BY --fam, im, ot
	     CONCAT(p.fam, ' ', p.im, ' ', p.ot)*/

