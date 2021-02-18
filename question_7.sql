/* Q7 */

-- From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 
SELECT yearid, teamid, MAX(w) as max_wins
FROM teams
WHERE 
	yearid >= 1970 AND yearid <=2016
	AND teamid NOT IN (
	SELECT teamid
	FROM teams
	WHERE wswin = 'Y' 
	AND yearid >= 1970 AND yearid <=2016)
GROUP BY yearid, teamid
ORDER BY MAX(w)DESC
LIMIT 1;

/*What is the smallest number of wins for a team that did win the world series? 
Doing this will probably result in an unusually small number of wins for a world series champion – 
determine why this is the case. Then redo your query, excluding the problem year. 
The smallest number of wins was in 1981 with the Toronto Blue Jays with 37 wins.
1981 was the year of the player's strike and the season was cut short. */
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

/* when you remove 1981 from the query, the lowest number of 
wins is from Detroit Tigers in 2003 with 43 wins*/
SELECT yearid, teamid, MIN(w) as min_wins
FROM teams
WHERE BETWEEN 1970 AND 1980 OR yearid BETWEEN 1982 AND 2016)
	AND teamid IN (
	SELECT teamid
	FROM teams
	WHERE wswin = 'Y' 
	AND yearid BETWEEN 1970 AND 2016)
GROUP BY yearid, teamid
ORDER BY MIN(w)
LIMIT 1;

/* How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? 
What percentage of the time?  */
WITH most_wins AS (
	SELECT 
		yearid,
		MAX(w) AS max_w
	FROM teams
	WHERE yearid BETWEEN 1970 AND 2016
	GROUP BY yearid
	ORDER BY yearid),
ws_wins AS (
	SELECT
		yearid,
		teamid
	FROM teams
	WHERE wswin = 'Y'
		AND yearid BETWEEN 1970 AND 2016),
teams_most_wins AS (
	SELECT t.yearid,
	t.teamid
	FROM teams AS t
	INNER JOIN most_wins
	ON t.yearid = most_wins.yearid AND t.w = most_wins.max_w),
combined_stats AS (
SELECT
	teams_most_wins.yearid,
	teams_most_wins.teamid AS most_wins_team,
	ws_wins.teamid AS ws_wins_team
FROM teams_most_wins
LEFT JOIN ws_wins
USING(yearid)
ORDER BY yearid)
SELECT
	COUNT(CASE WHEN cs.most_wins_team = cs.ws_wins_team THEN 1 END) AS count_most_wins_also_ws_winner,
	CONCAT(ROUND((100*COUNT(CASE WHEN cs.most_wins_team = cs.ws_wins_team THEN 1 END) / COUNT(DISTINCT yearid)::decimal),2),'%') AS percentage_most_wins_also_ws_winner
FROM combined_stats AS cs;





