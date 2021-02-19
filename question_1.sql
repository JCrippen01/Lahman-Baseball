/* q1
What range of years for baseball games played does the provided database cover?*/

SELECT MIN(yearid), MAX(yearid)
FROM appearances;
-- 1871 - 2016
--doing this would have been enough. No need to include college


SELECT MIN(yearid), MAX(yearid)
FROM collegeplaying;
-- 1864 - 2016

SELECT MIN(c.yearid), MAX(a.yearid)
FROM appearances AS a FULL JOIN collegeplaying as c 
	ON a.yearid = c.yearid;
