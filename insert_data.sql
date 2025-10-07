-- Очистка данных перед вставкой
TRUNCATE TABLE 
    треки_сборники,
    исполнители_альбомы,
    исполнители_жанры,
    треки,
    сборники,
    альбомы,
    исполнители,
    жанры 
RESTART IDENTITY CASCADE;

-- Вставка жанров (6 жанров)
INSERT INTO жанры (название) VALUES
('Рок'),
('Поп'),
('Джаз'),
('Хип-хоп'),
('Электронная музыка'),
('Классика');

-- Вставка исполнителей (7 исполнителей)
INSERT INTO исполнители (имя, псевдоним) VALUES
('Джон Леннон', 'John Lennon'),
('Пол Маккартни', 'Paul McCartney'),
('Майкл Джексон', 'Michael Jackson'),
('Луи Армстронг', 'Louis Armstrong'),
('Эминем', 'Eminem'),
('Дэвид Гетта', 'David Guetta'),
('Фредди Меркьюри', 'Freddie Mercury');

-- Вставка альбомов (8 альбомов)
INSERT INTO альбомы (название, год_выпуска) VALUES
('Imagine', 1971),
('Thriller', 1982),
('What a Wonderful World', 1968),
('The Marshall Mathers LP', 2000),
('One Love', 2009),
('A Night at the Opera', 1975),
('Future Nostalgia', 2020),
('Chromatica', 2020);

-- Вставка треков (20 треков)
INSERT INTO треки (название, длительность, альбом_id) VALUES
-- Альбом Imagine (1971)
('Imagine', '3:07', 1),
('Jealous Guy', '4:17', 1),
('My Mummy''s Dead', '0:49', 1),

-- Альбом Thriller (1982)
('Thriller', '5:57', 2),
('Beat It', '4:18', 2),
('Billie Jean', '4:54', 2),

-- Альбом What a Wonderful World (1968)
('What a Wonderful World', '2:21', 3),
('Hello, Dolly!', '2:27', 3),

-- Альбом The Marshall Mathers LP (2000)
('The Real Slim Shady', '4:44', 4),
('Stan', '6:44', 4),
('My Name Is', '4:28', 4),

-- Альбом One Love (2009)
('When Love Takes Over', '3:11', 5),
('Gettin Over', '3:02', 5),
('My Feelings for You', '3:24', 5),

-- Альбом A Night at the Opera (1975)
('Bohemian Rhapsody', '5:55', 6),
('Love of My Life', '3:39', 6),

-- Альбом Future Nostalgia (2020)
('Don''t Start Now', '3:03', 7),
('My Future', '3:30', 7),

-- Альбом Chromatica (2020)
('Rain on Me', '3:02', 8),
('My Everything', '2:38', 8);

-- Вставка сборников (8 сборников)
INSERT INTO сборники (название, год_выпуска) VALUES
('Лучшие хиты 70-х', 2018),
('Золотая коллекция рока', 2019),
('Хип-хоп антология', 2020),
('Классика джаза', 2018),
('Саундтреки к фильмам', 2021),
('Великие баллады', 2022),
('Электронная вечеринка', 2020),
('My Favorite Songs', 2023);

-- Связи исполнителей с жанрами
INSERT INTO исполнители_жанры (исполнитель_id, жанр_id) VALUES
(1, 1), (1, 2),  -- John Lennon: Рок, Поп
(2, 1), (2, 2),  -- Paul McCartney: Рок, Поп
(3, 2), (3, 1),  -- Michael Jackson: Поп, Рок
(4, 3),          -- Louis Armstrong: Джаз
(5, 4),          -- Eminem: Хип-хоп
(6, 5),          -- David Guetta: Электронная музыка
(7, 1), (7, 6);  -- Freddie Mercury: Рок, Классика

-- Связи исполнителей с альбомами
INSERT INTO исполнители_альбомы (исполнитель_id, альбом_id) VALUES
(1, 1),  -- John Lennon - Imagine
(3, 2),  -- Michael Jackson - Thriller
(4, 3),  -- Louis Armstrong - What a Wonderful World
(5, 4),  -- Eminem - The Marshall Mathers LP
(6, 5),  -- David Guetta - One Love
(7, 6),  -- Freddie Mercury - A Night at the Opera
(6, 7),  -- David Guetta - Future Nostalgia
(3, 8);  -- Michael Jackson - Chromatica

-- Связи треков со сборниками
INSERT INTO треки_сборники (трек_id, сборник_id) VALUES
-- Лучшие хиты 70-х
(1, 1), (2, 1), (15, 1),
-- Золотая коллекция рока
(1, 2), (4, 2), (15, 2),
-- Хип-хоп антология
(9, 3), (10, 3), (11, 3),
-- Классика джаза
(7, 4), (8, 4),
-- Саундтреки к фильмам
(4, 5), (15, 5),
-- Великие баллады
(1, 6), (7, 6), (16, 6),
-- Электронная вечеринка
(12, 7), (17, 7), (18, 7),
-- My Favorite Songs
(3, 8), (11, 8), (17, 8), (19, 8);

SELECT 'Данные успешно загружены!' as статус;