SELECT *
FROM F003 AS f
WHERE f.nam_mok LIKE '%каст%'
--жел
--льг
--окт
--каст

DECLARE @t NVARCHAR(25) = '460035'

SELECT t1.[тип заболенваия], SUM(kol) kol
FROM (
		SELECT
			'Сахарный диабет 2-го типа (E11 AND E11.9)' As [тип заболенваия],
			1 kol
		FROM [1]
		WHERE CODE_LPU IN (@t)
		AND REMOVE_DATE IS NULL
		AND MKB BETWEEN 'E11' AND 'E11.9'		
		GROUP BY SURNAME, FIRSTNAME, LASTNAME, BIRTHDATE) AS t1
GROUP BY t1.[тип заболенваия]
UNION ALL
SELECT t1.[тип заболенваия], SUM(kol) kol
FROM (
		SELECT
			'Артериальная гипертензия (I10 AND I11.9)' As [тип заболенваия],
			1 kol
		FROM [1]
		WHERE CODE_LPU IN (@t)
		AND REMOVE_DATE IS NULL
		AND MKB BETWEEN 'I10' AND 'I11.9'		
		GROUP BY SURNAME, FIRSTNAME, LASTNAME, BIRTHDATE) AS t1
GROUP BY t1.[тип заболенваия]
UNION ALL
SELECT t1.[тип заболенваия], SUM(kol) kol
FROM (
		SELECT
			'ИБС (I20 AND I26.9)' As [тип заболенваия],
			1 kol
		FROM [1]
		WHERE CODE_LPU IN (@t)
		AND REMOVE_DATE IS NULL
		AND MKB BETWEEN 'I20' AND 'I26.9' 
		GROUP BY SURNAME, FIRSTNAME, LASTNAME, BIRTHDATE) AS t1
GROUP BY t1.[тип заболенваия]
UNION ALL
SELECT t1.[тип заболенваия], SUM(kol) kol
FROM (
		SELECT
			'Всего пациентов' As [тип заболенваия],
			1 kol
		FROM [1]
		WHERE CODE_LPU IN (@t)
		AND REMOVE_DATE IS NULL		 
		GROUP BY SURNAME, FIRSTNAME, LASTNAME, BIRTHDATE) AS t1
GROUP BY t1.[тип заболенваия]
UNION ALL
SELECT t1.[тип заболенваия], SUM(kol) kol
FROM (
		SELECT
			'Всего заболеваний' As [тип заболенваия],
			1 kol
		FROM [1]
		WHERE CODE_LPU IN (@t)
		AND REMOVE_DATE IS NULL		 
		GROUP BY SURNAME, FIRSTNAME, LASTNAME, BIRTHDATE, MKB) AS t1
GROUP BY t1.[тип заболенваия]


