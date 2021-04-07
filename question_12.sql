/* Q12 In this question, you will explore the connection between number of wins and attendance.

Does there appear to be any correlation between attendance at home games and number of wins? 

As you scroll through the results and see the average attendance numbers decrease
you would expect to see percent_wins also decrease if they were correlated, but that is
not the case so there doesn't appear to be a correlation between home game attendance
and number of wins */
WITH calculation AS(
	SELECT 
		yearID, 
		teamID, 
		g AS total_games,  
		W as wins, 
		ROUND(100*w/g,2) AS percent_win,
		COALESCE(attendance,0) AS home_attendance_total,
		park
	FROM teams)
SELECT 
	ROUND(AVG(home_attendance_total),2) AS avg_home_attendance,
	percent_win
FROM calculation
GROUP BY percent_win 
ORDER BY AVG(home_attendance_total) DESC;


/* Do teams that win the world series see a boost in attendance the following year?  */
SELECT 
	t.yearid,
	t.teamid,
	SUM(h.attendance) AS attendance_wswin_yr,
	SUM(h2.attendance) AS yr_after_attendance,
	SUM(h2.attendance) - SUM(h.attendance) AS attendance_diff
FROM teams AS t
JOIN homegames AS h
ON t.teamid=h.team AND t.yearid=h.year
JOIN homegames AS h2
ON t.teamid=h2.team and (t.yearid+1)=h2.year
WHERE wswin = 'Y'
GROUP BY t.yearid, t.teamid
ORDER BY yearid

/* What about teams that made the playoffs? 
Making the playoffs means either being a division winner or a wild card winner.  */
SELECT 
	t.yearid,
	t.teamid,
	SUM(h.attendance) AS attendance_divwin_yr,
	SUM(h2.attendance) AS yr_after_attendance,
	SUM(h2.attendance) - SUM(h.attendance) AS attendance_diff
FROM teams AS t
JOIN homegames AS h
ON t.teamid=h.team AND t.yearid=h.year
JOIN homegames AS h2
ON t.teamid=h2.team and (t.yearid+1)=h2.year
WHERE DivWin = 'Y' OR WcWin = 'Y'
GROUP BY t.yearid, t.teamid
ORDER BY yearid

