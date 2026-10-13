USE kassza;

CREATE USER 'kasszaadmin'@'192.168.%.%' IDENTIFIED BY 'adm1nPass++';

GRANT INSERT, UPDATE, DELETE ON kassza.blokk TO 'kasszaadmin'@'192.168.%.%';
GRANT INSERT, UPDATE, DELETE ON kassza.cikk TO 'kasszaadmin'@'192.168.%.%';