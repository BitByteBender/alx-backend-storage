-- Script that creates a stored procedure that computes and store the average weighted score for all students
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;
DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
	UPDATE users u
	JOIN (
		SELECT c.user_id, SUM(c.score * p.weight) / SUM(p.weight) AS avg_weighted_score
		FROM corrections c
		JOIN projects p on c.project_id = p.id GROUP BY c.user_id
	) scores ON u.id = scores.user_id
	SET u.average_score = scores.avg_weighted_score;
END //
DELIMITER ;
