SELECT * FROM workshop_elves;

WITH skill_groups AS (
    SELECT
        primary_skill,
        elf_id,
        years_experience,
        ROW_NUMBER() OVER (PARTITION BY primary_skill ORDER BY years_experience DESC, elf_id ASC) AS max_rank,
        ROW_NUMBER() OVER (PARTITION BY primary_skill ORDER BY years_experience ASC, elf_id ASC) AS min_rank
    FROM workshop_elves
)
SELECT
    max_elf.elf_id AS elf_1_id,
    min_elf.elf_id AS elf_2_id,
    max_elf.primary_skill AS shared_skill
FROM skill_groups max_elf
JOIN skill_groups min_elf
    ON max_elf.primary_skill = min_elf.primary_skill
   AND max_elf.max_rank = 1
   AND min_elf.min_rank = 1
WHERE max_elf.elf_id <> min_elf.elf_id
ORDER BY shared_skill, elf_1_id, elf_2_id;

-- 4153,3611,Gift sorting
-- 10497,1016,Gift wrapping
-- 50,13551,Toy making
