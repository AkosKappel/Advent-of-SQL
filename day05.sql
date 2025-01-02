SELECT * FROM toy_production;

WITH changes AS (
    SELECT
        production_date,
        toys_produced,
        LAG(toys_produced, 1) OVER (ORDER BY production_date) AS previous_day_production,
        toys_produced - LAG(toys_produced, 1) OVER (ORDER BY production_date) AS production_change
    FROM toy_production
)

SELECT *,
       round(100 * production_change / previous_day_production, 2) AS production_change_percentage
FROM changes
WHERE previous_day_production IS NOT NULL
ORDER BY production_change_percentage DESC;

-- 2017-03-20
