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


SELECT TOP 2 p.Title, p.Text, a.Name
FROM Poem p
LEFT JOIN Author a ON p.AuthorId = a.Id
INNER JOIN Grade g ON a.GradeId = g.Id
WHERE p.Text LIKE '%hotdogs%';