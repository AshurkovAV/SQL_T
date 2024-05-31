DROP TABLE dbo._N3_spr64_OTDEL
  GO

select --top 100 
--n3_mo.[organization-alias], -- �������������� ����� ���������
lower(case WHEN isnull(spr64.[���], '') = '' then LOWER(newid()) ELSE spr64.[���] END) 'id',  --��������� GUID ���� ��� ��� ��� ������
--spr64.[���], -- �������������� ����� ���������
mo.hospital_name + ', ' + isnull(n3_mo.[organization-alias], '') 'name', --��������� �������� ��� ������������ �� + ������������ �����������
mo.hospital_name + ', ' + isnull(n3_mo.[organization-alias], '') 'organization-alias', --��������� �������� ��� ������������ �� + �������������� ������������ �����������
mo.oid 'depart_oid', -- ��� �������� �� �����������
n3_mo.orgid 'partOf', -- ��� �������� �� �����������
n3_mo.orgid 'orgid', -- ��� �������� ����� [���], ��� ����������� ������� ������ �� ��� ��������, �������� ����� ������

(isnull(mo.building_address_post_index, '') +    CASE WHEN isnull(mo.building_address_post_index, '') = '' THEN '' ELSE ', ' END + 
			isnull(mo.building_address_region_name, '') +   CASE WHEN isnull(mo.building_address_region_name, '') = '' THEN '' ELSE ', ' END + 
			isnull(mo.building_address_prefix_area, '') +   CASE WHEN isnull(mo.building_address_prefix_area, '') = '' THEN '' ELSE '. ' END + 
			isnull(mo.building_address_area_name, '') +     CASE WHEN isnull(mo.building_address_area_name, '') = '' THEN '' ELSE ', ' END + 
			isnull(mo.building_address_prefix_street, '') + CASE WHEN isnull(mo.building_address_prefix_street, '') = '' THEN '' ELSE '. ' END + 
			isnull(mo.building_address_street_name, '') +   CASE WHEN isnull(mo.building_address_street_name, '') = '' THEN '' ELSE ', ' END +
			isnull(mo.building_address_house, '')) AS 'Address', -- �������� ����� �� ����������� ��
'' 'url',
CASE WHEN ISNULL(spr64.phone, '') != '' THEN spr64.phone ELSE '' END 'phone', --���� �������� ���� � ����������� 64, �� �������� ���
n3_mo.ogrn 'ogrn',
case when n3_mo.active = 'false' THEN 'false' ELSE CASE WHEN isnull(mo.depart_liquidation_date, '') != '' THEN 'false' ELSE 'true' END END AS 'active', --���� �������� ����������� ���������� ��������, �� ����������� ���� �� �� ����� �� ������. ���� �� ���������� �������� - ���� ������ false. �� ��������� true
CASE WHEN mo.depart_type_id = 1 THEN 40  
  WHEN mo.depart_type_id = 2 THEN 2
  WHEN mo.depart_type_id = 3 THEN 158
  WHEN mo.depart_type_id = 4 THEN 71
  WHEN mo.depart_type_id = 5 THEN 74
  ELSE n3_mo.medorgtype END AS 'medorgtype' -- ����� ������ ����� �� ��� ��� � �������� ��


INTO _N3_spr64_OTDEL

from [1.2.643.5.1.13.13.99.2.115] mo

left join [64_���������� ��_������] spr64 on mo.oid = spr64.[OID ������������ ������������� (����)]
left join _N3_spr64_MO n3_mo on n3_mo.oid = mo.mo_oid

where mo.oid like '1.2.643.5.1.13.13.12.2.46.4342.0.404037.678439' --�������� ������� �������

--and mo.mo_oid not like '1.2.643.5.1.13.13.12.2.46.15935' 
ORDER BY spr64.[organization-alias]
  GO

SELECT * FROM _N3_spr64_OTDEL