SELECT * FROM reindeers;
SELECT * FROM training_sessions;

WITH AverageSpeeds AS (
    -- Calculate the average speed for each reindeer in each exercise
    SELECT
        r.reindeer_name,
        ts.exercise_name,
        ROUND(AVG(ts.speed_record), 2) AS average_speed
    FROM Reindeers r
    JOIN Training_Sessions ts ON r.reindeer_id = ts.reindeer_id
    WHERE r.reindeer_name != 'Rudolf' -- Exclude Rudolf
    GROUP BY r.reindeer_name, ts.exercise_name
),
HighestSpeeds AS (
    -- Find the highest average speed for each reindeer
    SELECT
        reindeer_name,
        MAX(average_speed) AS highest_average_speed
    FROM AverageSpeeds
    GROUP BY reindeer_name
)

SELECT
    reindeer_name,
    highest_average_speed
FROM HighestSpeeds
ORDER BY highest_average_speed DESC
LIMIT 3;

-- Cupid,88.64
-- Blitzen,88.38
-- Vixen,88.01
