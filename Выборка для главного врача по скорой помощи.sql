SELECT replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace([��], ' - ��.13', ''), ' - ��.1', ''), ' - ��.3', ''), ' - ��.4', ''), ' - ��.29', ''), ' - ��.27', '')
, ' - ��.9', ''), ' - ��.6', ''), ' - ��.20', '')
, ' - ��.23', ''), ' - ��.28', ''), ' - ��.8', '')
, ' - ��.25', ''), ' - ��.6', ''), ' - ��.5', '')
, ' - ��.7', ''), ' - ��.21', ''), ' - ��.22', '')
, ' - ��.26', ''), ' - ��.2', ''), ' - ��.24', '')
, '�1', '�'), '�2', '�'), '�3', '�'), '�4', '�'), '�5', '�'), '�6', '�'), '�7', '�'), '�8', '�'), '�9', '�'), '�0', '�'), [�������], COUNT(*)kol, 1 as k,
CASE WHEN COUNT(*) <10 THEN '�� 10'
	 WHEN COUNT(*) >= 10 AND  COUNT(*) < 20 THEN 'C 10 �� 20'
	 WHEN COUNT(*) >= 20 AND  COUNT(*) < 30 THEN 'C 20 �� 30'
	 WHEN COUNT(*) >= 30 AND  COUNT(*) < 40 THEN 'C 30 �� 40'
	 WHEN COUNT(*) >= 40 AND  COUNT(*) < 50 THEN 'C 40 �� 50'
	 WHEN COUNT(*) >= 50 THEN '50 � �����'
	 ELSE cast(COUNT(*) AS NVARCHAR(10))  END 

FROM [15112022chast_call_polik]
GROUP BY  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace([��], ' - ��.13', ''), ' - ��.1', ''), ' - ��.3', ''), ' - ��.4', ''), ' - ��.29', ''), ' - ��.27', '')
, ' - ��.9', ''), ' - ��.6', ''), ' - ��.20', '')
, ' - ��.23', ''), ' - ��.28', ''), ' - ��.8', '')
, ' - ��.25', ''), ' - ��.6', ''), ' - ��.5', '')
, ' - ��.7', ''), ' - ��.21', ''), ' - ��.22', '')
, ' - ��.26', ''), ' - ��.2', ''), ' - ��.24', '')
, '�1', '�'), '�2', '�'), '�3', '�'), '�4', '�'), '�5', '�'), '�6', '�'), '�7', '�'), '�8', '�'), '�9', '�'), '�0', '�'), [�������]

--SELECT *
--FROM [15112022chast_call_polik]