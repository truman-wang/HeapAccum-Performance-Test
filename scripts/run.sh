#!/bin/bash
#add gsql script to graph first
#gsql -g ldbc_snb capacityLimit.gsql
gsql -g ldbc_snb resize.gsql 
gsql -g ldbc_snb top.gsql 
#install query 
gsql -g ldbc_snb install query push_largek
echo Results |& tee  output
gsql -g ldbc_snb "run query resize"

(time curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/resize') |& tee -a output

