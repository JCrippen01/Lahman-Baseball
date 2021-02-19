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




