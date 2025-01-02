SELECT * FROM toy_production;

WITH tag_analysis AS (
    SELECT
        toy_id,
        toy_name,
        array(
            SELECT unnest(new_tags)
            EXCEPT
            SELECT unnest(previous_tags)
        ) AS added_tags,
        array(
            SELECT unnest(new_tags)
            INTERSECT
            SELECT unnest(previous_tags)
        ) AS unchanged_tags,
        array(
            SELECT unnest(previous_tags)
            EXCEPT
            SELECT unnest(new_tags)
        ) AS removed_tags
    FROM toy_production
)

SELECT
    toy_id,
    COALESCE(array_length(added_tags, 1), 0) AS added_tags_length,
    COALESCE(array_length(unchanged_tags, 1), 0) AS unchanged_tags_length,
    COALESCE(array_length(removed_tags, 1), 0) AS removed_tags_length
FROM tag_analysis
ORDER BY added_tags_length DESC
LIMIT 1;

-- 2726,98,2,0
