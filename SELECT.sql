-- Название и продолжительность самого длительного трека
WITH MinDuration AS (
    SELECT MAX(duration) AS min_duration
    FROM tracks
)
SELECT
    track_title,
    duration
FROM
    tracks
JOIN
    MinDuration ON duration = MinDuration.min_duration
ORDER BY
	duration;


-- Название треков, продолжительность которых не менее 3,5 минут.
SELECT
	track_title,
	duration
FROM
	tracks
WHERE
	duration >= 210
ORDER BY
	duration;

-- Названия сборников, вышедших в период с 2004 по 2006 год включительно.
SELECT
	collection_title
FROM
	collections
WHERE
	EXTRACT(YEAR FROM release_year) BETWEEN 2004 AND 2006;

-- Исполнители, чьё имя состоит из одного слова
SELECT
	nickname
FROM
	artists
WHERE
	NOT nickname LIKE '% %';

-- Название треков, которые содержат слово «мой» или «my»(используем регулярные выражения)
SELECT
	track_title
FROM
	tracks
WHERE
	track_title ~* '(^|\s)my(\s|$)|(^|\s)мой(\s|$)';

-- Количество исполнителей в каждом жанре
SELECT
	COUNT(ga.artist_id) AS total_atrists,
	g.genre_name
FROM
	genres AS g
JOIN
	genres_artists AS ga ON g.genre_id = ga.genre_id
GROUP BY
	g.genre_name;

-- Количество треков, вошедших в альбомы 2020–2021 годов
SELECT
	COUNT(t.track_title) AS total_tracks
FROM
	tracks AS t
JOIN
	albums AS a ON t.album_id = a.album_id
WHERE
	EXTRACT(YEAR FROM a.release_year) IN (2020, 2021);

-- Средняя продолжительность треков по каждому альбому
SELECT
	ROUND(AVG(t.duration), 1) AS avg_duration,
	a.album_title
FROM
	tracks AS t
JOIN
	albums AS a ON t.album_id = a.album_id
GROUP BY
	a.album_title;

-- Все исполнители, которые не выпустили альбомы в 2021 году
SELECT
	ar.nickname
FROM
	artists AS ar
WHERE
	ar.artist_id NOT IN(
		SELECT	
			aa.artist_id
		FROM
			artists_albums AS aa
		JOIN
			albums AS al ON aa.album_id = al.album_id
		WHERE
			EXTRACT(YEAR FROM al.release_year) = 2021);

-- Названия сборников, в которых присутствует исполнитель Linkin park
SELECT DISTINCT
	c.collection_title
FROM
	collections AS c
JOIN
	tracks_collections AS tc ON c.collection_id = tc.collection_id
JOIN
	tracks AS t ON t.track_id = tc.track_id
JOIN
	albums AS al ON t.album_id = al.album_id
JOIN
	artists_albums AS aa ON al.album_id = aa.album_id
JOIN
	artists AS ar ON ar.artist_id = aa.artist_id
WHERE
	ar.nickname = 'Linkin park';
	
-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра
SELECT DISTINCT
	al.album_title
FROM
	albums AS al
JOIN
	artists_albums AS aa ON al.album_id = aa.album_id
JOIN
	artists AS ar ON ar.artist_id = aa.artist_id
JOIN
	genres_artists AS gr ON ar.artist_id = gr.artist_id
JOIN
	genres AS g ON gr.genre_id = g.genre_id
GROUP BY
	al.album_title
HAVING
	COUNT(gr.genre_id) = 2;

-- Наименования треков, которые не входят в сборники
SELECT
	t.track_title
FROM
	tracks AS t
WHERE
	t.track_id NOT IN(
		SELECT
			t.track_id
		FROM
			tracks AS t
		LEFT JOIN
			tracks_collections AS tc ON tc.track_id = t.track_id
		WHERE
			tc.collection_id IN (1, 2 ,3));

-- Исполнитель или исполнители, написавшие самый короткий по продолжительности трек(гугл в помощь)
WITH MinDuration AS (
    SELECT MIN(duration) AS min_duration
    FROM tracks
)
SELECT
    ar.nickname,
    t.track_title,
    t.duration
FROM
    artists AS ar
JOIN
    artists_albums AS aa ON ar.artist_id = aa.artist_id
JOIN
    albums AS al ON aa.album_id = al.album_id
JOIN
    tracks AS t ON al.album_id = t.album_id
JOIN
    MinDuration ON t.duration = MinDuration.min_duration
ORDER BY
	t.duration;

-- Названия альбомов, содержащих наименьшее количество треков(гугл в помощь)
WITH AlbumTrackCounts AS (
    SELECT
        al.album_id,
        al.album_title,
        COUNT(t.track_id) AS track_count
    FROM
        albums AS al
    LEFT JOIN
        tracks AS t ON al.album_id = t.album_id
    GROUP BY
        al.album_id, al.album_title
)
SELECT
    atc.album_title
FROM
    AlbumTrackCounts AS atc
WHERE
    atc.track_count = (SELECT MIN(track_count) FROM AlbumTrackCounts);
	
