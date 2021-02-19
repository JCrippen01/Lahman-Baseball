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
--playerif, schoolid, yearid

SELECT s.schoolid, s.schoolname, s.schoolstate, cp.playerid, cp.schoolid, cp.yearid
FROM schools as s
INNER JOIN collegeplaying as cp ON cp.schoolid = s.schoolid
WHERE s.schoolstate = 'TN'
INNER JOIN teams ON teams.yearid = cp.yearid