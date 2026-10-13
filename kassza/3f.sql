USE kassza;

ALTER TABLE cikk
  ADD CONSTRAINT fk_cikk_blokk
  FOREIGN KEY (blokk_id) REFERENCES blokk(id);

ALTER TABLE blokk
  ADD CONSTRAINT fk_blokk_elado
  FOREIGN KEY (elado_id) REFERENCES elado(id);