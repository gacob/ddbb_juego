-- Procedure Fight
DROP PROCEDURE IF EXISTS fight;
delimiter //
CREATE PROCEDURE fight (
	in h_nombre varchar(20),
    in v_nombre varchar(20)
)
BEGIN
	DECLARE h_id, h_vida, h_speed INT;
    DECLARE v_id, v_vida, v_speed INT;
    
    -- Obtenemos las variables que necesitamos para el combate
    SELECT id INTO h_id FROM heroe WHERE nombre = h_nombre;
    SELECT vida INTO h_vida FROM heroe WHERE nombre = h_nombre;
    
    SELECT id INTO v_id FROM villano WHERE nombre = v_nombre;
    SELECT vida INTO v_vida FROM heroe WHERE nombre = h_nombre;
    
    -- Obtenemos la velocidad
    SELECT velocidad INTO h_speed FROM heroe WHERE id = h_id;
    SELECT velocidad INTO v_speed FROM heroe WHERE id = v_id;
    
    -- Combate
    _loop: LOOP 
		IF h_vida <= 0 or v_vida <= 0 THEN
			leave _loop;
		END IF;
        
        IF h_speed > v_speed THEN
			-- Héroe ataca primero
			SELECT heroe_turn() INTO v_vida;
            SELECT mob_turn() INTO h_vida;
        ELSE
			-- Villano ataca primero
			SELECT mob_turn() INTO h_vida;
			SELECT heroe_turn() INTO v_vida;
        END IF;
        
        IF h_vida > 0 THEN
			SELECT "El héroe es el ganador";
		ELSE
			SELECT "El Villano es el ganador";
		END IF;
    END LOOP;
END
//
