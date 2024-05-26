USE ddbb_juego;

DROP FUNCTION IF EXISTS mob_turn;
delimiter //
CREATE FUNCTION mob_turn (
	h_id INT,
    v_id INT
)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE h_vida INT;
	DECLARE attack_p, attack_m INT;
    DECLARE deff_p, deff_m INT;
    DECLARE attack_turn FLOAT;
    
    -- Obtenemos la Vida del Héroe
	SELECT vida INTO h_vida FROM heroe WHERE id=h_id;
    
    -- Obtenemos el ataque físico y mágico del Villano
    SELECT ataque_p INTO attack_p FROM villano WHERE id=h_id;
    SELECT ataque_m INTO attack_m FROM villano WHERE id=h_id;
    
    -- Obtenemos la defensa física y mágica del Héroe
    SELECT defensa_p INTO deff_p FROM heroe WHERE id=h_id;
    SELECT defensa_m INTO deff_m FROM heroe WHERE id=h_id;
    
    -- 50% de atacar de forma física, 50% de atacar de forma mágica
    SET attack_turn = RAND();
    
    IF attack_turn >= 0.5 THEN -- Ataque físico
		SET h_vida = h_vida - ( attack_p - deff_p );
    ELSE -- Ataque mágico
		SET h_vida = h_vida - ( attack_m - deff_m );
    END IF;
    
    RETURN h_vida;
END
//