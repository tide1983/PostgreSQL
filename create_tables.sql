-- Создание таблицы Жанры
CREATE TABLE IF NOT EXISTS жанры (
    id SERIAL PRIMARY KEY,
    название VARCHAR(100) NOT NULL UNIQUE
);

-- Создание таблицы Исполнители
CREATE TABLE IF NOT EXISTS исполнители (
    id SERIAL PRIMARY KEY,
    имя VARCHAR(100) NOT NULL,
    псевдоним VARCHAR(100)
);

-- Создание таблицы Альбомы
CREATE TABLE IF NOT EXISTS альбомы (
    id SERIAL PRIMARY KEY,
    название VARCHAR(200) NOT NULL,
    год_выпуска INTEGER NOT NULL CHECK (год_выпуска >= 1900 AND год_выпуска <= EXTRACT(YEAR FROM CURRENT_DATE))
);

-- Создание таблицы Треки
CREATE TABLE IF NOT EXISTS треки (
    id SERIAL PRIMARY KEY,
    название VARCHAR(200) NOT NULL,
    длительность INTERVAL NOT NULL CHECK (длительность > '0 seconds'),
    альбом_id INTEGER NOT NULL REFERENCES альбомы(id) ON DELETE CASCADE
);

-- Создание таблицы Сборники
CREATE TABLE IF NOT EXISTS сборники (
    id SERIAL PRIMARY KEY,
    название VARCHAR(200) NOT NULL,
    год_выпуска INTEGER NOT NULL CHECK (год_выпуска >= 1900 AND год_выпуска <= EXTRACT(YEAR FROM CURRENT_DATE))
);

-- Создание таблицы связи Исполнители-Жанры
CREATE TABLE IF NOT EXISTS исполнители_жанры (
    исполнитель_id INTEGER NOT NULL REFERENCES исполнители(id) ON DELETE CASCADE,
    жанр_id INTEGER NOT NULL REFERENCES жанры(id) ON DELETE CASCADE,
    PRIMARY KEY (исполнитель_id, жанр_id)
);

-- Создание таблицы связи Исполнители-Альбомы
CREATE TABLE IF NOT EXISTS исполнители_альбомы (
    исполнитель_id INTEGER NOT NULL REFERENCES исполнители(id) ON DELETE CASCADE,
    альбом_id INTEGER NOT NULL REFERENCES альбомы(id) ON DELETE CASCADE,
    PRIMARY KEY (исполнитель_id, альбом_id)
);

-- Создание таблицы связи Треки-Сборники
CREATE TABLE IF NOT EXISTS треки_сборники (
    трек_id INTEGER NOT NULL REFERENCES треки(id) ON DELETE CASCADE,
    сборник_id INTEGER NOT NULL REFERENCES сборники(id) ON DELETE CASCADE,
    PRIMARY KEY (трек_id, сборник_id)
);

-- Создание индексов для оптимизации
CREATE INDEX IF NOT EXISTS idx_исполнители_жанры_исполнитель ON исполнители_жанры(исполнитель_id);
CREATE INDEX IF NOT EXISTS idx_исполнители_жанры_жанр ON исполнители_жанры(жанр_id);
CREATE INDEX IF NOT EXISTS idx_исполнители_альбомы_исполнитель ON исполнители_альбомы(исполнитель_id);
CREATE INDEX IF NOT EXISTS idx_исполнители_альбомы_альбом ON исполнители_альбомы(альбом_id);
CREATE INDEX IF NOT EXISTS idx_треки_альбом ON треки(альбом_id);
CREATE INDEX IF NOT EXISTS idx_треки_сборники_трек ON треки_сборники(трек_id);
CREATE INDEX IF NOT EXISTS idx_треки_сборники_сборник ON треки_сборники(сборник_id);