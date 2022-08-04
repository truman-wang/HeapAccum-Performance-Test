#!/bin/bash
#add gsql script to graph first
#gsql -g ldbc_snb capacityLimit.gsql
gsql -g ldbc_snb orderlimit.gsql 
gsql -g ldbc_snb orderLimitOffset.gsql 
gsql -g ldbc_snb pop_largek.gsql
gsql -g ldbc_snb pop_midsizek.gsql
gsql -g ldbc_snb push_largek.gsql
gsql -g ldbc_snb push_largek_Post-Accum.gsql
gsql -g ldbc_snb push_smallK.gsql
gsql -g ldbc_snb top_largek.gsql
gsql -g ldbc_snb order_largek.gsql
gsql -g ldbc_snb orderLimitOffset2.gsql
gsql -g ldbc_snb orderonly.gsql 
gsql -g ldbc_snb pop_largek_LTUPL.gsql
gsql -g ldbc_snb pop_smallK.gsql
gsql -g ldbc_snb push_largek_LTUPLE.gsql
gsql -g ldbc_snb push_midsizek.gsql 
gsql -g ldbc_snb resize_largek.gsql
#install query 
gsql -g ldbc_snb install query push_largeK
echo Results |& tee  output
gsql "run query push_largeK"
echo curl
time curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/orderby_largek' |grep real |& tee -a output


