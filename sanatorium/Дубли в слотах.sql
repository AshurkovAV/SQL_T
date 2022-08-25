SELECT resource_general_id, slot_ordinal, slot_start_time, slot_end_time, COUNT(*)
  FROM [san_administration].[dbo].places_slots
  where active = 1
GROUP BY resource_general_id, slot_ordinal,  slot_start_time, slot_end_time
HAVING COUNT(*) > 1


SELECT resource_general_id, slot_ordinal, slot_start_time, slot_end_time, COUNT(*)
  FROM [san_administration].[dbo].[employees_slots]
  where active = 1
GROUP BY resource_general_id, slot_ordinal,  slot_start_time, slot_end_time
HAVING COUNT(*) > 1