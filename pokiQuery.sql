/*1. What grades are stored in the database?*/
SELECT *
FROM Grade;

/*2. What emotions may be associated with a poem?*/
SELECT *
FROM Emotion;

/*3. How many poems are in the database?*/
SELECT Count(Poem.Id)
FROM Poem;

/*4. Sort authors alphabetically by name. What are the names of the top 76 authors? */
SELECT TOP 76 Author.Name, Count(DISTINCT Author.Name) as PoemsWritten
FROM Author
GROUP BY Name 
ORDER BY Author.Name;

/*5. Starting with the above query, add the grade of each of the authors.*/
SELECT TOP 76 Author.Name, Grade.Name
FROM Author
LEFT JOIN Grade ON Author.GradeId = Grade.Id
GROUP BY Author.Name, Grade.Name
ORDER BY Author.Name;

/*6. Starting with the above query, add the recorded gender of each of the authors.
includes NA items, NULL items, and then male or female*/
SELECT TOP 76 Author.Name, Grade.Name AS Grade, Gender.Name AS Gender
FROM Author
LEFT JOIN Grade ON Author.GradeId = Grade.Id
LEFT JOIN Gender on Author.GenderId = Gender.Id
GROUP BY Author.Name, Grade.Name, Gender.Name
ORDER BY Author.Name;

/*7. What is the total number of words in all poems in the database? 
- this is INCORRECT, since the wordCount column is not correct, should we count spaces?*/
SELECT Sum(WordCount)
FROM Poem;

/*8. Which poem has the fewest characters?*/
SELECT Min(CharCount)
FROM Poem;

/*9. How many authors are in the third grade?*/
SELECT Count(Author.GradeId) Grade
FROM Author
JOIN Grade ON Author.GradeId = Grade.Id
WHERE Grade.Name = '3rd grade';

/*10. How many authors are in the first, second or third grades?*/
SELECT g.Name, Count(a.Id) AS AuthorCount
FROM Grade g
LEFT JOIN Author a ON g.Id = a.GradeId
WHERE g.id < 4
GROUP BY g.Name;

/*11. What is the total number of poems written by fourth graders? 10806*/
SELECT Count(p.Id)
FROM Poem p
LEFT JOIN Author a ON p.AuthorId = a.Id
LEFT JOIN Grade g on a.GradeId = g.Id
WHERE g.Name= '4th grade';

/*12. How many poems are there per grade? */
SELECT g.Name, Count(p.Id) AS poemCount
FROM Grade g
LEFT JOIN Author a ON g.Id = a.GradeId
LEFT JOIN Poem p ON a.id = p.AuthorId
GROUP BY g.Name;

/*13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)*/
SELECT g.Name, Count(a.Id) AS AuthorCount
FROM Grade g
LEFT JOIN Author a ON g.Id = a.GradeId
GROUP BY g.Name
ORDER BY g.Name;

/*14. What is the title of the poem that has the most words?*/
SELECT Title, MAX(p.WordCount) Words
FROM Poem p
WHERE p.WordCount = 
(SELECT MAX(WordCount)
    FROM Poem)
GROUP BY p.Title;

/*15. Which author(s) have the most poems? (Remember authors can have the same name.)*/
SELECT a.Id, a.Name, Count(p.AuthorId) AS MostPoems
FROM Poem p
LEFT JOIN Author a ON p.AuthorId = a.Id
GROUP BY a.Id, a.Name
ORDER BY MostPoems DESC;

/*16. How many poems have an emotion of sadness? 14570 */
SELECT Count(e.Name) sadnessPoems
FROM PoemEmotion pe
LEFT JOIN Emotion e ON pe.EmotionId = e.Id
WHERE e.Name = 'sadness';

/*17. How many poems are not associated with any emotion? 3368*/

SELECT Count(p.Id) NoEmotion
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
WHERE pe.EmotionId  IS NULL;


/*18. Which emotion is associated with the least number of poems? */
SELECT TOP 1 e.Name Emotion, COUNT(p.Id) poemsWithEmotion
FROM PoemEmotion pe
LEFT JOIN Emotion e ON pe.EmotionId = e.Id
LEFT JOIN Poem p ON pe.PoemId = p.Id
GROUP BY e.Name
ORDER BY e.Name;

/*19. Which grade has the largest number of poems with an emotion of joy?
I tihnk this works correctly, i gathered the grades and linked it to emotion
and said where emotion = joy to include the grade.id in the Count for that grade in the SELECT 
and then to show the top result from a descedning order based on the Count*/
SELECT TOP 1 g.Name, Count(g.id)
FROM Grade g
LEFT JOIN Author a ON g.Id =a.GradeId
LEFT JOIN Poem p ON a.Id = p.AuthorId
LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
LEFT JOIN Emotion e ON pe.EmotionId = e.Id 
WHERE e.Name ='joy'
GROUP BY g.Name
ORDER BY Count(g.id) DESC;

/*20. Which gender has the least number of poems with an emotion of fear ? - Ambiguous*/
SELECT TOP 1 g.Name, Count(g.id) fear
FROM Gender g
LEFT JOIN Author a ON g.Id =a.GenderId
LEFT JOIN Poem p ON a.Id = p.AuthorId
LEFT JOIN PoemEmotion pe ON p.Id = pe.PoemId
LEFT JOIN Emotion e ON pe.EmotionId = e.Id 
WHERE e.Name ='fear'
GROUP BY g.Name
ORDER BY Count(g.id);




/*David Larsen, plagerism catch*/
SELECT TOP 2 p.Title, p.Text, a.Name
FROM Poem p
LEFT JOIN Author a ON p.AuthorId = a.Id
INNER JOIN Grade g ON a.GradeId = g.Id
WHERE p.Text LIKE '%hotdogs%';

/*David Bruce - funny poem*/ 
SELECT Author.Name, Grade.Name, Emotion.Name as "Emotion", Poem.Title, Poem.TEXT
FROM Poem 
 JOIN Author on Author.Id = Poem.AuthorId
 JOIN Grade on Grade.Id = Author.GradeId
 JOIN PoemEmotion on Poem.Id = PoemEmotion.PoemId
 JOIN Emotion on Emotion.Id = PoemEmotion.EmotionId
WHERE Poem.TEXT LIKE '%pig% tree%dog%' and Emotion.Name = 'Sadness' and Grade.Name = '5th Grade'
ORDER BY Poem.Title DESC;