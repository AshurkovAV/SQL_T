SELECT resource_general_id, slot_ordinal, slot_start_time, slot_end_time, COUNT(*)
  FROM [san_administration].[dbo].places_slots
  where active = 1
GROUP BY resource_general_id, slot_ordinal,  slot_start_time, slot_end_time
HAVING COUNT(*) > 1

SELECT *
  FROM [san_administration].[dbo].places_slots
  
  
  
  DELETE FROM places_slots
DELETE FROM employees_slots