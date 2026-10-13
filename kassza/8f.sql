USE kassza;

CREATE USER 'kasszaprogram'@'192.168.0.%' IDENTIFIED BY 'K4ssz4J3lsz0!';

GRANT INSERT, UPDATE ON kassza.blokk TO 'kasszaprogram'@'192.168.0.%';
GRANT INSERT ON kassza.cikk TO 'kasszaprogram'@'192.168.0.%';