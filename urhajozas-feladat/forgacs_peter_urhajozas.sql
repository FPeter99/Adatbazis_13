

-- 2. feladat
CREATE DATABASE urhajozas
CHARACTER SET utf8
COLLATE utf8_hungarian_ci;
-- 3. feladat
USE urhajozas;


-- 5. feladat
select nev, nem, szulev
from urhajos;
-- 6. feladat
select megnevezes, DATEDIFF(veg, kezdet) as nap
from kuldetes;
-- 7. feladat
select nev, YEAR(CURDATE()) - szulev as kor
from urhajos
ORDER BY kor DESC;
-- 8. feladat
select kuldetes.megnevezes, urhajos.nev
from kuldetes
join repules
on kuldetes.id = repules.kuldetes_id
join urhajos
on urhajos.id = repules.urhajos_id
order by kuldetes.kezdet asc, urhajos.nev desc;
-- 9. feladat
select nev, szulev
from urhajos
where nem = 'N' 
and szulev > 1960
and orszag = 'can';
-- 10. feladat
SELECT  nev
FROM urhajos
where CHAR_LENGTH(nev) = (
    select MAX(CHAR_LENGTH(nev))
    from urhajos
);
-- 11. feladat
SELECT kuldetes.megnevezes, COUNT(repules.urhajos_id) as fo
from kuldetes
join repules
on repules.kuldetes_id = kuldetes.id
group by kuldetes.id;

-- 12. feladat
SELECT nev, COUNT(repules.kuldetes_id)
from urhajos
join repules
on repules.urhajos_id = urhajos.id
group by urhajos_id;
having COUNT(repules.kuldetes_id) >= 6;
-- 13. feladat
select ROUND(AVG(DATEDIFF(veg, kezdet)), 2) as 'Gemini küldetések átlagos hosszúsága'
from kuldetes
where megnevezes LIKE 'Gemini%';
-- 14. feladat
select urhajos.orszag
from urhajos
join repules
on repules.urhajos_id = urhajos.id
join kuldetes
on kuldetes.id = repules.kuldetes_id
where YEAR(kuldetes.kezdet) >= 1991
and YEAR(kuldetes.kezdet) <= 2000
group by orszag
order by COUNT(*) desc
limit 3;
-- 15. feladat
select Count(*) as 'Robik száma'
from urhajos
where nev like 'Rob%';
-- 16. feladat
select nev, orszag, szulev
from urhajos
where szulev = (
    select szulev
    from urhajos
    where nev = 'Barbara Morgan'
);
-- 17. feladat
select kuldetes.megnevezes, kuldetes.kezdet, kuldetes.veg
from kuldetes
join repules
on repules.kuldetes_id = kuldetes.id
join urhajos
on urhajos.id = repules.urhajos_id
group by kuldetes.id
having SUM(urhajos.nem = 'N') = COUNT(*);
-- 18. feladat
DELETE FROM urhajos
WHERE nev = 'Serbán Lajos';
-- 19. feladat
INSERT INTO urhajos (id, nev, orszag, nem, szulev, urido)
VALUES (561, 'Alexander Poleshchuk', 'RUS', 'F', 1953, 'T179:00:43');
-- 20. feladat
ALTER TABLE kuldetes
ADD honapok DECIMAL(5,2) NULL;
-- 21. feladat
UPDATE kuldetes
SET honapok = DATEDIFF(veg, kezdet) / 30;