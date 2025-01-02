SELECT * FROM staff;

WITH RECURSIVE management_hierarchy AS (
    SELECT
        staff_id,
        staff_name,
        manager_id,
        1 AS level,
        CAST(staff_id AS VARCHAR) AS path
    FROM staff
    WHERE manager_id IS NULL -- top-level manager

    UNION ALL

    SELECT
        s.staff_id,
        s.staff_name,
        s.manager_id,
        mh.level + 1 AS level,
        mh.path || ',' || s.staff_id AS path
    FROM staff s
    JOIN management_hierarchy mh ON s.manager_id = mh.staff_id
)

SELECT max(level) FROM management_hierarchy;

-- 24
