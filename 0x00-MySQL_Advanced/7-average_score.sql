-- Script that creates a stored procedure to compute and store the average score
DROP PROCEDURE IF EXISTS ComputeAverageScoreForUser;

DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser (
	IN proc_usr_id INTEGER
)

BEGIN
	DECLARE overall_score DECIMAL(10,2) DEFAULT 0;
	DECLARE prjs_count INTEGER DEFAULT 0;
	DECLARE avg_score DECIMAL(10,2) DEFAULT 0;

	SELECT COALESCE(SUM(score), 0) AS overall_score, COUNT(*) AS prjs_count
	INTO overall_score, prjs_count FROM corrections WHERE user_id = proc_usr_id;

	SET avg_score = IF(prjs_count = 0, 0, overall_score / prjs_count);

	UPDATE users SET average_score = avg_score WHERE id = proc_usr_id;
END //
DELIMITER ;
