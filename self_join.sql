-- How many stops are in the database.
select COUNT(*)
from stops

-- Find the id value for the stop 'Craiglockhart'
select id
from stops
where name = 'Craiglockhart'

-- Give the id and the name for the stops on the '4' 'LRT' service.
select id, name
from stops
    join route on id=stop
where company = 'LRT' and num=4
order by pos

-- The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.
select company, num, COUNT(*) AS visits
from route where stop=149 or stop=53
group by company, num
having visits=2

-- Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.
select a.company, a.num, a.stop, b.stop
from route a join route b on
  (a.company=b.company and a.num=b.num)
where a.stop=53 and b.stop=149

-- The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'
select a.company, a.num, stopa.name, stopb.name
from route a join route b on
  (a.company=b.company and a.num=b.num)
  join stops stopa on (a.stop=stopa.id)
  join stops stopb on (b.stop=stopb.id)
where stopa.name='Craiglockhart'and stopb.name = 'London Road'

-- Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
select distinct a.company, a.num
from route a join route b on
  (a.company =b.company and a.num=b.num)
  join stops stopa on (a.stop=stopa.id)
  join stops stopb on (b.stop=stopb.id)
where stopa.name='Haymarket' and stopb.name='Leith'

-- Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
select distinct a.company, a.num
from route a
  join route b on (a.num=b.num and a.company=b.company)
  join stops stopa on (a.stop=stopa.id)
  join stops stopb on (b.stop=stopb.id)
where stopa.name = 'Craiglockhart' and stopb.name = 'Tollcross'

-- Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.
select distinct name, a.company, a.num
from route a
join route b on (a.company = b.company and a.num = b.num)
join stops on a.stop = stops.id
where b.stop = 53;

-- Find the routes involving two buses that can go from Craiglockhart to Lochend.
-- Show the bus no. and company for the first bus, the name of the stop for the transfer,
-- and the bus no. and company for the second bus.
select a.num, a.company, stopc.name AS transfer, 
       c.num, c.company

from route a 
  join route b on (a.company = b.company 
                   and a.num = b.num)
  join route c 
  join route d on (c.company = d.company 
                   and c.num = d.num)
join stops stopa on a.stop = stopa.id
join stops stopb on b.stop = stopb.id
join stops stopc on c.stop = stopc.id
join stops stopd on d.stop = stopd.id

where stopd.name = 'Lochend'
  and stopa.name = 'Craiglockhart'
  and stopb.name = stopc.name
order by (
(CASE
    when a.num = 10 and transfer = 'Leith' then 1
    when a.num = 10 and transfer = 'Princes Street' then 2
    when a.num = 27 and transfer = 'Canonmills' then 3
    when a.num = 27 and  transfer = 'Crewe Toll' then 4
    when a.num = 4 and transfer = 'Haymarket' then 5
    when a.num = 4 and transfer = 'London Road' then 6
    when a.num = 4 and transfer = 'Princes Street' then 7
    when a.num = 45 and transfer = 'Duddingston' then 8
    when a.num = 45 and transfer = 'London Road' then 9
    when a.num = 45 and transfer = 'Riccarton Campus' then 10
    else 11
end), b.num);