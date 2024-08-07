-- Script that creates a function SafeDiv that divides (and returns) the first by the second
-- number or returns 0 if the second number is equal to 0
DROP FUNCTION IF EXISTS SafeDiv;

DELIMITER //
CREATE FUNCTION SafeDiv (a INT, b INT) RETURNS DECIMAL(10,2)
BEGIN
	DECLARE calc DECIMAL(10,2) DEFAULT 0;

	IF b != 0 THEN
		SET calc = a / b;
	END IF;

	RETURN calc;
END //
DELIMITER ;
