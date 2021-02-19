--Data interrogation 
SELECT *
FROM homegames
WHERE year = 1920
limit(5);

SELECT
	SUM(games) AS total_games
FROM homegames
WHERE year = 1920
SELECT yearid,teamid, so, g
FROM teams
WHERE yearid = 1920
--limit (5); 

SELECT SUM(g)
FROM teams
WHERE  yearid IN (1920)--, 1921, 1922)
--End interrogation 
------------------------------------------------------------------------------------------------------------------------
--Find the average number of strikeouts per game by decade since 1920. Round the numbers you report to 2 decimal places. Do the same for home runs per game. Do you see any trends?

--Answer to Question 5
--Strike outs
SELECT teams.yearid /10*10 as decade, sum(so) AS total_strike_out,
	   Sum(g) as total_games,
	   round(sum(so)::decimal / sum(g),2)::decimal as average_strike_out
	   FROM teams
	   WHERE yearid >= '1920'
	   GROUP BY yearid/10*10
	   ORDER BY decade DESC
	   
-- Home Runs
SELECT teams.yearid /10*10 as decade, sum(hr) AS homerun,
	   Sum(g) as total_games,
	   round(sum(hr)::decimal / sum(g),2)::decimal as average_homerun
	   FROM teams
	   WHERE yearid >= '1920'
	   GROUP BY yearid/10*10
	   ORDER BY decade DESC
--Combined
SELECT teams.yearid /10*10 as decade, sum(hr) AS homerun,
	   Sum(g) as total_games,
	   round(sum(hr)::decimal / sum(g),2)::decimal as average_homerun
	   FROM teams
	   WHERE yearid >= '1920'
	   GROUP BY yearid/10*10
	   ORDER BY decade DESC

--Check on per Decade using 1920
SELECT teams.yearid /10*10 as decade
FROM teams
GROUP BY yearid/10*10
ORDER BY decade DESC

SELECT yearid, teamid, g, hr, so
FROM teams
WHERE yearid = 1920
group by yearid, teamid, g, hr, so