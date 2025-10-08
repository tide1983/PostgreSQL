-- Проверка работы запроса с тестовыми данными
SELECT 
    название,
    CASE 
        WHEN (название ILIKE 'мой %' OR название ILIKE '% мой %' OR название ILIKE '% мой' OR название = 'мой' OR
              название ILIKE 'my %' OR название ILIKE '% my %' OR название ILIKE '% my' OR название = 'my') 
        THEN 'ДОЛЖЕН БЫТЬ В ВЫБОРКЕ' 
        ELSE 'НЕ ДОЛЖЕН БЫТЬ В ВЫБОРКЕ' 
    END as результат
FROM треки 
WHERE название IN ('my own', 'own my', 'my', 'oh my god', 'myself', 'by myself', 'bemy self', 'myself by', 'by myself by', 'beemy', 'premyne')
ORDER BY название;