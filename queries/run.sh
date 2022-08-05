#!/bin/bash
#add gsql script to graph first
for q in *.gsql; do
gsql -g ldbc_snb $q
done

#install query 
gsql -g ldbc_snb install query all


#print result to output
touch output
echo Results |& tee  /home/tigergraph/HeapAccum-Performance-Test/output


#gsql -g ldbc_snb "run query resize"

for i in {1..3}
do
q_start=$(date +%s%N | cut -b1-13)
(time curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/resize') &> /dev/null
d5_end=$(date +%s%N | cut -b1-13)
r5_time=$(($d5_end-$d5_start))
echo $r5_time
done
