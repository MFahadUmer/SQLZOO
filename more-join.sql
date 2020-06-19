--List the films where the yr is 1962 [Show id, title]

SELECT id, title
 FROM movie
 WHERE yr=1962
 
-- When was Citizen Kane released?

select yr
from movie where title ='Citizen Kane'

--List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

select id, title, yr
from movie
where title LIKE 'Star Trek%'
  order by yr asc
  
--What id number does the actor 'Glenn Close' have?

select actor.id
from actor where name='Glenn Close'

--What is the id of the film 'Casablanca'

select id
from movie where title='Casablanca'

--Use movieid=11768, (or whatever value you got from the previous question)

select name from actor join casting on actorid=id where movieid = 11768

--Obtain the cast list for the film 'Alien'

select distinct name 
from actor join casting
on actor.id = actorid
join movie on movieid = movie.id
where title = 'Alien'

--List the films in which 'Harrison Ford' has appeared

select movie.title 
from movie join casting
on movie.id = movieid
join actor on actorid = actor.id
where name = 'Harrison Ford'

--List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

select movie.title 
from movie join casting
on movie.id = movieid
join actor on actorid = actor.id
where name = 'Harrison Ford' and ord !=1

--List the films together with the leading star for all 1962 films.

select title, name
from movie join casting
on movie.id = movieid
join actor
on actor.id = casting.actorid
where yr = 1962 and ord = 1

--Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

--List the film title and the leading actor for all of the films 'Julie Andrews' played in.

SELECT title, name 
FROM movie join casting
on (movie.id = casting.movieid and ord =1)
join actor
on actor.id = actorid
WHERE movie.id in (select movieid 
from casting 
where actorid in (select id 
from actor 
where name = 'Julie Andrews'))

--Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles

select name
from actor join casting
on (id = actorid and ord = 1)
group by name
having count(*) >= 15

--List the films released in the year 1978 ordered by the number of actors in the cast, then by title

select title, count(actorid) as Actor_ID
from actor
join casting on actor.id = actorid
join movie on movie.id = movieid
where yr = 1978
group by title
order by count(name) desc, title
