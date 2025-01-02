SELECT * FROM christmas_menus;

WITH parsed_menus AS (
    SELECT
        id,
        CASE
            WHEN xpath_exists('/northpole_database[@version="1.0"]', menu_data) THEN 1
            WHEN xpath_exists('/christmas_feast[@version="2.0"]', menu_data) THEN 2
            WHEN xpath_exists('/polar_celebration[@version="3.0"]', menu_data) THEN 3
        END AS schema_version,
        CASE
            WHEN xpath_exists('/northpole_database[@version="1.0"]', menu_data) THEN
                (xpath('/northpole_database/annual_celebration/event_metadata/dinner_details/guest_registry/total_count/text()', menu_data)::TEXT[]::INT[])[1]
            WHEN xpath_exists('/christmas_feast[@version="2.0"]', menu_data) THEN
                (xpath('/christmas_feast/organizational_details/attendance_record/total_guests/text()', menu_data)::TEXT[]::INT[])[1]
            WHEN xpath_exists('/polar_celebration[@version="3.0"]', menu_data) THEN
                (xpath('/polar_celebration/event_administration/participant_metrics/attendance_details/headcount/total_present/text()', menu_data)::TEXT[]::INT[])[1]
        END AS guest_count,
            CASE
            WHEN xpath_exists('/northpole_database[@version="1.0"]', menu_data) THEN
                xpath('/northpole_database/annual_celebration/event_metadata/menu_items/food_category/food_category/dish/food_item_id/text()', menu_data)::TEXT[]
            WHEN xpath_exists('/christmas_feast[@version="2.0"]', menu_data) THEN
                xpath('/christmas_feast/organizational_details/menu_registry/course_details/dish_entry/food_item_id/text()', menu_data)::TEXT[]
            WHEN xpath_exists('/polar_celebration[@version="3.0"]', menu_data) THEN
                xpath('/polar_celebration/event_administration/culinary_records/menu_analysis/item_performance/food_item_id/text()', menu_data)::TEXT[]
        END AS food_item_ids
    FROM christmas_menus
),
filtered_menus AS (
    SELECT
        unnest(food_item_ids) AS food_item_id
    FROM parsed_menus
    WHERE guest_count > 78
),
frequency_count AS (
    SELECT
        food_item_id,
        count(*) AS frequency
    FROM filtered_menus
    GROUP BY food_item_id
)

SELECT
    food_item_id
FROM frequency_count
ORDER BY frequency DESC
LIMIT 1;

-- 493
