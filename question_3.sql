/* 3. Find all players in the database who played at Vanderbilt University. 
Create a list showing each player’s first and last names as well as the total salary 
they earned in the major leagues. Sort this list in descending order by the total 
salary earned. Which Vanderbilt player earned the most money in the majors? */

SELECT 
	namefirst AS first_name, 
	namelast AS last_name,
	SUM(salary) AS total_major_league_salary
FROM people
JOIN collegeplaying
USING(playerid) 
JOIN salaries
USING (playerid)
WHERE schoolid = 
	(SELECT schoolid
	FROM schools
	WHERE schoolname iLIKE '%vand%')
GROUP BY namefirst,namelast
ORDER BY SUM(salary) DESC;
