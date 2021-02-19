/*Q3
Find all players in the database who played at Vanderbilt University. 
Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. 
Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?*/


--Mahesh answers
SELECT DISTINCT concat(p.namefirst, ' ', p.namelast) AS name, sc.schoolname,
  SUM(sa.salary) OVER (PARTITION BY concat(p.namefirst, ' ', p.namelast))::numeric::money AS total_salary
  FROM people AS p INNER JOIN collegeplaying AS cp ON p.playerid = cp.playerid
  INNER JOIN schools AS sc ON cp.schoolid = sc.schoolid
  INNER JOIN salaries AS sa ON p.playerid = sa.playerid
  WHERE cp.schoolid = 'vandy'
  GROUP BY name, schoolname, sa.salary, sa.yearid
  ORDER BY total_salary DESC;
  




-- Caleb code

WITH vandy_salaries as (SELECT DISTINCT namefirst AS namefirst, namelast, schoolid, salaries.yearid AS yearid, salary
						 FROM people INNER JOIN collegeplaying USING(playerid)
						 INNER JOIN salaries USING(playerid)
						 WHERE schoolid = 'vandy'
						 ORDER BY namefirst, namelast, yearid)
SELECT namefirst, namelast, schoolid, SUM(salary)::text::money AS total_salary
FROM vandy_salaries
GROUP BY namefirst, namelast, schoolid
ORDER BY total_salary DESC;

-- David Price earned the most money $81,851,296
