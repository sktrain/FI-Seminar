-- �bung 5: Verwendung von Gruppenfunktionen  -  L�sungen

-- 1.	Zeigen Sie das h�chste Gehalt, das niedrigste Gehalt, die Summe aller Geh�lter und das Durchschnittsgehalt 
-- f�r alle Mitarbeiter an. Runden Sie das Ergebnis auf die n�chste ganze Zahl.

SELECT	ROUND (MAX (salary), 0)  	"Maximum",
		ROUND (MIN (salary), 0)   	"Minimum",
		ROUND (SUM(salary), 0)   	"Summe",
		STR(ROUND (AVG(salary), 0),10,2)		"Durchschnitt"
FROM	employees;


-- 2.	Ver�ndern Sie die vorherige Abfrage so, dass die Werte je Jobkennung berechnet und angezeigt werden. 

SELECT 	job_id, 
		ROUND (MAX (salary), 0)  	"Maximum",
		ROUND (MIN (salary), 0)   "Minimum",
		ROUND (SUM(salary), 0)   	"Summe",
		STR(ROUND (AVG(salary), 0),10,2) "Durchschnitt"
FROM	employees
GROUP BY 	job_id;


-- 3.	Zeigen Sie die Jobkennungen und die Anzahl der Mitarbeiter mit diesem Job an

SELECT  job_id,   COUNT(*)
FROM	employees
GROUP  BY  job_id;


-- 4.	Zeigen Sie die Differenz zwischen dem niedrigsten und h�chsten Gehalt je Abteilung an. Nennen Sie die Spalte �Differenz�.

SELECT	department_id,   MAX(salary) - MIN(salary)   "Differenz"
FROM	employees
GROUP  BY  department_id;


-- 5.	Bestimmen Sie die Anzahl der Manager (ohne diese aufzulisten).

SELECT	COUNT( DISTINCT manager_id )   "Anzahl Manager"
FROM	employees;
 

-- 6.	Zeigen Sie je Managerkennung das Gehalt des unterstellten Angestellten mit dem niedrigsten Gehalt an. 
-- Schlie�en Sie alle Angestellten aus, deren Manager nicht bekannt ist. Schlie�en Sie alle Gruppen aus, 
-- deren Mindestgehalt 6000 oder weniger betr�gt.
-- Sortieren Sie die Ausgabe in absteigender Reihenfolge nach dem Gehalt.

SELECT manager_id, MIN(salary)
	FROM employees
	WHERE manager_id IS NOT NULL
	GROUP BY manager_id
	HAVING MIN(salary) > 6000
	ORDER BY MIN(salary) DESC; 
  

-- 7.	Zeigen Sie die Anzahl der Mitarbeiter, deren Nachname mit dem Buchstaben �n� endet.

SELECT   count(*) 
	FROM   employees
  WHERE  last_name  LIKE  '%n' ;

-- oder

SELECT   count(*) 
	FROM       employees
  WHERE    RIGHT(last_name, 1) = 'n' ;


-- 8. Zeigen Sie die Jobkennungen, die in den Abteilungen "Administration" 
-- und "Executive" vorkommen. 
-- Zeigen Sie auch die Anzahl der Mitarbeiter f�r diese Jobs an, wobei die Ausgabe nach 
-- der Anzahl sortiert erfolgen soll.

SELECT	e.job_id, count(e.job_id) "Haeufigkeit"
FROM	employees e JOIN departments d
		ON e.department_id = d.department_id
WHERE	d.department_name in ('Administration', 'Executive')
GROUP BY e.job_id
ORDER BY "Haeufigkeit";
  
  
-- 9. Zeigen Sie f�r alle Mitarbeiter, deren Managerkennung kleiner 130 ist, Folgendes an:
-- Managerkennung,  Job-Kennung und Gesamtgehalt f�r jede Jobkennung, sortiert nach der Managerkennung.

SELECT manager_id, job_id, sum(salary) "Gehaltssumme"
  FROM employees
  WHERE manager_id < 130
  GROUP BY manager_id, job_id
  ORDER BY manager_id;
  
  
-- 10. Erweitern Sie Aufgabe 8, so dass zus�tzlich angezeigt wird:
-- Gesamtgehalt der Mitarbeiter unter dem jeweiligen Manager, Gesamtgehalt aller Mitarbeiter unter diesen Managern

SELECT manager_id, job_id, sum(salary)  "Gehaltssumme"
  FROM employees
  WHERE manager_id < 130
  GROUP BY ROLLUP (manager_id, job_id)
  ORDER BY manager_id;
  

-- 11. Erweitern Sie Aufgabe 9 um eine Anzeige, die deutlich macht, ob die Nullwerte in den Spalten aus der Rollup-Auswertung
-- resultieren oder auf Basis gespeicherter Nullwerte aus der Tabelle zustande kommen.

SELECT manager_id, job_id, 
       sum(salary) "Gehaltssumme", 
       grouping(manager_id) "Null-Resultat",
       grouping(job_id)  "Null-Resultat"
  FROM employees
  WHERE manager_id < 130
  GROUP BY ROLLUP (manager_id, job_id)
  ORDER BY manager_id;
  
