-- List each country name where the population is larger than that of 'Russia'.

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
select name
from world
where continent = 'Europe' and gdp/population > (select gdp/population from world where name = 'United Kingdom')


-- List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
select name, continent
from world
where continent in ((select continent from world where name = 'Argentina'), (select continent from world where name = 'Australia'))
order by name

-- Which country has a population that is more than Canada but less than Poland? Show the name and the population.
select name, population
from world
where population between (select population from world where name = 'Poland') and (select population from world where name = 'Canada')

-- Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.

select name, concat(round((population*100)/(select population from world where name = 'Germany'), 0), '%') as percentage
from world
where continent = 'Europe'

-- Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
select name
from world
where continent != 'Europe' and gdp >= all(select gdp from world where continent = 'Europe' and gdp is not null)

-- Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT continent, name, area FROM world as x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)

-- List each continent and the name of the country that comes first alphabetically.
select continent, name from world x
group by continent

-- Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
select name, continent, population
from world x
where continent = (select continent
from world y
group by y.continent
having sum(population) <= 39000000)

-- Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
select name, continent
from world x
where population/3 > all(select population 
from world y 
where x.continent = y.continent 
and population > 0 
and x.name != y.name)