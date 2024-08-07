-- Script that creates a function SafeDiv that divides (and returns) the first by the second
-- number or returns 0 if the second number is equal to 0
DROP FUNCTION IF EXISTS SafeDiv;
DELIMITER //
CREATE FUNCTION SafeDiv (a INTEGER, b INTEGER) RETURNS DECIMAL(10,2)
BEGIN
	DECLARE calc DECIMAL(10,2) DEFAULT 0;

	IF b = 0 THEN
		RETURN 0;
	ELSE
		SET calc = a / b;
		RETURN calc;
	END IF;
END //
DELIMITER ;
