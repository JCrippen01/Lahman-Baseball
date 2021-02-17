--What range of years for baseball games played does the provided database cover?
select min(yearid), max(yearid)
from appearances;

select min(yearid), max(yearid)
from collegeplaying;

select min(c.yearid), max(a.yearid)
from appearances as a full join collegeplaying as c 
	on a.yearid = c.yearid;


