/* q10
Analyze all the colleges in the state of Tennessee. 
Which college has had the most success in the major leagues. 
Use whatever metric for success you like - number of players, number of games, salaries, world series wins, etc.*/

SELECT * 
FROM schools
WHERE schoolstate = 'TN'
-- schoolid, schoolname, schoolstate - 39rows


-- success = number of players who won the world series

SELECT yearid, lgid, teamid, name, wswin
FROM teams
WHERE wswin = 'Y'
-- yearid, teamid, name, wswin, lgid

SELECT *
FROM collegeplaying
--playerid, schoolid, yearid

select * from people 
-- playerid, namefirst, namelast

SELECT s.schoolid, s.schoolname, s.schoolstate, cp.playerid, CONCAT(namefirst, ' ', namelast) as player_name, teams.wswin, cp.schoolid, cp.yearid
FROM schools as s	INNER JOIN collegeplaying as cp ON cp.schoolid = s.schoolid
					INNER JOIN teams ON teams.yearid = cp.yearid
					INNER JOIN people ON people.playerid = cp.playerid
WHERE s.schoolstate = 'TN'
AND wswin = 'Y';
-- this works


SELECT CONCAT(namefirst, ' ', namelast) as player_name, cp.yearid
FROM schools as s	INNER JOIN collegeplaying as cp ON cp.schoolid = s.schoolid
					INNER JOIN teams ON teams.yearid = cp.yearid
					INNER JOIN people ON people.playerid = cp.playerid
WHERE s.schoolstate = 'TN'
AND wswin = 'Y'
-- TN won the world series 382 times between 1903 and 2011

-- Which college has had the most success in the major leagues. 
SELECT s.schoolname, CONCAT(namefirst, ' ', namelast) as player_name, teams.wswin, cp.schoolid, cp.yearid, count(schoolname) as college_win
FROM schools as s	INNER JOIN collegeplaying as cp ON cp.schoolid = s.schoolid
					INNER JOIN teams ON teams.yearid = cp.yearid
					INNER JOIN people ON people.playerid = cp.playerid
WHERE s.schoolstate = 'TN'
AND wswin = 'Y'
GROUP BY s.schoolname, player_name, teams.wswin, cp.schoolid, cp.yearid
ORDER BY s.schoolname;

-- FINAL code showing how many times a school won in the WorldSeries
WITH cte_wins as
	(SELECT DISTINCT s.schoolname, CONCAT(namefirst, ' ', namelast) as player_name, teams.wswin, cp.yearid,
COUNT (schoolname) OVER (PARTITION BY schoolname) as Schoolnamewin
FROM schools as s	INNER JOIN collegeplaying as cp ON cp.schoolid = s.schoolid
					INNER JOIN teams ON teams.yearid = cp.yearid
					INNER JOIN people ON people.playerid = cp.playerid
WHERE s.schoolstate = 'TN'
AND wswin = 'Y')
SELECT  *
FROM cte_wins
ORDER BY schoolnamewin DESC;

WITH cte_wins as
	(SELECT DISTINCT s.schoolname, CONCAT(namefirst, ' ', namelast) as player_name, teams.wswin, cp.yearid,
COUNT (schoolname) OVER (PARTITION BY schoolname) as Schoolnamewin
FROM schools as s	INNER JOIN collegeplaying as cp ON cp.schoolid = s.schoolid
					INNER JOIN teams ON teams.yearid = cp.yearid
					INNER JOIN people ON people.playerid = cp.playerid
WHERE s.schoolstate = 'TN'
AND wswin = 'Y')
SELECT  DISTINCT schoolname, schoolnamewin
FROM cte_wins
ORDER BY schoolnamewin DESC;
