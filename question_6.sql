/* Q6
Find the player who had the most success stealing bases in 2016, where success is measured as the percentage of stolen base attempts which are successful. 
(A stolen base attempt results either in a stolen base or being caught stealing.) Consider only players who attempted at least 20 stolen bases.*/

-- Joanna code
WITH steal_attempts AS
	(SELECT DISTINCT playerid, cs AS caught_stealing, sb AS stolen_bases,
	 (cs + sb) AS steal_attempts
	 FROM batting
	 WHERE cs + sb <> 0 AND yearid = 2016), -- there are no playerid duplicates here, math adding up
    success_rate AS
	(SELECT DISTINCT bs.playerid, sa.caught_stealing, 
	 sa.stolen_bases, ROUND((sa.stolen_bases::decimal/sa.steal_attempts::decimal)::decimal, 4) AS success_rate
	FROM batting AS bs
	INNER JOIN steal_attempts AS sa
	ON bs.playerid = sa.playerid
	WHERE cs + sb <> 0 AND yearid = 2016)
SELECT DISTINCT bs.playerid, ppl.namelast, ppl.namefirst, sa.steal_attempts, sr.success_rate, bs.cs AS caught_stealing, bs.sb AS stolen_bases, bs.yearid, bs.teamid
FROM batting as bs
	 INNER JOIN people as ppl
	 ON bs.playerid = ppl.playerid
	 INNER JOIN steal_attempts as sa
	 ON bs.playerid = sa.playerid
	 INNER JOIN success_rate as sr
	 ON bs.playerid = sr.playerid
WHERE bs.yearid = 2016 AND sa.steal_attempts >= 20
ORDER BY sr.success_rate DESC, sa.steal_attempts DESC;


--Tobia answer
SELECT DISTINCT b.playerid, 
				CONCAT(p.namefirst,' ',p.namelast) AS player_name, 
				(b.sb) AS stolen_bases, 
				(b.cs) AS caught_stealing, 
				b.sb+b.cs AS sb_cs, 
				ROUND(CAST(float8 (b.sb/(b.sb+b.cs)::float*100) AS NUMERIC),2) AS successful_stolen_bases_percent
FROM batting AS b
LEFT JOIN people AS p 
ON b.playerid = p.playerid
WHERE b.yearid = '2016'
GROUP BY b.playerid, p.namefirst, p.namelast, b.sb, b.cs
HAVING SUM(b.sb+b.cs) >= 20
ORDER BY successful_stolen_bases_percent DESC


-- Tim code
select  distinct(p.playerid),
		p.namefirst, p.namelast,
		a.yearid, b.sb,
		cast(b.sb as numeric) + cast(b.cs as numeric) as total_attempts,
		round(cast(b.sb as numeric) /(cast(b.sb as numeric) + cast(b.cs as numeric)),2) as percentage_stole
from people as p left join appearances as a
	on p.playerid = a.playerid 
	left join batting as b
	on p.playerid = b.playerid
where	a.yearid = 2016
		and b.yearid =2016
		and cast(b.sb as numeric) + cast(b.cs as numeric) >= 20
order by percentage_stole desc;

 