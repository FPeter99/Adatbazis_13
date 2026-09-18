--3. feladat:
USE hr;

CREATE VIEW programozok AS
SELECT CONCAT(first_name, ' ', last_name) AS FULL_NAME
FROM employees
WHERE job_id = (
    SELECT job_id
    FROM jobs
    WHERE job_title = 'Programmer'
);

--4. feladat:
SELECT * FROM programozok;

--5. feladat:
CREATE VIEW munkakorletszam AS
SELECT j.job_title, COUNT(e.employee_id) AS db
FROM jobs j
LEFT JOIN employees e ON j.job_id = e.job_id
GROUP BY j.job_id, j.job_title;

--6. feladat:
SELECT job_title, db
FROM munkakorletszam
WHERE db >= 20;

--7. feladat:
CREATE VIEW orszagfo AS
SELECT c.country_name AS COUNTRY_NAME,
       COUNT(e.employee_id) AS fo
FROM countries c
JOIN locations l ON c.country_id = l.country_id
JOIN departments d ON l.location_id = d.location_id
JOIN employees e ON d.department_id = e.department_id
GROUP BY c.country_id, c.country_name;
--8. feladat:
SELECT * FROM orszagfo;
--9. feladat:
CREATE VIEW reszlegvezeto AS
SELECT d.department_name AS DEPARTMENT_NAME,
       CONCAT(e.first_name, ' ', e.last_name) AS FULL_NAME
FROM departments d
JOIN employees e ON d.manager_id = e.employee_id;
--10. feladat:
SELECT *
FROM reszlegvezeto
WHERE FULL_NAME LIKE '%Den%';
--11. feladat:
CREATE VIEW kiholdolgozik AS
SELECT e.employee_id,
       CONCAT(e.first_name, ' ', e.last_name) AS FULL_NAME,
       d.department_id,
       d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;
--12. feladat:
SELECT ROUND(AVG(e.salary)) AS atlag
FROM employees e
WHERE e.department_id = (
    SELECT department_id
    FROM kiholdolgozik
    WHERE FULL_NAME = 'David Austin'
);
--13. feladat:
CREATE VIEW belepo AS
SELECT CONCAT(first_name, ' ', last_name) AS FULL_NAME,
       hire_date AS HIRE_DATE
FROM employees;
--14. feladat:
SELECT * FROM belepo;
--15. feladat:
CREATE VIEW regiovezetok AS
SELECT CONCAT(e.first_name, ' ', e.last_name) AS FULL_NAME,
       e.hire_date AS HIRE_DATE,
       r.region_name AS REGION_NAME
FROM employees e
JOIN departments d ON e.employee_id = d.manager_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
JOIN regions r ON c.region_id = r.region_id;
--16. feladat:
SELECT * FROM regiovezetok;

