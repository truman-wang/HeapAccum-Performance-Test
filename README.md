# HeapAccum-Performance-Test
Test the performance of the new HeapAccum implementation
Requests:
default: (global vs local, distributed vs single, )
large size: 100,000
mid size:8000
small:20
Forum: 4611436
INT k: 20 8000 100000 5000000
no PRINT or PRINT size()
local accumulator
ORDERBY, LIMIT (various capacities)
TUPLE<more elements>

Question: 
run each query for multiple times like 10 times
pass substitution parameters to query
output the query time
automatically calculate avg time
