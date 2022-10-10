CREATE DATABASE record_company;
USE record_company;

CREATE TABLE bands (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE albums (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  release_year INT,
  band_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (band_id) REFERENCES bands(id)
);

-- EXERCISES


-- 1. Create a Songs Table
        
CREATE TABLE songs(
id INT NOT NULL AUTO_INCREMENT,
name  VARCHAR(255) NOT NULL,
length FLOAT NOT NULL,
album_id INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (album_id) REFERENCES albums(id)
);

-- Make sure to run the data file attached.
-- This will insert all the values in the tables.


-- 2. Select only the Names of all the Bands

SELECT name AS 'Band Name'
FROM bands;


-- 3. Select the Oldest Album

SELECT *
FROM albums
WHERE release_year IS NOT NULL
ORDER BY release_year
LIMIT 1;


-- 4. Get all Bands that have Albums

SELECT DISTINCT b.name as 'Band Name'
FROM bands b
JOIN albums a ON
	b.id = a.band_id;
    
    
-- 5. Get all Bands that have No Albums

SELECT b.name as 'Band Name'
FROM bands b
LEFT JOIN albums a ON
	b.id = a.band_id
GROUP BY a.band_id
HAVING COUNT(a.id) = 0;

-- Alternate Solution

SELECT b.name as 'Band Name'
FROM bands b
LEFT JOIN albums a ON
	b.id = a.band_id
WHERE a.id IS NULL;



-- 6. Get the Longest Album

SELECT a.name AS 'Name', 
	   a.release_year as 'Release Year', 
       SUM(s.length) AS Duration
FROM songs s
JOIN albums a ON 
	s.album_id = a.id
GROUP BY a.id
ORDER BY Duration DESC
LIMIT 1;


-- 7. Update the Release Year of the Album with no Release Year
-- Mandatory: UPDATE A TABLE THAT HAS A PRIMARY KEY USING THE PRIMARY KEY
  
-- UPDATE THE VALUE TO BE 1986

UPDATE albums
SET release_year = 1986
WHERE id =
			(SELECT id
			FROM albums a
			WHERE release_year IS NULL);


-- 8.Insert a record for your favorite Band and one of their Albums	

INSERT INTO bands(name)
VALUES('Mani & Band');

-- USING SUBQUERY INORDER TO FETCH THE BAND_ID
INSERT INTO albums(name, release_year, band_id)
VALUES('Love for Music', 2015, 
					(SELECT bands.id
					FROM bands
					WHERE name = 'Mani & Band'));


-- 9. Delete the Band and Album you added in #8

-- DELETE THE ALBUM FIRST (IT IS OBVIOUS THAT THE ALBUM CAN'T EXIST WTTHOUT THE BAND)

-- FETCHING THE ID
SELECT id
FROM albums 
ORDER BY id DESC 
LIMIT 1;

DELETE FROM albums
WHERE id = 21;

-- DELETING THE BAND

-- FETCHING THE ID
SELECT *
FROM bands
ORDER BY id DESC 
LIMIT 1;

DELETE FROM bands
WHERE id = 8;



-- 10. Get the Average Length of all Songs

SELECT AVG(s.length) AS 'Average Song Duration'
FROM songs s;


-- 11. Select the longest Song off each Album

SELECT a.name as 'Album',
	   a.release_year AS 'Release Year',
       MAX(s.length) as 'Duration'
FROM albums a
JOIN songs s ON 
		a.id = s.album_id
GROUP BY a.id;


-- 12. Get the number of Songs for each Band

SELECT b.name as 'Band Name',
	   COUNT(s.id) AS 'Number of Songs'
FROM albums a
JOIN bands b ON 
		b.id = a.band_id
JOIN songs s ON 
		a.id = s.album_id
GROUP BY b.id
ORDER BY COUNT(s.id) DESC;














