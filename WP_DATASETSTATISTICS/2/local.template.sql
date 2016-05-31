requirevars 'defaultDB' 'prv_output_global_tbl' 'column1' 'column2' 'nobuckets';
attach database '%{defaultDB}' as defaultDB;


--create table heatmapHistogramPartial as

select heatmaphistogram(colname1,val1,minval1,maxval1,buckets1,colname2,val2,distinctvalues2)
from  ( select colname1,val1, %{nobuckets} as buckets1,colname2, val2
        from (select __rid as rid1 ,__colname as colname1, __val as val1 from input_local_tbl where __colname = %{column1}) ,
            (select __rid as rid2 ,__colname as colname2, __val as val2 from input_local_tbl where __colname = %{column2})
        where rid1 = rid2 ),
      ( select jgroup(__val) as distinctvalues2
        from (select __val from input_local_tbl where __colname = %{column2} group by __val)),
      ( select minval as minval1, maxval as maxval1 from input_local_tbl where __colname = %{column1});
