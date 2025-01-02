SELECT * FROM treeharvests;

WITH SeasonalData AS (
    SELECT
        field_name,
        harvest_year,
        season,
        trees_harvested,
        ROW_NUMBER() OVER (
            PARTITION BY field_name, harvest_year
            ORDER BY CASE
                WHEN season = 'Spring' THEN 1
                WHEN season = 'Summer' THEN 2
                WHEN season = 'Fall' THEN 3
                WHEN season = 'Winter' THEN 4
            END
        ) AS season_order
    FROM TreeHarvests
),
MovingAverages AS (
    SELECT
        field_name,
        harvest_year,
        season,
        ROUND(AVG(trees_harvested) OVER (
            PARTITION BY field_name, harvest_year
            ORDER BY season_order
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2) AS three_season_moving_avg
    FROM SeasonalData
)
SELECT
    field_name,
    harvest_year,
    season,
    three_season_moving_avg
FROM MovingAverages
ORDER BY three_season_moving_avg DESC
LIMIT 1;

-- Northern Gardens 62,2024,Winter,327.67
