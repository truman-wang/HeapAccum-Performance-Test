# HeapAccum-Performance-Test
## Test the performance of the new HeapAccum implementation


The current pop in HeapAccum was extremely slow. It is almost guaranteed the query time will exceed the default timeout=16 s when pop is involved for large capacity HeapAccum. 

## Tigergraph Packages
Master: https://tigergraph-release-prebuild.s3.amazonaws.com/prebuild/tigergraph-3.7.0-mit_test_12962-offline.tar.gz

Test feature: https://tigergraph-release-prebuild.s3.amazonaws.com/prebuild/tigergraph-3.7.0-wip_test_18844-offline.tar.gz

## Environment
machine type= GCP n2d-standard-32

cvpu=16

memory_size=64

os= Ubuntu 20.04.4 LTS

Schema: LDBC_SNB SF=100


## Test Plan
The new implementations are expected to improve pop(the best element) and push. All core and corner cases are summarized first and corresponding queries are tested to reveal the overall performance. 

The tricky part is that push has two operations after Heap is full: pop_worst and then push. The new HeapAccum implementation improved the pop_best method, but undermined pop_worst method. Therefore, it becomes necessary to investigate all these operations separately by setting different capacity limits, such that we can know how many push, pop_worst, and pop_best operations are performed.

The current test uses Forum Vertex, and has around 5 million counts in 100G ldbc_snb graph. 0.0004%, 2%, 20% and 100% of total TUPLE elements are then can be calculated and tested.

Cases and involving clauses for HeapAccum
### A. Side by side Scenarios
pop

4 capacities (0.0004%, 2%, 20% and 100% of total TUPLE elements)

local accumulator

large tuple

push

4 capacities (0.0004%, 2%, 20% and 100% of total TUPLE elements)

local accumulator

large tuple

order by

order by + limit for 4 capacities (0.0004%, 2%, 20% and 100% of total TUPLE elements)

order by + limit + offset for 4 capacities (0.0004%, 2%, 20% and 100% of total TUPLE elements)

resize()

top

### B. Test different modes
Test push for different capacities at UDG, single_GPR , distributed and interpreted modes

### C. Benchmark the new HeapAccum implementation
We need to know the overall performance of the new implementation. Run the ldbc_snb benchmark using two TG packages and investigate the effects of new HeapAccum on the ldbc_snb benchmark.

## Test Result 
Each query was executed for three times and we use the avg. 

### A. Side by side Scenarios

Scenarios

Avg(ms) __ NEW

Avg(ms)__ Old (3.7.0)

Improvements(%)

ORDER BY ALONE

3544

2751

-28.8259%

ORDERBY + LIMIT(0.0004% total)

125

102

-22.5490%

ORDERBY + LIMIT(2% total)

297

256

-16.0156%

ORDERBY + LIMIT(20% total)

1810

1474

-22.7951%

ORDERBY + LIMIT(100% total)

6934

5656

-22.5955%

ORDERBY + LIMIT +OFFSET (100% total)

6524

5174

-26.0920%

pop (0.0004% total elements)

120

84

-42.8571%

pop (2% total elements)

188

81825

99.7702%

pop (20% total elements)

762

>500292 (timeout)

>99.99%

pop (100% total elements)

2086

>500304 (timeout)

>99.99%

pop_local accumulator

5409

4469

-21.0338%

pop_large tuple

18601

>500301 (timeout)

>99.99%

push (0.0004% total elements)

115

113

-1.7699%

push (2% total elements)

230

189

-21.6931%

push (20% total elements)

732

571

-28.1961%

push (100% total elements)

1042

921

-13.1379%

push_local accumulator

4344

3822

-13.6578%

push_large tuple

5428

5190

-4.5857%

resize

2543

2081

-22.2009%

top

934

1738

46.2601%

### B.  Comparisons between 4 modes for push 

push

UDF

single_GPR

DISTRIBUTED

INTERPRETED

push (0.0004% total elements)

-15.3061%

-22.6190%

-1.7699%

-38.9018%

push (2% total elements)

-2.7701%

-20.0000%

-21.6931%

-50.2390%

push (100% total elements)

-12.2715%

-9.5823%

-13.1379%

-1.7793%

### C. Overall performance with benchmarking 100G ldbc_snb  

LDBC_SNB (Period: 11/29/12-12/31/12)

New (s)

Old (s)

Improvements (Old-David's)/Old*100%

AVG: reads

629.2935222

619.8185316

-1.5287%

AVG:writes

518.0620295

511.4114692

-1.3004%

