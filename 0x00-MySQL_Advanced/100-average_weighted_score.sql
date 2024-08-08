-- Script that creates a stored procedure that computes and store the average weighted score for a student
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUser;
DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INTEGER)
BEGIN
	DECLARE overall_weighted_score FLOOAT DEFAULT 0;
	DECLARE overall_weight INTEGER DEFAULT 0;
	DECLARE avg_weighted_score FLOAT DEFAULT 0;

	SELECT SUM(c.score * p.weight), SUM(p.weight) INTO overall_weighted_score, overall_weight
	FROM corrections c
	JOIN projectsp on c.project_id = p.id WHERE c.user_id = user_id;

	SET avg_weighted_score = IF(overall_weight = 0, 0, overall_weighted_score / overall_weight);

	UPDATE users SET avg_score = avg_weighted_score WHERE id = user_id;
END //
DELIMITER ;
