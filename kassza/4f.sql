USE kassza;

CREATE OR REPLACE VIEW `havi_osszesites` AS
SELECT
    YEAR(b.vasarlas_ideje)  AS ev,
    MONTH(b.vasarlas_ideje) AS honap,
    COUNT(DISTINCT b.id)    AS blokkok_szama,
    SUM(c.mennyiseg * c.egysegar) AS osszertek
FROM blokk b
JOIN cikk c ON c.blokk_id = b.id
GROUP BY YEAR(b.vasarlas_ideje), MONTH(b.vasarlas_ideje)
ORDER BY ev, honap;