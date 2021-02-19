/* Q7
From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 
What is the smallest number of wins for a team that did win the world series? 
Doing this will probably result in an unusually small number of wins for a world series champion – determine why this is the case. 
Then redo your query, excluding the problem year. 
How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? What percentage of the time?*/

-- Mahesh
WITH most_no_win AS (SELECT name, w, wswin, yearid
					 FROM teams
					 WHERE yearid BETWEEN 1970 AND 2016
					 	   AND wswin = 'N'
					 	   AND yearid <> 1981
					 ORDER BY w DESC
					 LIMIT 1),
	 least_win AS (SELECT name, w, wswin, yearid
				   FROM teams
				   WHERE yearid BETWEEN 1970 AND 2016
				   	   	 AND wswin = 'Y'
					 	 AND yearid <> 1981
				   ORDER BY w
				   LIMIT 1)
SELECT *
FROM most_no_win
UNION ALL
SELECT *
FROM least_win;

--How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? What percentage of the time?*/
WITH ws_wins AS (SELECT name, w, wswin, yearid
					 FROM teams
					 WHERE yearid BETWEEN 1970 AND 2016
					 	   AND wswin = 'Y'
					 ORDER BY w DESC),
	 most_wins AS (SELECT MAX(w) AS w, yearid
				   FROM teams
				   WHERE yearid BETWEEN 1970 AND 2016
				   GROUP BY yearid)
SELECT 2016-1970 AS total_seasons, COUNT(*) AS most_win_ws, (COUNT(*)::float/(2016-1970)::float)*100 AS pct_ws_most
FROM most_wins INNER JOIN ws_wins USING(yearid)
WHERE most_wins.w = ws_wins.w;


-- Katie answer
SELECT yearid, teamid, MAX(w) as max_wins
FROM teams
WHERE 
	yearid BETWEEN 1970 AND 2016
	AND teamid NOT IN (
	SELECT teamid
	FROM teams
	WHERE wswin = 'Y' 
	AND yearid >= 1970 AND yearid <=2016)
GROUP BY yearid, teamid
ORDER BY MAX(w)DESC
LIMIT 1;


-- What is the smallest number of wins for a team that did win the world series? 

SELECT yearid, teamid, MIN(w) as min_wins
FROM teams
WHERE 
	yearid BETWEEN 1970 AND 2016
	AND teamid IN (
	SELECT teamid
	FROM teams
	WHERE wswin = 'Y' 
	AND yearid BETWEEN 1970 AND 2016)
GROUP BY yearid, teamid
ORDER BY MIN(w)
LIMIT 1;


/*Then redo your query, excluding the problem year. 
How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? What percentage of the time?*/

SELECT yearid, teamid, MIN(w) as min_wins
FROM teams
WHERE (yearid BETWEEN 1970 AND 1980 OR yearid BETWEEN 1982 AND 2016)
	AND teamid IN (
	SELECT teamid
	FROM teams
	WHERE wswin = 'Y' 
	AND yearid BETWEEN 1970 AND 2016)
GROUP BY yearid, teamid
ORDER BY MIN(w)
LIMIT 1;
