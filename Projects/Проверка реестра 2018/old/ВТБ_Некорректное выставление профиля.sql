------------��������� ��������(��� 68) ���������� <���=18���, ����� ��� 5.1.4. ���������� ����������, ��� ���.

SELECT zsl.ID, 
pa.FAM,PA.im,pa.ot,zsl.date_z_1,zsl.DATE_Z_2,
zsl.SUMV, '������������ ����������� �������' com
FROM D3_ZSL_OMS zsl
join D3_SL_OMS sl on sl.d3_zslid=zsl.id
JOIN D3_PACIENT_OMS pa on zsl.D3_PID = pa.ID
where zsl.D3_SCID = 2077 AND datediff(DAY, pa.DR, sl.DATE_2)/365.2524 >= 18 AND sl.PROFIL = 68
--group by zsl.ID, zsl.SUMV