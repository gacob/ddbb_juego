USE ddbb_juego;

DROP TRIGGER IF EXISTS combat_end;
delimiter //
CREATE TRIGGER combat_end
	BEFORE UPDATE ON combate
    FOR EACH ROW
BEGIN

    DECLARE h_nombre VARCHAR(20);
    DECLARE v_nombre VARCHAR(20);

	SELECT nombre INTO h_nombre FROM heroe WHERE id = new.heroe_id;
    SELECT nombre INTO v_nombre FROM villano WHERE id = new.villano_id;
    
    IF new.heroe_vida <= 0 OR new.villano_vida <= 0 THEN
		-- Comprobamos quien ha ganado e insertamos en combate_log
		IF new.heroe_vida <= 0 AND new.villano_vida > 0 THEN
			INSERT INTO combate_log (ganador, heroe_id, villano_id) VALUES
				(v_nombre , new.heroe_id, new.villano_id);
		ELSE
			INSERT INTO combate_log (ganador, heroe_id, villano_id) VALUES
				(h_nombre, new.heroe_id, new.villano_id);
		END IF;
		
		
		-- Comprobamos quien ha ganado y subimos contador de victorias en combate_records
		IF new.heroe_vida <= 0 AND new.villano_vida > 0 THEN
			INSERT INTO combate_records (cantidad_victorias, villano_id) VALUES
				(+1, new.villano_id);
		ELSE
			INSERT INTO combate_records (cantidad_victorias, heroe_id) VALUES
				(+1, new.heroe_id);
		END IF;
    END IF;
END
//

-- CALL prefight ("Aetheron","Zarvox");
-- CALL fight ("Aetheron","Zarvox");
