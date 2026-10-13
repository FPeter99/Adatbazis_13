USE kassza;

CREATE TABLE modositas (
    id           INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    blokk_id     INT NOT NULL,
    regi_osszeg  DOUBLE NOT NULL,
    uj_osszeg    DOUBLE NOT NULL,
    mod_ideje    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    mod_user     VARCHAR(100) NOT NULL DEFAULT (CURRENT_USER())
) ENGINE=InnoDB;