requirevars 'defaultDB' 'input_local_tbl' 'column1' 'column2' 'nobuckets';
--attach database '%{defaultDB}' as defaultDB;

create temp table localinputtbl1 as
select __rid as rid, __colname as colname, tonumber(__val) as val
from %{input_local_tbl};


select colname,
       min(val) as minvalue,
       max(val) as maxvalue,
       FSUM(val) as S1,
       FSUM(FARITH('*', val, val)) as S2,
       count(val) as N
from localinputtbl1
where colname = %{column1};




