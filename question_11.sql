/* Q11. Is there any correlation between number of wins and team salary? 
Use data from 2000 and later to answer this question. 
As you do this analysis, keep in mind that salaries across the whole league tend to increase together, so you may want to look on a year-by-year basis.*/

-- SELECT *
-- FROM salaries

-- SELECT *
-- FROM teams


SELECT t.yearid, t.teamid, sum(salary::decimal::money) AS salary
FROM salaries
JOIN teams AS t ON t.teamid = salaries.teamid AND t.yearid = salaries.yearid
WHERE t.yearid >= '2000'
GROUP BY  t.teamid, t.yearid
ORDER BY t.yearid, t.teamid
-- this works

-- now adding the wins

SELECT t.yearid, t.teamid, t.w as win, sum(salary::decimal::money) AS salary
FROM salaries
JOIN teams AS t ON t.teamid = salaries.teamid AND t.yearid = salaries.yearid
WHERE t.yearid >= '2000'
GROUP BY  t.teamid, t.yearid, win
ORDER BY t.teamid, t.yearid;
-- this code is correct, I checked the results online


-- Mahesh answer - he used a function correlation 
WITH team_year_sal_w AS (SELECT teamid, yearid, SUM(salary) AS total_team_sal, AVG(w)::integer AS w
						 FROM salaries INNER JOIN teams USING(yearid, teamid)
						 WHERE yearid >= 2000
						 GROUP BY yearid, teamid)
SELECT yearid, CORR(total_team_sal, w) AS sal_win_corr
FROM team_year_sal_w
GROUP BY yearid
ORDER BY yearid;
-- close to 0 means little correlation

