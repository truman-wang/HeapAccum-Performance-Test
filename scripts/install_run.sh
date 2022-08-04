#!/usr/bin/bash
for q in *.gsql ; do  
  gsql $q
done

gsql -g ldbc_snb install query all

gsql "run query push_largeK"

(time curl -X GET 'http://127.0.0.1:9000/query/ldbc_snb/orderby_largek') |grep "real" |& tee -a output