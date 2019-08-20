select min(transtime), max(transtime),max(transtime)-min(transtime) as b, count(transtime) as c, count(transtime)/(max(transtime)-min(transtime) )*10 as ratio
from
(SELECT count(ID),transtime,min(x),max(x), avg(y) FROM jcbsm.sumo where x between 2276 and 2280.44 and y between 4133 and 4144.222 group by transtime) t1

union
select min(transtime), max(transtime),max(transtime)-min(transtime) as b, count(transtime) as c, count(transtime)/(max(transtime)-min(transtime) )*10 as ratio
from
(SELECT count(ID),transtime,min(x),max(x), avg(y) FROM jcbsm.sumo where x between 2280.44 and 2284.888889  and y between 4144.222 and 4155.444444 group by transtime) t1

union
select min(transtime), max(transtime),max(transtime)-min(transtime) as b, count(transtime) as c, count(transtime)/(max(transtime)-min(transtime) )*10 as ratio
from
(SELECT count(ID),transtime,min(x),max(x), avg(y) FROM jcbsm.sumo where x between 2284.888889  and 2289.333333 and y between 4155.444444 and 4166.666667 group by transtime) t1

union
select min(transtime), max(transtime),max(transtime)-min(transtime) as b, count(transtime) as c, count(transtime)/(max(transtime)-min(transtime) )*10 as ratio
from
(SELECT count(ID),transtime,min(x),max(x), avg(y) FROM jcbsm.sumo where x between 2289.333333   and 2293.777778 and y between 4166.666667  and 4177.888889 group by transtime) t1

union
select min(transtime), max(transtime),max(transtime)-min(transtime) as b, count(transtime) as c, count(transtime)/(max(transtime)-min(transtime) )*10 as ratio
from
(SELECT count(ID),transtime,min(x),max(x), avg(y) FROM jcbsm.sumo where x between 2293.777778  and 2298.222222 and y between 4177.888889 and 4189.111111 group by transtime) t1

union
select min(transtime), max(transtime),max(transtime)-min(transtime) as b, count(transtime) as c, count(transtime)/(max(transtime)-min(transtime) )*10 as ratio
from
(SELECT count(ID),transtime,min(x),max(x), avg(y) FROM jcbsm.sumo where x between 2298.222222  and 2302.666667 and y between 4189.111111 and 4200.333333 group by transtime) t1

union
select min(transtime), max(transtime),max(transtime)-min(transtime) as b, count(transtime) as c, count(transtime)/(max(transtime)-min(transtime) )*10 as ratio
from
(SELECT count(ID),transtime,min(x),max(x), avg(y) FROM jcbsm.sumo where x between 2302.666667  and 2307.111111 and y between 4200.333333 and 4211.555556 group by transtime) t1

union
select min(transtime), max(transtime),max(transtime)-min(transtime) as b, count(transtime) as c, count(transtime)/(max(transtime)-min(transtime) )*10 as ratio
from
(SELECT count(ID),transtime,min(x),max(x), avg(y) FROM jcbsm.sumo where x between 2307.111111  and 2311.555556 and y between 4211.555556 and 4222.777778 group by transtime) t1

union
select min(transtime), max(transtime),max(transtime)-min(transtime) as b, count(transtime) as c, count(transtime)/(max(transtime)-min(transtime) )*10 as ratio
from
(SELECT count(ID),transtime,min(x),max(x), avg(y) FROM jcbsm.sumo where x between 2311.555556 and 2316 and y between 4222.777778 and 4234 group by transtime) t1
