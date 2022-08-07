# HeapAccum-Performance-Test
Test the performance of the new HeapAccum implementation

Got raw results now and to be formatted and generating conclusion. 

#D denotes distributed, S:single mode, G: global accumulator, L:local accumulator

new implementation:
Results:unit in ms
interpreted_push=100000 avg: 8980
interpreted_push=1000000 avg: 31113
interpreted_push=5000000 avg: 7379
UDF and Distributed mode results
orderby+limit=20 avg: 125
orderby+limit=100000 avg: 297
orderby+limit=1000000 avg: 1810
orderby+limit=5000000 avg: 6934
orderby+limit+50%offset=20 avg: 117
orderby+limit+50%offset=100000 avg: 322
orderby+limit+50%offset=1000000 avg: 1816
orderby+limit+50%offset=5000000 avg: 6524
order by only avg: 3544
pop_DG=20 avg: 120
pop_DG=100000 avg: 188
pop_DG=1000000 avg: 762
pop_DG=5000000 avg: 2086
pop_DG avg: 5409
pop_LTUPLE avg: 18601
pop_SG avg: 1866
pop_SL avg: 6830
push_d_global=20 avg: 115
push_d_global=100000 avg: 230
push_d_global=1000000 avg: 732
push_d_global=5000000 avg: 1042
push_DG avg: 94891
push_DL avg: 4344
push_LTUPLE avg: 5428
push_SG avg: 13470
push_SL avg: 6161
resize avg: 2543
top avg: 934
single_GPR mode results
push_d_global=20 avg: 103
push_d_global=100000 avg: 180
push_d_global=5000000 avg: 892

old:
Truman Wang: old:Results:unit in ms
interpreted_push=100000 avg: 6465
interpreted_push=1000000 avg: 20709
interpreted_push=5000000 avg: 7250
UDF and Distributed mode results
orderby+limit=20 avg: 102
orderby+limit=100000 avg: 256
orderby+limit=1000000 avg: 1474
orderby+limit=5000000 avg: 5656
orderby+limit+50%offset=20 avg: 130
orderby+limit+50%offset=100000 avg: 289
orderby+limit+50%offset=1000000 avg: 1481
orderby+limit+50%offset=5000000 avg: 5174
order by only avg: 2751
pop_DG=20 avg: 84
pop_DG=100000 avg: 81825
pop_DG=1000000 avg: 500292
pop_DG=5000000 avg: 500304
pop_DG avg: 4469
pop_LTUPLE avg: 500301
pop_SG avg: 500347
pop_SL avg: 6599
push_d_global=20 avg: 113
push_d_global=100000 avg: 189
push_d_global=1000000 avg: 571
push_d_global=5000000 avg: 921
push_DG avg: 94543
push_DL avg: 3822
push_LTUPLE avg: 5190
push_SG avg: 11604
push_SL avg: 6283
resize avg: 2081
top avg: 1738
single_GPR mode results
push_d_global=20 avg: 84
push_d_global=100000 avg: 150
push_d_global=5000000 avg: 814


Requests:
default: (global vs local, distributed vs single, )
large size: 100,000
mid size:8000
small:20
#k=20, 8000, 100000, and uncap
#j=10, 1000, 10000, 
Forum: 4611436
INT k: 20 100000 1000000 5000000
no PRINT or PRINT size()
*change default timeout time*
export GSQL_CLIENT_IDLE_TIMEOUT_SEC=10
local accumulator
ORDERBY, LIMIT (various capacities)
TUPLE<more elements>



#still need -g ldbc_snb in cmd line, not useful when defined in query?

