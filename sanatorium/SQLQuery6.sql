SELECT egl.egl_name, eb.employee_general_id, sed.service_id, sed.resource_iteration_level, sed.alt_group_id,
COUNT(*) [количество слотов]

--es.slot_start_time, es.slot_end_time, es.duration_min, es.order_id, es.customer_id, 
--, sl.svc_duration_slots
FROM employees_general_list AS egl
JOIN employees_bindings AS eb ON eb.employee_general_id = egl.id AND eb.[active] = 1
JOIN services_employees_demands AS sed ON sed.resource_general_id = egl.id AND sed.[active] = 1
LEFT JOIN employees_slots AS es ON es.resource_general_id = egl.id
--JOIN services_list AS sl ON sl.id = sed.service_id
WHERE sed.service_id = 802 AND es.is_busy = 0

GROUP BY egl.egl_name, eb.employee_general_id, sed.service_id, sed.resource_iteration_level, sed.alt_group_id



SELECT pgl.pgl_name, ps.resource_general_id, spd.service_id, spd.alt_group_id,
COUNT(*) [количество слотов]

--es.slot_start_time, es.slot_end_time, es.duration_min, es.order_id, es.customer_id, 
--, sl.svc_duration_slots
FROM places_general_list AS pgl
JOIN places_bindings AS pb ON pb.place_general_id = pgl.id AND pb.[active] = 1
JOIN services_places_demands AS spd ON spd.resource_general_id = pgl.id AND spd.[active] = 1
LEFT JOIN places_slots AS ps ON ps.resource_general_id = pgl.id
--JOIN services_list AS sl ON sl.id = sed.service_id
WHERE spd.service_id = 802

GROUP BY pgl.pgl_name, ps.resource_general_id, spd.service_id, spd.alt_group_id


SELECT *
FROM services_list AS sl

SELECT *
FROM services_employees_demands AS sed
WHERE sed.service_id = 107

SELECT *
FROM services_places_demands AS spd
WHERE spd.service_id = 2062

SELECT *
FROM employees_general_list AS egl
JOIN employees_slots AS es ON es.resource_general_id = egl.id
WHERE egl.id IN (418,461 )