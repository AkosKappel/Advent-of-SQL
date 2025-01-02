SELECT * FROM children;
SELECT * FROM gifts;

WITH price AS (
    SELECT AVG(price) AS average
    FROM gifts
)

SELECT
    c.name AS child_name,
    g.name AS gift_name,
    g.price AS gift_price
FROM gifts g
JOIN children c ON g.child_id = c.child_id
CROSS JOIN price
WHERE g.price > price.average
ORDER BY g.price
LIMIT 1;

-- Hobart,art easel,497.44
