-- ComputeAverageWeightedScoreForUsers
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE total_weighted_score FLOAT;
    DECLARE total_weight FLOAT;

    -- Initialize variables
    SET total_weighted_score = 0;
    SET total_weight = 0;

    -- Iterate over users
    FOR each_user IN (SELECT id FROM users)
    DO
        -- Calculate weighted average score for the user
        SELECT
            SUM(c.score * p.weight) / NULLIF(SUM(p.weight), 0)
        INTO
            total_weighted_score
        FROM
            corrections c
        JOIN
            projects p ON c.project_id = p.id
        WHERE
            c.user_id = each_user.id;

        -- Update user's average_score
        UPDATE users
        SET average_score = total_weighted_score
        WHERE id = each_user.id;

        -- Accumulate total weight
        SET total_weight = total_weight + total_weighted_score;
    END FOR;

    -- Update overall average_score for all users
    UPDATE users
    SET average_score = total_weight / NULLIF((SELECT COUNT(*) FROM users), 0);
END //

DELIMITER ;
