-- 2. feladat
CREATE DATABASE kondibelepok
CHARACTER SET utf8
COLLATE utf8_hungarian_ci;
-- 4. feladat
SELECT COUNT(*) as db
FROM belepok
WHERE megnevezes LIKE '%bérlet%';
-- 5. feladat
SELECT COUNT(*) as noi_letszam
FROM tagok
WHERE nem = 'nő';
-- 6. feladat
SELECT COUNT(*) as nyugdijas_db
FROM tagok
WHERE TIMESTAMPDIFF(YEAR, szuletett, NOW()) >= 65;
-- 7. feladat
SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, szuletett, NOW())), 2) AS ferfi_atlag
FROM tagok
WHERE nem = "férfi";
-- 8. feladat
SELECT SUM(belepok.ar) AS noi_bev_30
FROM tagok
JOIN eladasok
ON eladasok.tag_id = tagok.id
JOIN belepok
ON belepok.id = eladasok.belepo_id
WHERE nem = "nő"
AND TIMESTAMPDIFF(YEAR, szuletett, NOW()) < 30;
-- 9. feladat
SELECT COUNT(*) AS visaberlet
FROM eladasok
JOIN tagok
ON tagok.id = eladasok.tag_id
JOIN belepok
ON belepok.id = eladasok.belepo_id
WHERE tagok.kartya_tipusa = "Visa"
AND megnevezes LIKE '%bérlet%';
-- 10. feladat
SELECT DISTINCT tagok.id, CONCAT(tagok.vnev, ' ', tagok.knev) AS nev, CONCAT(tagok.irsz, ' ', tagok.telepules, ', ', tagok.cim) AS teles_cim
FROM tagok
JOIN eladasok
ON eladasok.tag_id = tagok.id
JOIN belepok
ON belepok.id = eladasok.belepo_id 
WHERE belepok.megnevezes LIKE '%TRX%'
AND tagok.nem = 'nő';
-- 11. feladat
SELECT vnev, knev, cim
FROM tagok
WHERE cim LIKE '%Krt.%'
AND nem = 'nő'
AND irsz NOT LIKE '1%'
ORDER BY vnev, knev;
-- 12. feladat
SELECT vnev, knev, telefon
FROM tagok
WHERE nem = 'nő'
AND TIMESTAMPDIFF(YEAR, szuletett, NOW()) > 30
AND( telefon LIKE '(30)%'
OR telefon LIKE '(20)%'
OR telefon LIKE '(70)%')
ORDER BY vnev, knev;
-- 13. feladat
SELECT SUM(belepok.ar) AS dayka
FROM tagok
JOIN eladasok
ON eladasok.tag_id = tagok.id
JOIN belepok
ON belepok.id = eladasok.belepo_id
WHERE tagok.megye LIKE '%Csongrád%'
AND tagok.cim LIKE '%Dayka Gábor%';
-- 14. feladat
SELECT irsz, COUNT(*) AS db
FROM tagok
GROUP BY irsz
HAVING COUNT(*) > 8
ORDER BY irsz DESC;
-- 15. feladat
SELECT megye, SUM(belepok.ar) as koltes
FROM belepok
JOIN eladasok
ON eladasok.belepo_id = belepok.id
JOIN tagok
ON tagok.id = eladasok.tag_id
GROUP BY megye
HAVING megye IS NOT NULL
ORDER BY megye ASC;
-- 16. feladat
SELECT telepules, SUM(belepok.ar) as koltes
FROM belepok
JOIN eladasok
ON eladasok.belepo_id = belepok.id
JOIN tagok
ON tagok.id = eladasok.tag_id
GROUP BY telepules
HAVING SUM(belepok.ar) <= 4000
ORDER BY SUM(belepok.ar) DESC, telepules ASC;
-- 17. feladat

-- 18. feladat
SELECT tagok.nem, belepok.megnevezes, COUNT(eladasok.belepo_id)
FROM eladasok
JOIN belepok
ON eladasok.belepo_id = belepok.id
JOIN tagok
ON tagok.id = eladasok.tag_id
GROUP BY tagok.nem, belepok.megnevezes
HAVING belepok.megnevezes LIKE '%korlátlan%'
ORDER BY belepok.megnevezes ASC, COUNT(eladasok.belepo_id) DESC;
-- 19. feladat
ALTER TABLE tagok
ADD COLUMN torzsvendeg BOOLEAN NOT NULL DEFAULT FALSE;
-- 20. feladat
DELETE FROM eladasok
WHERE tag_id = 1408;

DELETE FROM tagok
WHERE id = 1408;
-- 21. feladat
INSERT INTO belepok (megnevezes, ar, ervenyes)
VALUES ('Úszójegy', 2500, 1),
('Éves úszóbérlet', 250000, 365);
-- 22. feladat
CREATE TABLE kedvezmenyek (
    id INT AUTO_INCREMENT PRIMARY KEY,
    megnevezes VARCHAR(30)
);
-- 23. feladat
ALTER TABLE tagok
ADD kedvezmeny_id INT;
-- 24. feladat
ALTER TABLE tagok
ADD CONSTRAINT FK_tagok_kedvezmeny
FOREIGN KEY (kedvezmeny_id)
REFERENCES kedvezmenyek(id)
ON DELETE RESTRICT
ON UPDATE CASCADE;
-- 25. feladat
SELECT telepules
FROM tagok
WHERE irsz = (
    SELECT irsz
    FROM tagok
    WHERE telepules = 'Kerepes'
);
-- 26. feladat
SELECT COUNT(DISTINCT tag_id) AS db
FROM eladasok
WHERE tag_id IN (
    SELECT tag_id
    FROM eladasok
    JOIN belepok
    ON eladasok.belepo_id = belepok.id
    WHERE belepok.megnevezes LIKE '%TRX bérlet%'
)
AND tag_id IN (
    SELECT tag_id
    FROM eladasok
    JOIN belepok
    ON eladasok.belepo_id = belepok.id
    WHERE belepok.megnevezes LIKE '%Jóga bérlet%'
);
-- 27. feladat
SELECT vnev, knev
FROM tagok
WHERE knev = (
    SELECT knev
    FROM tagok
    GROUP BY knev
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
ORDER BY vnev ASC;
-- 28. feladat
SELECT vnev, knev, telefon
FROM tagok
WHERE telepules = 'Pécs'
AND nem = 'nő'
AND NOT EXISTS (
    SELECT *
    FROM eladasok
    JOIN belepok
    ON eladasok.belepo_id = belepok.id
    WHERE eladasok.tag_id = tagok.id
    AND belepok.megnevezes LIKE '%Spinning%'
)
ORDER BY vnev ASC, knev ASC;
-- 29. feladat
SELECT COUNT(DISTINCT eladasok.tag_id) AS db
FROM eladasok
JOIN tagok
ON eladasok.tag_id = tagok.id
WHERE eladasok.belepo_id IN (
    SELECT eladasok.belepo_id
    FROM eladasok
    JOIN tagok
    ON eladasok.tag_id = tagok.id
    WHERE tagok.telepules = 'Szeged'
    AND tagok.nem = 'nő'
    AND tagok.email LIKE '%@cuvox.de'
);