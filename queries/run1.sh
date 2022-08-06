#!/bin/bash
#add gsql script to graph first

#print result to output
touch output
echo Results |& tee  /home/tigergraph/HeapAccum-Performance-Test/output
t=10

q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/OrderLimit?k=20') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo orderby+limit=20 avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/OrderLimit?k=8000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo orderby+limit=8000 avg:  $q_time |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/OrderLimit?k=100000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo orderby+limit=100000 avg:  $q_time |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/OrderLimit?k=5000000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo orderby+limit=5000000 avg:  $q_time |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

#Orderby+limit+offset
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/OrderLimit?k=20&j=10') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo orderby+limit+50%offset=20 avg:  $q_time |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/OrderLimit?k=8000&j=4000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo orderby+limit+50%offset=8000 avg:  $q_time |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/OrderLimit?k=100000&j=50000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo orderby+limit+50%offset=100000 avg:  $q_time |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/OrderLimit?k=5000000&j=2500000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo orderby+limit+50%offset=5000000 avg:  $q_time |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

#orderby only
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/orderOnly') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo order by only avg:  $q_time |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

#pop Distributed global for various capacity limits
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/pop_DG?k=20') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo pop_DG=20 avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/pop_DG?k=8000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo pop_DG=8000 avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/pop_DG?k=100000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo pop_DG=100000 avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/pop_DG?k=5000000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo pop_DG=5000000 avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

#pop Distributed local accumulator 
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/pop_DL') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo pop_DG avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

#pop distributed large tuple 
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/pop_LTUPLE?k=5000000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo pop_LTUPLE avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

#pop single global
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/pop_SG?k=5000000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo pop_SG avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

#pop single local
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/pop_SL') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo pop_SL avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

#push distributed global
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/push_d_global?k=20') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo push_d_global=20 avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output


#push distributed global
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/push_d_global?k=8000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo push_d_global=8000 avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output


#push distributed global
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/push_d_global?k=100000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo push_d_global=100000 avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output


#push distributed global
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/push_d_global?k=5000000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo push_d_global=5000000 avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

#push distributed global
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/push_DG') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo push_DG avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

#push distributed global
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/push_DL') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo push_DL avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

#push distributed global
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/push_LTUPLE?k=5000000') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo push_LTUPLE avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output


#push single global
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/push_SG') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo push_SG avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

#push single local
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/push_SL') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo push_SL avg:  $q_time  |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

#resize
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/resize') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo resize avg:  $q_time |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output

#top
q_start=$(date +%s%N | cut -b1-13)
for i in $(seq 1 $t)
do
(curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/top') &> /dev/null
done
q_end=$(date +%s%N | cut -b1-13)
q_time=$((($q_end-$q_start)/$t))
echo top avg:  $q_time |& tee -a /home/tigergraph/HeapAccum-Performance-Test/output