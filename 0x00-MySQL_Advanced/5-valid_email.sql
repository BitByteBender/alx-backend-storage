-- Script that createss a trigger that resets the attribute valid_email only when has been changed
DROP TRIGGER IF EXISTS email_validation;

DELIMITER //
CREATE TRIGGER email_validation
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
	IF OLD.email != New.email THEN
		SET NEW.valid_email = 0;
	END IF;
END //
DELIMITER ;
