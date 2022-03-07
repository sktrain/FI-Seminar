-- Übungen/Lösungen zu DML

-- 1. Erzeugen Sie mit Hilfe der folgenden Anweisungen die Tabelle "MY EMPLOYEE", die im Folgenden verwendet wird:

CREATE TABLE MY_EMPLOYEE
  ( id INTEGER CONSTRAINT my_employee_id_nn NOT NULL, 
    lastname VARCHAR(25),
    firstname VARCHAR(25),
    userid VARCHAR(8),
    salary DECIMAL(9,2));
    
 
    
-- 2. Vergewissern Sie sich, dass die Tabelle angelegt wurde. 
SELECT * FROM MY_EMPLOYEE;


-- 3. Starten Sie eine explizite Transaktion
BEGIN TRAN MyTran;

-- 4. Fügen sie die erste Zeile in die Tabelle MY_EMPLOYEE von den folgenden Beispielsdaten ein, 
-- ohne die Spalten  beim INSERT aufzulisten.
-- ID   LAST_NAME   FIRST NAME    USERID    SALARY
-- 1    Patel       Ralph         rpatel      895
-- 2    Dancs       Betty         bdancs      860
-- 3    Muster3     Otto          mot3        1100
-- 4    Muster4     Otto          mot4        750


INSERT INTO my_employee
VALUES (1, 'Patel', 'Ralph', 'rpatel', 895);


-- 5. Füllen Sie die MY EMPLOYEE Tabelle mit der 2. und 3. Zeile der Beispielsdaten,
-- diemal mit expliziter Nennung der Spalten in der INSERT-Klausel.

INSERT INTO my_employee (id, lastname, firstname, userid, salary)
VALUES (2, 'Dancs', 'Betty', 'bdancs', 860);
INSERT INTO my_employee (id, lastname, firstname, userid, salary)
VALUES (3, 'Muster3', 'Otto', 'mot3', 1100);


-- 6. Schreiben Sie die Änderungen fest.

COMMIT TRAN MyTran;


-- 7. Starten Sie eine neue Transaktion
BEGIN TRAN;


-- 8. Ändern Sie den Namen des Angestellten 3 zu Drexler.

UPDATE	my_employee
SET	lastname = 'Drexler'
WHERE	id = 3;



-- 9. Ändern Sie das Gehalt für alle Angestellten, die weniger als 900 verdienen, auf 1000.

UPDATE	my_employee
SET	salary = 1000
WHERE	salary < 900;



-- 10. Löschen Sie Betty Dancs aus der Tabelle MY_EMPLOYEE.
DELETE
FROM my_employee
WHERE lastname = 'Dancs';



-- 11. Schreiben Sie alle anstehenden Änderungen fest.

COMMIT;


-- 12. Wechseln Sie zu impliziter Transaktionssteuerung

SET IMPLICIT_TRANSACTIONS ON;


-- 13. Füllen Sie die MY_EMPLOYEE Tabelle mit der 4. Zeile der Beispielsdaten.

INSERT INTO my_employee (id, lastname, firstname, userid, salary)
VALUES (4, 'Muster4', 'Otto', 'mot4', 750);




-- 14. Setzen Sie einen Zwischenpunkt (Savepoint) in der laufenden Transaktion. 

SAVE TRANSACTION step_14;



-- 15. Leeren Sie die gesamte Tabelle.

DELETE
FROM my_employee;



-- 16. Machen Sie das Löschen rückgängig ohne die vorherige INSERT-Anweisung rückgängig zu machen. 

ROLLBACK TRAN step_14;



-- 17. Schreiben Sie die Daten endgültig fest.

COMMIT;

-- nur zur Abfrage des Ergebnisses:
SELECT * FROM MY_EMPLOYEE;
-- nur zum Aufräumen
DROP TABLE MY_EMPLOYEE;
