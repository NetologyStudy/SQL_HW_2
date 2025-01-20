-- Создание таблицы "genres"
CREATE TABLE genres(
	genre_id SERIAL PRIMARY KEY,
	genre_name VARCHAR(32) UNIQUE NOT NULL
);

-- Создание таблицы "artists"
CREATE TABLE artists(
	artist_id SERIAL PRIMARY KEY,
	nickanme VARCHAR(128) NOT NULL
);

-- Создание таблицы "genres_artists" связь многие-ко-многим
CREATE TABLE genres_artists(
	genre_artist_id SERIAL PRIMARY KEY,
	genre_id INTEGER REFERENCES genres(genre_id),
	artist_id INTEGER REFERENCES artists(artist_id)
);

-- Создание таблицы "albums"
CREATE TABLE albums(
	album_id SERIAL PRIMARY KEY,
	album_title VARCHAR(128) NOT NULL,
	releasy_year DATE NOT NULL
);

-- Создание таблицы "artists_albums" связь многие-ко-многим
CREATE TABLE artists_albums(
	artists_albums_id SERIAL PRIMARY KEY,
	artist_id INTEGER REFERENCES artists(artist_id),
	album_id INTEGER REFERENCES albums(album_id)
);

-- Создание таблицы "tracks"
CREATE TABLE tracks(
	track_id SERIAL PRIMARY KEY,
	track_title VARCHAR(128) NOT NULL,
	duration INTERVAL NOT NULL,
	album_id INTEGER REFERENCES albums(album_id)
);

-- Создание таблицы "collections"
CREATE TABLE collections(
	collection_id SERIAL PRIMARY KEY,
	collection_title VARCHAR(128) NOT NULL
);

-- Создание таблицы "tracks_collections" связь многие-ко-многим
CREATE TABLE tracks_collections(
	track_collection_id SERIAL PRIMARY KEY,
	track_id INTEGER REFERENCES tracks(track_id),
	collection_id INTEGER REFERENCES collections(collection_id)
);

-- Добавление колонны в таблицу "tracks_collections"
ALTER TABLE
	collections
ADD COLUMN
	release_year DATE;

-- Добвление ограничения в столбец "duration" таблицы "tracks" 
ALTER TABLE
	tracks
ADD CONSTRAINT
	check_duration_max
CHECK
	(duration <= MAKE_INTERVAL(mins => 4));

-- Добвление ограничения в поле "release_year" таблицы "collections" 
ALTER TABLE
	collections
ADD CONSTRAINT
	check_collection_release_year
CHECK
	(EXTRACT(YEAR FROM release_year) >= 2000 AND EXTRACT(YEAR FROM release_year) <= EXTRACT(YEAR FROM CURRENT_DATE));

-- Исправление ошибки в поле "release_year" в таблице "albums"
ALTER TABLE
	albums
RENAME COLUMN
	releasy_year TO release_year;

-- Добвление ограничения в поле "release_year" таблицы "albums" 
ALTER TABLE
	albums
ADD CONSTRAINT
	check_album_release_year
CHECK
	(EXTRACT(YEAR FROM release_year) >= 2000 AND EXTRACT(YEAR FROM release_year) <= EXTRACT(YEAR FROM CURRENT_DATE));

-- Исправление ошибки в поле "nickname" в таблице "artists"
ALTER TABLE
	artists
RENAME COLUMN
	nickanme TO nickname;

-- Изменение типа данных в стобце "duration" в таблицы "tracks"
ALTER TABLE
	tracks
ADD COLUMN
	duration_seconds INTEGER;

UPDATE
    tracks
SET
    duration_seconds = EXTRACT(EPOCH FROM duration);

ALTER TABLE
	tracks
DROP COLUMN
	duration;

ALTER TABLE
	tracks
RENAME COLUMN
	duration_seconds TO duration;

-- Добвление ограничения в поле "duration" таблицы "tracks"
ALTER TABLE
    tracks
ADD CONSTRAINT
    check_duration_limit
CHECK
    (duration <= 240);


