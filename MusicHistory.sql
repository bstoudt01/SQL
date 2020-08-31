/*SELECT s.Title,
       a.ArtistName
  FROM Song s
       LEFT JOIN Artist a on s.ArtistId = a.id;
       */

       /*
SELECT
    Id,
    Title,
    SongLength,
    ReleaseDate,
    GenreId,
    ArtistId,
    AlbumId
FROM Song
WHERE SongLength > 100
Order by Title;
*/


/*1. All Genre */
Select *
from Genre;

/*2.  All Artist sorted by artist name */
Select *
from Artist
Order by ArtistName;

/*3. All Songs in table joined by artist name by artistId */
Select *
from Song
join Artist on Song.ArtistId = Artist.Id;

/*4. Write a SELECT query that lists all the Artists that have a Pop Album
All Artist who have a pop genre album*/
Select *
from Album 
join Artist on Album.ArtistId = Artist.Id
join Genre on Album.GenreId = Genre.Id
where Genre.Label = 'rock';

/*5. Write a SELECT query that lists all the Artists that have a Jazz or Rock Album
All Artist who have a rock or jazz genre album*/
Select *
from Album 
join Artist on Album.ArtistId = Artist.Id
join Genre on Album.GenreId = Genre.Id
where Genre.Label = 'jazz' OR Genre.Label = 'rock';


/*6.Write a SELECT statement that lists the Albums with no songs
the left join is important, join alone produced no results, we need to return all results from
Albums (left table) to Song (right table), if no results it will show null, and we then stated we only wanted results 
where song.AlbumId is null, so it only showed results where the value for that key was null
*/
Select *
from Album
left join Song on Album.Id = Song.AlbumId 
where Song.AlbumId IS NULL;


/*
Chris #4
 SELECT a.ArtistName
  FROM Album al
    LEFT JOIN Artist a ON a.Id = al.ArtistId
    LEFT JOIN Genre g ON g.id = al.GenreId
  WHERE g.Label = 'rock';
  */

  /*7. Using the INSERT statement, add one of your favorite artists to the Artist table.
  INSERT INTO tableName (key1, key2) VALUES ('varchar', int)
*/
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('MeatLoaf', 1992);
Select *
from Artist;

  /*8. Using the INSERT statement, add one, or more, albums by your artist to the Album table.
  INSERT INTO tableName (key1, key2) VALUES ('varchar', int)
*/
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId ) VALUES ('Bat out of Hell', '1/9/77', 240, 'Robert Paulsen Productions', 28,2 );
Select *
from Album;

/*9.Using the INSERT statement, add some songs that are on that album to the Song table.
 */
 INSERT INTO Song (Title, SongLength, ReleaseDate, ArtistId, GenreId, AlbumId ) VALUES ('Paradise by Dashbard Lights', 99 , '1/9/77', 28, 2, 23 )
 INSERT INTO Song (Title, SongLength, ReleaseDate, ArtistId, GenreId, AlbumId ) VALUES ('You took the Words Right out of My Mouth', 120 , '1/9/77', 28, 2, 23 )
Select *
from Song;

/*10.Write a SELECT query that provides the song titles, album title, and artist name for all of the data you just entered in. 
Use the LEFT JOIN keyword sequence to connect the tables, and the WHERE keyword to filter the results to the album and artist you added.
*/
/*values to be slected "displayed"*/
SELECT 
Artist.ArtistName,
Album.Title,
Song.Title
/*from table, if we join another table this table absorbes the direction
From table would be left table when using LEFT JOIN
The right table would be Song, now that we have Song table we will say 
ON each Song.ArtistId on the right set it equal to Artist.Id on the left
WHERE artistName = meatloaf*/
FROM Artist
LEFT JOIN Song ON Artist.Id = Song.ArtistId
LEFT JOIN Album ON Artist.Id = Album.ArtistId
WHERE Artist.ArtistName = 'meatloaf';

/*Examples of how to view can change for number 10 based on which table is left/right*/
/*shows all albums with songs, wihch includes NULL entries for songs*/
SELECT a.Title, s.Title FROM Album a LEFT JOIN Song s ON s.AlbumId = a.Id ;
/*shows all songs and their albums, the select shows the data with album on left and song on right 
to give orientation to how it relates to the previous example*/
SELECT a.Title, s.Title FROM Song s LEFT JOIN Album a ON s.AlbumId = a.Id;



/*11. Write a SELECT statement to display how many songs exist for each album. 
You'll need to use the COUNT() function and the GROUP BY keyword sequence...copy paste & refactor...

-Select: displays "album title" and "count of songs" that have contain the "albumID"
and then that key:value pair is stored as a "number of songs"
You get this information from "Album" joined by "Song""(.AlbumId)" on "Album.Id"
and then Grouping by "Album Title"
*/

SELECT Album.Title,COUNT(Song.AlbumId) AS NumberOfSongsPerAlbum FROM Album
LEFT JOIN Song ON Album.Id = Song.AlbumId
GROUP BY Album.Title;

/*12. Write a SELECT statement to display how many songs exist for each artist. 
You'll need to use the COUNT() function and the GROUP BY keyword sequence.*/

SELECT Artist.ArtistName,COUNT(Song.ArtistId) AS NumberOfSongsPerArtist FROM Artist
LEFT JOIN Song ON Artist.Id = Song.ArtistId
GROUP BY Artist.ArtistName;

/*13. Write a SELECT statement to display how many songs exist for each genre. 
You'll need to use the COUNT() function and the GROUP BY keyword sequence.*/

SELECT Genre.Label,COUNT(Song.GenreId) AS NumberOfSongsPerGenre FROM Genre
LEFT JOIN Song ON Genre.Id = Song.GenreId
GROUP BY Genre.Label

/*14. Write a SELECT query that lists the Artists that have put out records on more than one record label. 
Hint: When using GROUP BY instead of using a WHERE clause, use the HAVING keyword
DISTINCT only grabs unique instances, can be used as SELECT DISTINCT ....*/
SELECT Artist.ArtistName, COUNT(DISTINCT Album.Label) As ArtistProducedByManyLabels
FROM Album
INNER JOIN Artist ON Album.ArtistId = Artist.Id
GROUP BY Artist.ArtistName
HAVING COUNT(DISTINCT Album.Label) > 1;

/*15. Using MAX() function, write a select statement to find the album with the longest duration. 
The result should display the album title and the duration.
using the where statement we direct albumLength to equal the longest length in Albums*/
SELECT Title, AlbumLength
FROM Album
WHERE AlbumLength = (
    SELECT MAX(AlbumLength)
    FROM Album);

/*16. Using MAX() function, write a select statement to find the song with the longest duration. 
The result should display the song title and the duration.*/
SELECT Title, SongLength
FROM Song
WHERE SongLength = (
    SELECT MAX(SongLength)
    FROM Song);

    /*17. Modify the previous query to also display the title of the album.
    Added LEFT JOIN and used short syntax for my tables*/
SELECT a.Title, s.Title, S.SongLength
FROM Song s
LEFT JOIN Album a ON s.AlbumId = a.Id
WHERE SongLength = (
    SELECT MAX(SongLength)
    FROM Song);