-- Übungen/Lösungen zu DML

-- 1. Erzeugen Sie mit Hilfe der folgenden Anweisungen die Tabelle "MY EMPLOYEE", die im Folgenden verwendet wird:

CREATE TABLE MY_EMPLOYEE
  ( id INTEGER CONSTRAINT my_employee_id_nn NOT NULL, 
    lastname VARCHAR(25),
    firstname VARCHAR(25),
    userid VARCHAR(8),
    salary DECIMAL(9,2));
    
 
    
-- 2. Vergewissern Sie sich, dass die Tabelle angelegt wurde. 



-- 3. Starten Sie eine explizite Transaktion


-- 4. Fügen sie die erste Zeile in die Tabelle MY_EMPLOYEE von den folgenden Beispielsdaten ein, 
-- ohne die Spalten  beim INSERT aufzulisten.
-- ID   LAST_NAME   FIRST NAME    USERID    SALARY
-- 1    Patel       Ralph         rpatel      895
-- 2    Dancs       Betty         bdancs      860
-- 3    Muster3     Otto          mot3        1100
-- 4    Muster4     Otto          mot4        750





-- 5. Füllen Sie die MY EMPLOYEE Tabelle mit der 2. und 3. Zeile der Beispielsdaten,
-- diemal mit expliziter Nennung der Spalten in der INSERT-Klausel.



-- 6. Schreiben Sie die Änderungen fest.




-- 7. Starten Sie eine neue Transaktion



-- 8. Ändern Sie den Namen des Angestellten 3 zu Drexler.




-- 9. Ändern Sie das Gehalt für alle Angestellten, die weniger als 900 verdienen, auf 1000.




-- 10. Löschen Sie Betty Dancs aus der Tabelle MY_EMPLOYEE.



-- 11. Schreiben Sie alle anstehenden Änderungen fest.




-- 12. Wechseln Sie zu impliziter Transaktionssteuerung




-- 13. Füllen Sie die MY_EMPLOYEE Tabelle mit der 4. Zeile der Beispielsdaten.




-- 14. Setzen Sie einen Zwischenpunkt (Savepoint) in der laufenden Transaktion. 



-- 15. Leeren Sie die gesamte Tabelle.




-- 16. Machen Sie das Löschen rückgängig ohne die vorherige INSERT-Anweisung rückgängig zu machen. 




-- 17. Schreiben Sie die Daten endgültig fest.



