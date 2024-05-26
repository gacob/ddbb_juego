USE ddbb_juego;

-- Procedure Prefight
DROP PROCEDURE IF EXISTS prefight;
delimiter //
CREATE PROCEDURE prefight (
	in h_nombre varchar(20),
    in v_nombre varchar(20)
)
BEGIN
	DECLARE h_id, h_vida INT;
    DECLARE v_id, v_vida INT;
    
    -- Obtenemos las variables que necesitamos para el combate
    SELECT id INTO h_id FROM heroe WHERE nombre = h_nombre;
    SELECT vida INTO h_vida FROM heroe WHERE nombre = h_nombre;
    
    SELECT id INTO v_id FROM villano WHERE nombre = v_nombre;
    SELECT vida INTO v_vida FROM heroe WHERE nombre = h_nombre;
    
    INSERT INTO combate (heroe_id, heroe_vida, villano_id, villano_vida) VALUES
    (h_id, h_vida, v_id, v_vida);
END
//

-- CALL prefight ("Aetheron","Zarvox");