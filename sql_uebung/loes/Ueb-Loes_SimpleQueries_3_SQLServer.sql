-- Übung 3: Verwendung von Funktionen  -  Lösungen 

-- 1.	Zeigen Sie für jeden Mitarbeiter die Mitarbeiternummer, den Nachnamen, das Gehalt und das Gehalt mit 15% Zuwachs, 
-- diesen Wert als Ganzzahl und mit der Überschrift “New Salary”.

SELECT 	employee_id, last_name, salary,
		FLOOR(salary * 1.15)  "New Salary"
FROM	employees;
-- sofern abgeschnitten ok ist

-- oder mit Rundung
SELECT 	employee_id, last_name, salary,
		FLOOR(ROUND(salary * 1.15, 0)) "New Salary"
FROM	employees;
-- analog lässt sich statt FLOOR auch CEIL verwenden 
-- ROUND eliminiert nicht die Nachkommastellen bei SQL Server

SELECT 	employee_id, last_name, salary,
		FLOOR(salary * 1.15)  "New Salary"
FROM	employees;

-- oder
SELECT 	employee_id, last_name, salary,
		STR(salary * 1.15) "New Salary"
FROM	employees;
-- vorausgesetzt, das Gehalt hat nicht mehr als 10 Stellen vor dem Dezimaltrenner



-- 2.	Verändern Sie die vorhergehende Abfrage so, dass eine zusätzliche Spalte mit dem Bezeichner „Increase“ 
-- angezeigt wird, die das alte vom neuen Gehalt abzieht.

SELECT 	employee_id, last_name, salary,
			FLOOR(ROUND(salary * 1.15, 0)) "New Salary",
			FLOOR(ROUND(salary * 1.15, 0) - salary) "Increase"
	FROM	employees;
  
  
-- 3.	Schreiben Sie eine Abfrage, die den Nachnamen des Mitarbeiters, beginnend mit einem Großbuchstaben und den 
-- Rest in Kleinschreibung, und die Länge des Namens anzeigt, für die Mitarbeiter, deren Nachname mit J, A oder M beginnt. 
-- Geben Sie den Spalten entsprechende Bezeichner und sortieren Sie die Ausgabe nach den Namen.

SELECT	UPPER(LEFT(last_name,1))+ LOWER(RIGHT(last_name,LEN(last_name)-1)) AS  "Name",
		LEN(last_name)  AS  "Length"
FROM	employees
WHERE	last_name LIKE 'J%'
			OR	last_name LIKE 'M%'
			OR	last_name LIKE 'A%'
	ORDER BY	last_name;

-- oder

SELECT	UPPER(LEFT(last_name,1))+ LOWER(SUBSTRING(last_name,2,LEN(last_name)-1)) AS  "Name",
		LEN(last_name)  AS  "Length"
FROM	employees
WHERE	SUBSTRING(last_name,1,1) in ('J', 'A', 'M')
	ORDER BY	last_name;

 
-- 4.	Zeigen Sie für alle Mitarbeiter den Nachnamen und die ganzzahlige Anzahl der Monate zwischen dem aktuellen Datum 
--      und dem Einstellungsdatum, sortiert nach der Anzahl Monate. 

SELECT	last_name, DATEDIFF(month, hire_date, getdate()) MONTHSWORK
FROM	employees
ORDER BY	MONTHSWORK;


-- 5.	Schreiben Sie eine Abfrage um den Nachnamen und das Gehalt aller Mitarbeiter anzuzeigen. 
-- Formatieren Sie die Ausgabe des Gehalts auf 15 Stellen, links aufgefüllt mit „$“, unter dem Bezeichner „Salary“.

SELECT	last_name, REPLACE(STR(salary, 15), ' ', '$') Salary
FROM	employees;

-- oder 
SELECT	last_name, Right(REPLICATE('$', 15) + CAST(salary as varchar(15)), 15) Salary
FROM	employees;


-- 6.	Schreiben Sie eine Abfrage, die den Nachnamen und die Managerkennung der Mitarbeiter anzeigt. 
-- Falls der Mitarbeiter keinen Manager hat, soll „No Manager“ ausgegeben werden.

SELECT 	last_name,
			COALESCE(STR(manager_id), 'No Manager') "Manager"
FROM	 employees;

-- oder
SELECT 	last_name,
			ISNULL(CAST(manager_id as varchar), 'no Manager') "Manager"
FROM	 employees;

 
-- 7.	Schreiben Sie eine Abfrage, um eine Einstufung der Mitarbeiter auf Basis ihrer Jobkennung in folgender Form anzuzeigen:
--
-- JOB			GRADE
-- AD_PRES		A
-- ST_MAN		B
-- IT_PROG		C
-- SA_REP		D
-- ST_CLERK		E
-- None of the above	0

SELECT job_id, CASE job_id
		WHEN 'ST_CLERK' THEN 'E'
		WHEN 'SA_REP' THEN 'D'
		WHEN 'IT_PROG' THEN 'C'
		WHEN 'ST_MAN' THEN 'B'
		WHEN 'AD_PRES' THEN 'A'
		ELSE '0' END GRADE 
FROM employees;

