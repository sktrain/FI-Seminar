/* Erstellen Sie mittels rekursiver With-Klausel eine hierarchische Auflistung der 
 * Mitarbeitertabelle in folgender Form:
 * "Nachname des Chefs, Ang.-Nr-des Chefs, Nachname des unterstellten Mitarbeiters,
 * Ang.Nr. des Mitarbeiters"
 */

WITH empcte (last_name, employee_id, manager_id, manager_name)
  AS
    ( SELECT last_name, employee_id, manager_id, last_name from employees 
	where manager_id is null

	UNION ALL
	  SELECT  e.last_name, e.employee_id, e.manager_id, empcte.last_name from employees e
	    INNER JOIN empcte ON empcte.employee_id = e.manager_id

	)

SELECT * FROM empcte;