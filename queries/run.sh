#!/bin/bash
#add gsql script to graph first
for q in *.gsql; do
gsql -g ldbc_snb $q
done

#install query 
gsql -g ldbc_snb install query all


#print result to output
echo Results |& tee  /home/tigergraph/HeapAccum-Performance-Test/output


#gsql -g ldbc_snb "run query resize"

#(time curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/resize') |& tee -a output

