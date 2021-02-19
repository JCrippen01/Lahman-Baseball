--q12
-- In this question, you will explore the connection between number of wins and attendance.
-- Does there appear to be any correlation between attendance at home games and number of wins?
-- Do teams that win the world series see a boost in attendance the following year?
-- What about teams that made the playoffs?
-- Making the playoffs means either being a division winner or a wild card winner.

-- Mahesh

SELECT CORR(homegames.attendance, w) AS corr_attend_w
FROM teams INNER JOIN homegames ON teamid = team AND yearid = year
WHERE homegames.attendance IS NOT NULL
---
SELECT AVG(hg_2.attendance - hg_1.attendance) AS avg_attend_increase,
	   stddev_pop(hg_2.attendance - hg_1.attendance) AS stdev_attend_increase,
	   MAX(hg_2.attendance - hg_1.attendance) AS max_attend_increase,
	   MIN(hg_2.attendance - hg_1.attendance) AS min_attend_increase
FROM teams INNER JOIN homegames AS hg_1 ON teams.yearid = hg_1.year AND teams.teamid = hg_1.team
	 	   INNER JOIN homegames AS hg_2 ON teams.yearid + 1 = hg_2.year AND teams.teamid = hg_2.team
WHERE wswin = 'Y'
	  AND hg_1.attendance > 0
	  AND hg_2.attendance > 0;
---
SELECT AVG(hg_2.attendance - hg_1.attendance) AS avg_attend_increase,
	   stddev_pop(hg_2.attendance - hg_1.attendance) AS stdev_attend_increase,
	   MAX(hg_2.attendance - hg_1.attendance) AS max_attend_increase,
	   MIN(hg_2.attendance - hg_1.attendance) AS min_attend_increase
FROM teams INNER JOIN homegames AS hg_1 ON teams.yearid = hg_1.year AND teams.teamid = hg_1.team
	 INNER JOIN homegames AS hg_2 ON teams.yearid + 1 = hg_2.year AND teams.teamid = hg_2.team
WHERE (divwin = 'Y' OR wcwin = 'Y')
	  AND hg_1.attendance > 0
	  AND hg_2.attendance > 0;