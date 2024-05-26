USE ddbb_juego;

DROP FUNCTION IF EXISTS heroe_turn;
delimiter //
CREATE FUNCTION heroe_turn (
	h_id INT,
    v_id INT,
    v_vida INT
)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE attack_p, attack_m INT;
    DECLARE deff_p, deff_m INT;
    DECLARE attack_turn FLOAT;
    
    -- Obtenemos el ataque físico y mágico del Héroe
    SELECT ataque_p INTO attack_p FROM heroe WHERE id=h_id;
    SELECT ataque_m INTO attack_m FROM heroe WHERE id=h_id;
    
    -- Obtenemos la defensa física y mágica del villano
    SELECT defensa_p INTO deff_p FROM villano WHERE id=v_id;
    SELECT defensa_m INTO deff_m FROM villano WHERE id=v_id;
    
    -- 50% de atacar de forma física, 50% de atacar de forma mágica
    SET attack_turn = RAND();
    
    IF attack_turn >= 0.5 THEN -- Ataque físico
		SET v_vida = v_vida - ( attack_p - deff_p );
    ELSE -- Ataque mágico
		SET v_vida = v_vida - ( attack_m - deff_m );
    END IF;
    
    RETURN v_vida;
END
//

-- SELECT heroe_turn (21, 11, 100);