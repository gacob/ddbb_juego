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
		
        -- Salimos del bucle si Héroe o Villano muere
		IF h_vida <= 0 or v_vida <= 0 THEN
			leave _loop;
		END IF;
        
        IF h_speed > v_speed THEN
			-- Héroe ataca primero
			SELECT heroe_turn(h_id, v_id, v_vida) INTO v_vida;
            UPDATE combate SET villano_vida=v_vida WHERE villano_id=v_id;
            
            SELECT mob_turn(h_id, v_id, h_vida) INTO h_vida;
            UPDATE combate SET heroe_vida=h_vida WHERE heroe_id=h_id;
        ELSE
			-- Villano ataca primero
			SELECT mob_turn(h_id, v_id, h_vida) INTO h_vida;
            UPDATE combate SET heroe_vida=h_vida WHERE heroe_id=h_id;
            
			SELECT heroe_turn(h_id, v_id, v_vida) INTO v_vida;
            UPDATE combate SET villano_vida=v_vida WHERE villano_id=v_id;
        END IF;
    END LOOP;
    
    IF h_vida > 0 THEN
			SELECT "El héroe es el ganador";
		ELSE
			SELECT "El Villano es el ganador";
		END IF;
END
//

CALL fight ("Aetheron","Zarvox");
