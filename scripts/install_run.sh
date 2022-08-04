#!/usr/bin/bash
for q in *.gsql ; do  
  gsql $q
done

gsql -g ldbc_snb install query all