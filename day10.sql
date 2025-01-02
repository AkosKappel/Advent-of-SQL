SELECT * FROM drinks;

WITH AggregatedDrinks AS (
    -- Aggregate total quantity of each drink per date
    SELECT
        date,
        SUM(CASE WHEN drink_name = 'Hot Cocoa' THEN quantity ELSE 0 END) AS hot_cocoa,
        SUM(CASE WHEN drink_name = 'Peppermint Schnapps' THEN quantity ELSE 0 END) AS peppermint_schnapps,
        SUM(CASE WHEN drink_name = 'Eggnog' THEN quantity ELSE 0 END) AS eggnog
    FROM Drinks
    GROUP BY date
)
-- Find the date where the quantities match the criteria
SELECT date
FROM AggregatedDrinks
WHERE
    hot_cocoa = 38 AND
    peppermint_schnapps = 298 AND
    eggnog = 198;

-- 2024-03-14
