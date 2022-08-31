#!/bin/bash
#add gsql script to graph first
for q in *.gsql; do
gsql -g ldbc_snb $q
done

#install query 
gsql -g ldbc_snb install query all

#gsql -g ldbc_snb precompute-bi19.gsql
#gsql -g ldbc_snb install query precompute_bi19
#gsql "run query test1()"
