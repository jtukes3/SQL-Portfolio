--In this project I pulled info from the source listed below that contained data about the NBA Players of the week winners from Oct 20, 1979 - Mar 8, 2020. See the questions I asked and how I answered them below */ 
--Source: https://gist.github.com/pamelafox/6cda1115e2bcbc43e62cf4ff9d4158c7 */

/*What is the average age for winners of Player of the Week? Who was the oldest player to win and what was his age? Who was the youngest player to win and what was his age?*/
SELECT Round(AVG(Age),2) AS Average_Age FROM players; --Select average age of players of the week winners

SELECT Player, MAX(Age) AS Age FROM players; --Select player name and age of the player when they won player of the week at the oldest age

SELECT Player, MIN(Age) AS Age FROM players; --Select player name and age of the player when they won player of the week at the youngest age

/*What is the average age of winners for each team? Sort from youngest to oldest*/
SELECT Team, Round(AVG(Age),2) AS Average_Age FROM players --Select team names, rounded avg age of winners
GROUP BY TEAM --list each team on its own row with avg age of winners for that team
ORDER BY Average_Age ASC; --order list of teams by age from youngest to oldest

/*What is the average height of winners in FT?*/
SELECT ROUND((AVG(height_CM)/30.48), 2) AS Average_Height_FT FROM players; --took height in CM and created formula to convert it to FT to find avg height of winners
