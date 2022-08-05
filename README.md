# HeapAccum-Performance-Test
Test the performance of the new HeapAccum implementation
Requests:
default: (global vs local, distributed vs single, )
large size: 100,000
mid size:8000
small:20
#k=20, 8000, 100000, and uncap
#j=10, 1000, 10000, 
Forum: 4611436
INT k: 20 8000 100000 5000000
no PRINT or PRINT size()
*change default timeout time*
export GSQL_CLIENT_IDLE_TIMEOUT_SEC=10
local accumulator
ORDERBY, LIMIT (various capacities)
TUPLE<more elements>

Question: 
run each query for multiple times like 10 times
pass substitution parameters to query
output the query time
automatically calculate avg time

#still need -g ldbc_snb in cmd line, not useful when defined in query?
gsql "run query resize"
#D denotes distributed, S:single mode, G: global accumulator, L:local accumulator
time curl how to pass parameter?