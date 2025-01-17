CREATE TABLE genres(
	genre_id SERIAL PRIMARY KEY,
	genre_name VARCHAR(32) UNIQUE NOT NULL
);

CREATE TABLE artists(
	artist_id SERIAL PRIMARY KEY,
	nickanme VARCHAR(128) NOT NULL
);

CREATE TABLE genres_artists(
	genre_artist_id SERIAL PRIMARY KEY,
	genre_id INTEGER REFERENCES genres(genre_id),
	artist_id INTEGER REFERENCES artists(artist_id)
);

CREATE TABLE albums(
	album_id SERIAL PRIMARY KEY,
	album_title VARCHAR(128) NOT NULL,
	releasy_year DATE NOT NULL
);

CREATE TABLE artists_albums(
	artists_albums_id SERIAL PRIMARY KEY,
	artist_id INTEGER REFERENCES artists(artist_id),
	album_id INTEGER REFERENCES albums(album_id)
);

CREATE TABLE tracks(
	track_id SERIAL PRIMARY KEY,
	track_title VARCHAR(128) NOT NULL,
	duration INTERVAL NOT NULL,
	album_id INTEGER REFERENCES albums(album_id)
);

CREATE TABLE collections(
	collection_id SERIAL PRIMARY KEY,
	collection_title VARCHAR(128) NOT NULL
);

CREATE TABLE tracks_collections(
	track_collection_id SERIAL PRIMARY KEY,
	track_id INTEGER REFERENCES tracks(track_id),
	collection_id INTEGER REFERENCES collections(collection_id)
);

ALTER TABLE collections
ADD COLUMN release_year DATE;

ALTER TABLE tracks
ADD CONSTRAINT check_duration_max
CHECK (duration <= MAKE_INTERVAL(mins => 4));

ALTER TABLE collections
ADD CONSTRAINT check_album_release_year
CHECK (EXTRACT(YEAR FROM release_year) >= 2000 AND EXTRACT(YEAR FROM release_year) <= EXTRACT(YEAR FROM CURRENT_DATE));

ALTER TABLE albums
RENAME COLUMN releasy_year TO release_year;

ALTER TABLE albums
ADD CONSTRAINT check_album_release_year
CHECK (EXTRACT(YEAR FROM release_year) >= 2000 AND EXTRACT(YEAR FROM release_year) <= EXTRACT(YEAR FROM CURRENT_DATE));







