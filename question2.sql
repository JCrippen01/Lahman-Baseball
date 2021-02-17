/*Question 2. Find the name and height of the shortest player in the database. How many games did he play in? What is the name of the team for which he played?*/

-- Name and height of the shortest player

SELECT CONCAT(namefirst,' ', namelast) AS name, height
FROM people
ORDER BY height;
-- Eddie Gaedel is 4"3

-- How many games did he play in
SELECT CONCAT(namefirst,' ', namelast) AS name, people.playerid, height, G_all
FROM people JOIN appearances ON people.playerid = appearances.playerid
ORDER BY height;
-- Eddie played in 1 game

-- What is the name of the team for which he played
SELECT CONCAT(namefirst,' ', namelast) AS name, people.playerid, height, G_all, teams.name
FROM people 
	INNER JOIN appearances 
		ON people.playerid = appearances.playerid
	INNER JOIN teams 
		ON teams.teamid = appearances.teamid
ORDER BY height;
-- Eddie played for the St. Louis Browns