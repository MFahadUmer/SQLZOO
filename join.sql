Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'

SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'

Show id, stadium, team1, team2 for just game 1012

SELECT id,stadium,team1,team2
  FROM game
where game.id = 1012

Modify it to show the player, teamid, stadium and mdate for every German goal.

SELECT player, teamid,stadium, mdate
  FROM game JOIN goal ON (id=matchid)
where teamid ='GER'

Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

select  team1, team2, player from game join goal on (id=matchid)
where player like 'Mario%'

Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT distinct player, teamid,coach, gtime
  FROM goal 
join eteam on (teamid=id)
 WHERE gtime<=10
 
 List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
 
 select mdate, teamname
from game JOIN eteam ON (team1=eteam.id)
where coach = 'Fernando Santos'

List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

select player
from goal inner join game on matchid = id
where stadium = 'National Stadium, Warsaw'

Instead show the name of all players who scored a goal against Germany.

SELECT distinct player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' OR team2='GER') and teamid !='GER'
    
Show teamname and the total number of goals scored

SELECT teamname, count(teamid)
  FROM eteam JOIN goal ON id=teamid
group by teamname

Show the stadium and the number of goals scored in each stadium

select game.stadium, count(*)
from game
inner join goal on matchid=id
group by stadium

For every match involving 'POL', show the matchid, date and the number of goals scored

SELECT matchid,mdate, count(teamid)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
group by matchid