-- oder erweitert

SELECT manager_id, job_id, 
       sum(salary) "Gehaltssumme", 
       case grouping(manager_id) WHEN 1 THEN 'Aggregiert'
                                 ELSE ' '                 -- leere Zeichkette wird als "null" ausgegeben
                                 END  AS "Sum_je_Man",
       case grouping(job_id) WHEN 1 THEN 'Aggregiert'
                                 ELSE ' '
                                 END  AS "Sum_je_Job"
  FROM employees
  WHERE manager_id < 130
  GROUP BY ROLLUP (manager_id, job_id)
  ORDER BY manager_id;
  
  
-- 12. Erweitern Sie die Abfrage aus Aufgabe 10, so dass zus�tzlich angezeigt wird:
-- Gesamtgehalt je Jobkennung unabh�ngig vom Manager

SELECT manager_id, job_id, 
       sum(salary) "Gehaltssumme", 
       case grouping(manager_id) WHEN 1 THEN 'Aggregiert'
                                 ELSE ' '                 -- leere Zeichkette wird als "null" ausgegeben
                                 END  AS "Sum_je_Man",
       case grouping(job_id) WHEN 1 THEN 'Aggregiert'
                                 ELSE ' '
                                 END  AS "Sum_je_Job"
  FROM employees
  WHERE manager_id < 130
  GROUP BY CUBE (manager_id, job_id)
  ORDER BY manager_id;


-- 13. Modifizieren Sie die Abfrage aus Aufgabe 9, so dass nur folgende Gruppierungen angezeigt werden:
-- (Abteilungskennung, Managerkennung, Jobkennung),
-- (Abteilungskennung, Jobkennung),
-- (Managerkennung, Jobkennung)

SELECT department_id, manager_id, job_id, sum(salary)  "Gehaltssumme"
  FROM employees
  WHERE manager_id < 130
  GROUP BY 
  GROUPING SETS ( (department_id, manager_id, job_id),
                  (department_id, job_id),
                  (manager_id, job_id) )
  ORDER BY department_id, manager_id;

-- 14. Zeigen Sie je Kalenderjahr an, wieviele Angestellte jeweils eingestellt wurden.  
SELECT YEAR (hire_date) AS Jahr, 
        count(*) as Anzahl FROM employees
GROUP BY YEAR (hire_date)
ORDER BY Jahr;
  
  
-- 15. Erstellen Sie eine Abfrage, um folgende Angaben f�r alle Abteilungen anzuzeigen,
-- deren Abteilungsnummer gr��er als 80 ist:
--  - Gesamtgehalt f�r jeden Job in der Abteilung
--  - Das Gesamtgehalt
--  - Das Gesamtgehalt f�r die St�dte, in denen sich Abteilungen befinden
--  - Das Geamtgehalt f�r jeden Job, unabh�ngig von der Abteilung
--  - Das Gesamtgehalt f�r jede Abteilung, unabh�ngig von der Stadt
--  - Das Gesamtgehalt f�r die Abteilungen, unabh�ngig von Job-Bezeichnung und Stadt

SELECT l.city, d.department_name, e.job_id, sum(e.salary) sum_salary
  FROM locations l 
       JOIN departments d ON l.location_id = d.location_id
       JOIN employees e ON e.department_id = d.department_id
  WHERE e.department_id > 80
  GROUP BY CUBE ( l.city, d.department_name, e.job_id)
  ORDER BY l.city, d.department_name, e.job_id;
  
-- oder mit Verwendung von GROUPING bzw. GROUPING_ID
SELECT l.city, d.department_name, e.job_id, sum(e.salary) sum_salary,
       GROUPING(l.city), GROUPING(d.department_name), GROUPING(e.job_id),
       GROUPING_ID(l.city, d.department_name, e.job_id)
  FROM locations l 
       JOIN departments d ON l.location_id = d.location_id
       JOIN employees e ON e.department_id = d.department_id
  WHERE e.department_id > 80
  GROUP BY CUBE ( l.city, d.department_name, e.job_id);
  

  
-- 16  Erstellen Sie eine Abfrage, um folgende Gruppierungen anzuzeigen:
--  - Abteilungsnummer, Jobkennung
--  - Jobkennung, Managerkennung
--  wobei die Ausgabe das Maximal- und das Minimalgehalt nach Abteilung, T�tigkeit und Manager enthalten soll
SELECT department_id, job_id, manager_id, MAX(salary), MIN(salary)
  FROM employees 
  GROUP BY GROUPING SETS ((department_id, job_id), (job_id, manager_id));
  
-- mit Anzeige des Namens der Abteilung und des Vorgesetzten (Manager)
SELECT d.department_name, e.job_id, e.manager_id, MAX(salary) max_salary, MIN(salary) min_salary
  FROM employees e 
      JOIN departments d ON e.department_id = d.department_id
  GROUP BY GROUPING SETS ((e.department_id, d.department_name, e.job_id), (e.job_id, e.manager_id));
  