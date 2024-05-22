DROP FUNCTION IF EXISTS heroe_turn;
delimiter //
CREATE FUNCTION heroe_turn (
	v_vida INT
)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE attack_p, attack_m INT;
    DECLARE deff_p, deff_m INT;
    
    SET attack_turn = RAND();
    
    IF attack_turn >= 0.5 THEN
		SET v_vida = v_vida - (attack_p - deff_p);
    ELSE
    
    END IF;
END
//

SELECT rand();