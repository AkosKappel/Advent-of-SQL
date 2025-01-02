SELECT * FROM children;
SELECT * FROM wish_lists;
SELECT * FROM toy_catalogue;

SELECT
    c.name,
    wl.wishes->>'first_choice' AS primary_wish,
    wl.wishes->>'second_choice' AS backup_wish,
    (wl.wishes->'colors'::text)::jsonb->>0 AS favorite_color,
    jsonb_array_length((wl.wishes->'colors'::text)::jsonb) AS color_count,
    CASE tc.difficulty_to_make
        WHEN 1 THEN 'Simple Gift'
        WHEN 2 THEN 'Moderate Gift'
        ELSE 'Complex Gift'
    END AS gift_complexity,
    CASE tc.category
        WHEN 'outdoor' THEN 'Outside Workshop'
        WHEN 'educational' THEN 'Learning Workshop'
        ELSE 'General Workshop'
    END AS workshop_assignment
FROM children c
JOIN public.wish_lists wl ON c.child_id = wl.child_id
LEFT JOIN toy_catalogue tc ON tc.toy_name = wl.wishes->>'first_choice'
ORDER BY c.name
LIMIT 5

