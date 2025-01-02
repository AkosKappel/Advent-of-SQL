SELECT * FROM letters_a;
SELECT * FROM letters_b;

WITH letters AS (
    SELECT
        value,
        chr(value) AS letter
    FROM letters_a
    UNION ALL
    SELECT
        value,
        chr(value) AS letter
    FROM letters_b
)

SELECT string_agg(letter, '') AS christmas_wish
FROM letters
WHERE value BETWEEN ascii('a') AND ascii('z')
OR value BETWEEN ascii('A') AND ascii('Z')
OR value IN (
    ascii(' '), ascii('!'), ascii('"'), ascii(''''),
    ascii('('), ascii(')'), ascii(','), ascii('-'),
    ascii('.'), ascii(':'), ascii(';'), ascii('?')
);

-- Dear Santa, I hope this letter finds you well in the North Pole! I want a SQL course for Christmas!
