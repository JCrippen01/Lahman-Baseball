--What range of years for baseball games played does the provided database cover?
select min(yearid), max(yearid)
from appearances;

select min(yearid), max(yearid)
from collegeplaying;

select min(c.yearid), max(a.yearid)
from appearances as a full join collegeplaying as c 
	on a.yearid = c.yearid;

--Find the player who had the most success stealing bases in 2016, where success 
--is measured as the percentage of stolen base attempts which are successful. 
--(A stolen base attempt results either in a stolen base or being caught stealing.) 
--Consider only players who attempted at least 20 stolen bases.

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
		and cast(b.sb as numeric) + cast(b.cs as numeric) >= 20
order by percentage_stole desc;