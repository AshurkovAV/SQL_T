--����
declare @p1 int =22360
--����� �������� �� �� ������������� ����� 99 99 (�� ����������� ��� F011)
update zs set EXP_COMENT = null
FROM D3_SCHET_OMS sch
		 join D3_PACIENT_OMS p on sch.id=p.[D3_SCID]
		  join D3_ZSL_OMS zs on p.id=zs.D3_PID 								
									AND sch.id=@p1
									AND zs.EXP_COMENT like '%����� ��� ����� ������������� � �������� �� ������������� ����� �� ����������� ��� F011%'
									