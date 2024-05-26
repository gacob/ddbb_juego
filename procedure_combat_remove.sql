USE ddbb_juego;

-- Procedure Fight
DROP PROCEDURE IF EXISTS combat_remove;
delimiter //
CREATE PROCEDURE combat_remove (
)
BEGIN
	DELETE FROM combate;
END
//

-- call combat_remove;