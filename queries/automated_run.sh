#!/bin/bash
#add gsql script to graph first

# variable declaration
output_path="./output.csv"
t=5
limits="100 1000 10000 100000 1000000 1000000000"
queries="order_limit order_only push_hadedge_global push_hadedge_local push_vertex push_large_tuple"
#distributed, single_gpr, single_udf
modes=("_dist" "_single_gpr" "")

echo Results:"unit in ms" |& tee $output_path

for mode in ${modes[@]}
do
echo "mode ${mode}" |& tee -a $output_path
for q in $queries
do
echo "query ${q}" |& tee -a $output_path
for lim in $limits
do
    echo "lim = ${lim}" |& tee -a $output_path
    # run once to warm up
    (curl -X GET -H "GSQL-TIMEOUT: 500000" "http://127.0.0.1:9000/query/ldbc_snb/${q}${mode}?k=${lim}") &> /dev/null
    for i in $(seq 1 $t)
    do
    q_start=$(date +%s%N | cut -b1-13)
    (curl -X GET -H "GSQL-TIMEOUT: 500000" "http://127.0.0.1:9000/query/ldbc_snb/${q}${mode}?k=${lim}") &> /dev/null
    q_end=$(date +%s%N | cut -b1-13)
    q_time=$(($q_end-$q_start))
    echo -n "$q_time," |& tee -a $output_path
    done
    echo "" |& tee -a $output_path
done
done
done
