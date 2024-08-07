-- Script that creates a stored procedure that adds a new correction for a student
DROP PROCEDURE IF EXISTS AddBonus;

DELIMITER //
CREATE PROCEDURE AddBonus(
	IN proc_user_id INTEGER,
	IN proc_project_name VARCHAR(255),
	IN proc_score FLOAT
)
BEGIN
	DECLARE proc_project_id INTEGER DEFAULT 0;
	DECLARE user_exists INTEGER DEFAULT 0;

	SELECT COUNT(*) INTO user_exists FROM users WHERE id = proc_user_id;

	SELECT id INTO proc_project_id FROM projects WHERE name = proc_project_name;

	IF proc_project_id IS NULL THEN
		INSERT INTO projects (name) VALUES (proc_project_name);
		SET proc_project_id = LAST_INSERT_ID();
	END IF;

	INSERT INTO corrections (user_id, project_id , score) VALUES (proc_user_id, proc_project_id, proc_score);
END //
DELIMITER ;
