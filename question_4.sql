/*Using the fielding table, group players into three groups based on their position: 
label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", 
and those with position "P" or "C" as "Battery". 
Determine the number of putouts made by each of these three groups in 2016.*/

SELECT playerid, pos,
CASE WHEN pos = 'OF' THEN 'Outfield'
	WHEN pos = 'SS' OR pos ='1B' OR pos = '2B' OR pos = '3B' THEN 'Infield'
	ELSE 'Battery' END AS position,
	po AS PutOut,
	yearid
FROM fielding
WHERE yearid = '2016';


-- SELECT *
-- FROM fielding

--Determine the number of putouts made by each of these three groups in 2016.

WITH calculation AS (
		SELECT playerid, pos,
			CASE WHEN pos = 'OF' THEN 'Outfield'
			WHEN pos = 'SS' OR pos ='1B' OR pos = '2B' OR pos = '3B' THEN 'Infield'
			ELSE 'Battery' END AS position,
			po AS PutOut,
			yearid
		FROM fielding
		WHERE yearid = '2016')
SELECT position, SUM(putout) AS number_putout
FROM calculation
GROUP BY position;

