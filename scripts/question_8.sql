SELECT * 
FROM parks
--FROM teams
Limit 100

/*Using the attendance figures from the homegames table,
find the teams and parks which had the top 5 average attendance per game in 2016
(where average attendance is defined as total attendance divided by number of games).*/

SELECT year, team, park_name,league, games, h.attendance, --t.name,
	   (h.attendance / games) AS a_per_game
FROM homegames AS h
INNER JOIN parks AS p
ON h.park = p.park
--JOIN teams AS t
--ON h.team = t.teamid
WHERE year = 2016
ORDER BY a_per_game DESC
limit 5;

/*Only consider parks where there were at least 10 games played. Report the park name,
team name, and average attendance. Repeat for the lowest 5 average attendance.*/

SELECT year, team, park_name,league, games, h.attendance, --t.name,
	   (h.attendance / games) AS a_per_game
FROM homegames AS h
INNER JOIN parks AS p
ON h.park = p.park
--JOIN teams AS t
--ON h.team = t.teamid
WHERE year = 2016 AND games > 10
ORDER BY a_per_game
limit 5;

