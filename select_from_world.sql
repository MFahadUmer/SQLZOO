-- Read the notes about this table. Observe the result of running this SQL command to show the name, continent and population of all countries.
SELECT name, continent, population FROM world

-- How to use WHERE to filter records. Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.

SELECT name FROM world
WHERE population > 200000000

-- Give the name and the per capita GDP for those countries with a population of at least 200 million.
select name, gdp/population
from world
where population > 200000000

-- Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
select name, population/1000000
from world
where continent = 'South America'

-- Show the name and population for France, Germany, Italy
select name, population
from world
where name in ('France', 'Germany', 'Italy')

-- Show the countries which have a name that includes the word 'United'
select name
from world
where name like concat ('%', 'United', '%')


-- Show the countries that are big by area or big by population. Show name, population and area.
select name, population, area
from world
where area > 3000000 or population > 250000000

-- Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.

select name, population, area
from world
where area > 3000000 xor population > 250000000

-- Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.
select name, round(population/1000000, 2), round(gdp/1000000000, 2)
from world
where continent = 'South America'

-- Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.

select name, round((gdp/population)/1000, 0)*1000
from world
where gdp > 1000000000000

-- Greece has capital Athens.

SELECT name, capital
  FROM world
 WHERE LENGTH(name) = LENGTH(capital)

-- The capital of Sweden is Stockholm. Both words start with the letter 'S'.

SELECT name, capital
FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1) 
AND name <> capital

-- Equatorial Guinea and Dominican Republic have all of the vowels (a e i o u) in the name. They don't count because they have more than one word in the name.

SELECT name
   FROM world
WHERE (name LIKE '%a%' OR name like '%A%')
  AND (name LIKE '%e%' OR name like '%E%')
  AND (name LIKE '%i%' OR name like '%I%')
  AND (name LIKE '%o%' OR name like '%O%')
  AND (name LIKE '%u%' OR name like '%U%')
  AND name NOT LIKE '% %'
