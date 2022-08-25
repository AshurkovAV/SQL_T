DELETE FROM services_employees_demands
WHERE resource_general_id IN (
								SELECT egl.id
								FROM employees_general_list AS egl
								WHERE active = 0)

DELETE FROM services_employees_demands
WHERE active = 0

DELETE FROM services_places_demands
WHERE resource_general_id IN (
								SELECT egl.id
								FROM places_general_list AS egl
								WHERE active = 0)

DELETE FROM services_places_demands
WHERE active = 0

DELETE FROM employees_bindings
WHERE employee_general_id IN (
								SELECT id
								FROM employees_general_list
								WHERE active = 0)
DELETE FROM employees_bindings
WHERE employee_id IN (
						SELECT id
						FROM employees AS e
						WHERE active = 0)

DELETE FROM employees_general_list
WHERE active = 0

DELETE FROM employees
WHERE [active] = 0


DELETE FROM services_places_demands 
WHERE service_id IN (SELECT id FROM services_list AS sl WHERE sl.[active] = 0)

DELETE FROM services_employees_demands
WHERE service_id IN (SELECT id FROM services_list AS sl WHERE sl.[active] = 0)

DELETE FROM services_places_demands 
FROM services_places_demands pgl
LEFT JOIN services_list AS sl ON pgl.service_id = sl.id
WHERE sl.id is null

DELETE FROM services_employees_demands 
FROM services_places_demands pgl
LEFT JOIN services_list AS sl ON pgl.service_id = sl.id
WHERE sl.id is null


DELETE FROM places_bindings
WHERE place_general_id IN (
							SELECT id
							FROM places_general_list AS pgl WHERE pgl.[active] = 0)
DELETE FROM places_bindings
WHERE place_id IN (
					SELECT id
					FROM places AS p WHERE p.[active] = 0)

DELETE FROM places_general_list
WHERE active = 0

DELETE FROM places
WHERE [active] = 0

--SELECT *
--FROM programs_services_struct
--WHERE service_id IN (SELECT id FROM [services_list]
--WHERE active = 0)

DELETE FROM [services_list]
WHERE active = 0

