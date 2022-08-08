#!/bin/bash
t=3
#push distributed global
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET -H "GSQL-TIMEOUT: 500000" 'http://127.0.0.1:9000/query/ldbc_snb/push_s_global?k=20') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo push_UDF_global=20 avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

#push distributed global
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET -H "GSQL-TIMEOUT: 500000" 'http://127.0.0.1:9000/query/ldbc_snb/push_s_global?k=100000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo push_UDF_global=100000 avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

#push distributed global
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET -H "GSQL-TIMEOUT: 500000" 'http://127.0.0.1:9000/query/ldbc_snb/push_s_global?k=5000000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo push_UDF_global=5000000 avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output
