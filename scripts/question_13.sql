/*It is thought that since left-handed pitchers are more rare, causing batters to face them less often,
that they are more effective.Investigate this claim and present evidence to either support or dispute
this claim.

First, determine just how rare left-handed pitchers are compared with right-handed pitchers.
Are left-handed pitchers more likely to win the Cy Young Award? Are they more likely to make
it into the hall of fame?*/


--NOTES:
/*WHIP
K/BB
Quality Start
K/9
What is ERA:ERA is the most commonly accepted statistical tool for evaluating pitchers.
The formula for finding ERA is: 9 x earned runs / innings pitched. 
If a pitcher exits a game with runners on base, any earned runs scored by those runners 
will count against him. ERA should be an ideal evaluation of pitchers.

"Pitching Triple Crown" refers to the pitching achievement of leading a league in wins, strikeouts,
 and earned run average (ERA).*/

---Get Throwing arm from People table
	---By player ID

SELECT *--playerid, throws
FROM people
limit 2

SELECT * --playerid, yearid, era
FROM pitching
WHERE era IS NOT NULL AND era > 0
ORDER BY era 
--limit 50
SELECT *
FROM 

--How I want to see info

/*
List Multiple winners of Cy young
Pitchers, #of Awards, Throws, years
Clemens		7           R		1986, 1987, 1991, 1997, 1998, 2001, 2004
List Triple Crown winners and throws.
List Cy Youngs and Throws.
List by YEAR, NAME,    THROWS, TEAM, RECORD, SAVES, ERA, K's
        1967  Mike MC			SFG    22-10   0     2.85  150 */

--Testing area
SELECT * 
FROM awardsshareplayers
limit 50

SELECT playerid, awardid, yearid,
FROM awardsplayers
WHERE awardid = 'Pitching Triple Crown'
ORDER BY yearid DESC
------------------------------------------------------------
--Triple Crown, add team
SELECT CONCAT(namelast,', ',namefirst),throws, awardid, yearid
FROM awardsplayers AS a
INNER JOIN people AS p
USING (playerid)
WHERE awardid = 'Pitching Triple Crown'
ORDER BY yearid DESC
---------------------------------------------------------------
--Cy Young, add team
SELECT CONCAT(namelast,', ',namefirst),throws, awardid, cy.yearid
FROM awardsshareplayers AS cy
INNER JOIN people AS p
USING (playerid)
WHERE awardid = 'Cy Young'
ORDER BY yearid DESC
-----------------------------------------------------------------
--Pitching by ERA
SELECT CONCAT(namelast,', ',namefirst)AS pitcher, yearid, teamid, g, so, w, l, sv, era,
FROM pitching
INNER JOIN people AS p
USING (playerid)
limit 5

