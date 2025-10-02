-- Создание базы данных
CREATE DATABASE music_service;
\c music_service;

-- 1. Таблица Жанры
CREATE TABLE жанры (
    id SERIAL PRIMARY KEY,
    название VARCHAR(100) NOT NULL UNIQUE
);

-- 2. Таблица Исполнители
CREATE TABLE исполнители (
    id SERIAL PRIMARY KEY,
    имя VARCHAR(100) NOT NULL,
    псевдоним VARCHAR(100)
);

-- 3. Таблица Альбомы
CREATE TABLE альбомы (
    id SERIAL PRIMARY KEY,
    название VARCHAR(200) NOT NULL,
    год_выпуска INTEGER NOT NULL CHECK (год_выпуска >= 1900 AND год_выпуска <= EXTRACT(YEAR FROM CURRENT_DATE))
);

-- 4. Таблица Треки
CREATE TABLE треки (
    id SERIAL PRIMARY KEY,
    название VARCHAR(200) NOT NULL,
    длительность INTERVAL NOT NULL CHECK (длительность > '0 seconds'),
    альбом_id INTEGER REFERENCES альбомы(id) ON DELETE CASCADE
);

-- 5. Таблица Сборники
CREATE TABLE сборники (
    id SERIAL PRIMARY KEY,
    название VARCHAR(200) NOT NULL,
    год_выпуска INTEGER NOT NULL CHECK (год_выпуска >= 1900 AND год_выпуска <= EXTRACT(YEAR FROM CURRENT_DATE))
);

-- 6. Таблица связи Исполнители-Жанры (многие-ко-многим)
CREATE TABLE исполнители_жанры (
    исполнитель_id INTEGER REFERENCES исполнители(id) ON DELETE CASCADE,
    жанр_id INTEGER REFERENCES жанры(id) ON DELETE CASCADE,
    PRIMARY KEY (исполнитель_id, жанр_id)
);

-- 7. Таблица связи Исполнители-Альбомы (многие-ко-многим)
CREATE TABLE исполнители_альбомы (
    исполнитель_id INTEGER REFERENCES исполнители(id) ON DELETE CASCADE,
    альбом_id INTEGER REFERENCES альбомы(id) ON DELETE CASCADE,
    PRIMARY KEY (исполнитель_id, альбом_id)
);

-- 8. Таблица связи Треки-Сборники (многие-ко-многим)
CREATE TABLE треки_сборники (
    трек_id INTEGER REFERENCES треки(id) ON DELETE CASCADE,
    сборник_id INTEGER REFERENCES сборники(id) ON DELETE CASCADE,
    PRIMARY KEY (трек_id, сборник_id)
);

-- Создание индексов для улучшения производительности
CREATE INDEX idx_исполнители_жанры_исполнитель ON исполнители_жанры(исполнитель_id);
CREATE INDEX idx_исполнители_жанры_жанр ON исполнители_жанры(жанр_id);
CREATE INDEX idx_исполнители_альбомы_исполнитель ON исполнители_альбомы(исполнитель_id);
CREATE INDEX idx_исполнители_альбомы_альбом ON исполнители_альбомы(альбом_id);
CREATE INDEX idx_треки_альбом ON треки(альбом_id);
CREATE INDEX idx_треки_сборники_трек ON треки_сборники(трек_id);
CREATE INDEX idx_треки_сборники_сборник ON треки_сборники(сборник_id);

-- Вставка тестовых данных
INSERT INTO жанры (название) VALUES
('Рок'),
('Поп'),
('Джаз'),
('Хип-хоп'),
('Электронная музыка'),
('Классика');

INSERT INTO исполнители (имя, псевдоним) VALUES
('Джон Леннон', 'John Lennon'),
('Майкл Джексон', 'Michael Jackson'),
('Луи Армстронг', 'Louis Armstrong'),
('Эминем', 'Eminem'),
('Дэвид Гетта', 'David Guetta'),
('Пол Маккартни', 'Paul McCartney'),
('Квентин Тарантино', 'Various Artists');

INSERT INTO альбомы (название, год_выпуска) VALUES
('Imagine', 1971),
('Thriller', 1982),
('What a Wonderful World', 1968),
('The Marshall Mathers LP', 2000),
('One Love', 2009),
('Band on the Run', 1973),
('Pulp Fiction OST', 1994);

INSERT INTO треки (название, длительность, альбом_id) VALUES
('Imagine', '3:07', 1),
('Jealous Guy', '4:17', 1),
('Thriller', '5:57', 2),
('Beat It', '4:18', 2),
('What a Wonderful World', '2:21', 3),
('Hello, Dolly!', '2:27', 3),
('The Real Slim Shady', '4:44', 4),
('Stan', '6:44', 4),
('When Love Takes Over', '3:11', 5),
('Gettin Over', '3:02', 5),
('Band on the Run', '5:12', 6),
('Jet', '4:08', 6),
('Misirlou', '2:25', 7),
('You Never Can Tell', '3:00', 7);

INSERT INTO сборники (название, год_выпуска) VALUES
('Лучшие хиты 70-х', 2020),
('Золотая коллекция рока', 2019),
('Хип-хоп антология', 2021),
('Классика джаза', 2018),
('Саундтреки к фильмам', 2022);

-- Связи исполнителей с жанрами (многие-ко-многим)
INSERT INTO исполнители_жанры (исполнитель_id, жанр_id) VALUES
(1, 1), (1, 2),    -- Джон Леннон: Рок, Поп
(2, 2), (2, 1),    -- Майкл Джексон: Поп, Рок
(3, 3),            -- Луи Армстронг: Джаз
(4, 4),            -- Эминем: Хип-хоп
(5, 5),            -- Дэвид Гетта: Электронная музыка
(6, 1), (6, 2),    -- Пол Маккартни: Рок, Поп
(7, 1), (7, 3), (7, 6);  -- Various Artists: Рок, Джаз, Классика

-- Связи исполнителей с альбомами (многие-ко-многим)
INSERT INTO исполнители_альбомы (исполнитель_id, альбом_id) VALUES
(1, 1),    -- Джон Леннон - Imagine
(2, 2),    -- Майкл Джексон - Thriller
(3, 3),    -- Луи Армстронг - What a Wonderful World
(4, 4),    -- Эминем - The Marshall Mathers LP
(5, 5),    -- Дэвид Гетта - One Love
(6, 6),    -- Пол Маккартни - Band on the Run
(7, 7),    -- Various Artists - Pulp Fiction OST
(1, 6),    -- Джон Леннон участвовал в Band on the Run
(6, 1);    -- Пол Маккартни участвовал в Imagine

-- Связи треков со сборниками (многие-ко-многим)
INSERT INTO треки_сборники (трек_id, сборник_id) VALUES
(1, 1), (1, 2),   -- Imagine в двух сборниках
(3, 1), (3, 2),   -- Thriller в двух сборниках
(5, 4),           -- What a Wonderful World в джаз-сборнике
(7, 3),           -- The Real Slim Shady в хип-хоп сборнике
(9, 1),           -- When Love Takes Over в хитах 70-х
(13, 5), (14, 5); -- Саундтреки в сборнике саундтреков