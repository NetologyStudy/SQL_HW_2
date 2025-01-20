-- Вставка данных в таблицу "genres"
INSERT INTO
	genres(genre_name)
VALUES
	('Рок'),
	('Рэп'),
	('Поп');

-- Вставка данных в таблицу "artists"
INSERT INTO
	artists(nickname)
VALUES
	('Linkin park'),
	('Eminem'),
	('Michael Jackson'),
	('Elton John');

-- Вставка данных в таблицу "genres_artists"
INSERT INTO
	genres_artists(genre_id, artist_id)
VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(3, 4),
	(1, 4);

-- Вставка данных в таблицу "albums"
INSERT INTO
	albums(album_title, release_year)
VALUES
	('Meteora', '2003-03-25'),
	('Encore', '2004-11-12'),
	('Invincible', '2001-10-30'),
	('Songs from the West Coast', '2001-10-01'),
	('The Lockdown Sessions', '2021-10-22');

-- Вставка данных в таблицу "artists_albums"
INSERT INTO
	artists_albums(artist_id, album_id)
VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(4, 5);

-- Вставка данных в таблицу "tracks"
INSERT INTO
	tracks(track_title, album_id, duration)
VALUES
	('My life', 1, 162),
	('Don''t Stay', 1, 188),
	('Somewhere I Belong', 1, 214),
	('Lying from You', 1, 175),
	('Hit the Floor', 1, 164),
	('Easier to Run', 1, 204),
	('Evil Deeds', 2, 237),
	('Never Enough', 2, 196),
	('Yellow Brick Road', 2, 173),
	('Like Toy Soldiers', 2, 179),
	('Mosh', 2, 165),
	('Puke', 2, 211),
	('Unbreakable', 3, 214),
	('Heartbreaker', 3, 201),
	('Invincible', 3, 198),
	('Break of Dawn', 3, 187),
	('Heaven Can Wait', 3, 229),
	('2000 Watts', 3, 217),
	('The Emperor’s New Clothes', 4, 186),
	('Dark Diamond', 4, 203),
	('Look Ma, my Hands', 4, 199),
	('American Triangle', 4, 211),
	('Original Sin', 4, 239),
	('Cold Heart', 5, 214),
	('Always Love You', 5, 171),
	('Learn to Fly', 5, 190),
	('After All', 5, 182),
	('Chosen Family', 5, 212),
	('The Pink Phantom', 5, 229);

-- Вставка данных в таблицу "collections"
INSERT INTO
	collections(collection_title)
VALUES
	('Big Ones'),
	('Number Ones'),
	('Collision Course'),
	('Rocket Man: The Definitive Hits');

-- Дополнение данных в таблицу "collections"
UPDATE
    collections 
SET
    release_year = '2005-07-19'
WHERE
    collection_id = 1;

UPDATE
    collections 
SET
    release_year = '2003-11-17'
WHERE
    collection_id = 2;

UPDATE
    collections 
SET
    release_year = '2007-03-23'
WHERE
    collection_id = 3;

UPDATE
    collections 
SET
    release_year = '2004-11-30'
WHERE
    collection_id = 4;

-- Вставка данных в таблицу "tracks_collections"
INSERT INTO
	tracks_collections(track_id, collection_id)
VALUES
	(1, 1),
	(3, 1),
	(6, 2),
	(7, 3),
	(8, 3),
	(12, 2),
	(14, 2),
	(16, 2),
	(18, 1),
	(19, 1),
	(21, 3),
	(23, 2),
	(25, 3),
	(27, 3),
	(29, 1);
