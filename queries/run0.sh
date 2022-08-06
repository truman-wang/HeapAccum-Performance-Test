#!/bin/bash
#add gsql script to graph first
for q in *.gsql; do
gsql -g ldbc_snb $q
done

#install query 
gsql -g ldbc_snb install query all

