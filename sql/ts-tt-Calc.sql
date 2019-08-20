select avg(term), ID
from
(
select ts.ts/tt.tt as term, ts.ID
from
(SELECT sum(total) as ts,ID, max(transtime) as a FROM 
(SELECT *,
(CASE
when speed>0 THEN 0
ELSE 0.1
END) as total
FROM jcbsm.infdisflatbush ) as c1
group by ID, transtime DIV 200

) as ts,
(SELECT max(transtime)-min(transtime) as tt,ID, max(transtime) as b FROM jcbsm.infdisflatbush group by ID, transtime DIV 200) as tt
where ts.a = tt.b and ts.ID = tt.ID and tt.tt>0 
) as t1
group by ID