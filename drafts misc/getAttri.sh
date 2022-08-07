#!/bin/bash

cwd=$(cd $(dirname $0) && pwd)
cd $cwd

source ./INPUT
#cat INPUT
##!/bin/bash
#SKIP=false
#RUN_TIMES=3
#SINGLE_GPR=false
#DISTRIBUTED_ENABLE=false

log_file=$cwd/LOG
result_file=$cwd/RESULT
touch $log_file
touch $result_file

if gsql ls | grep "Graph ldbc_snb" > /dev/null; then
  queries=$cwd/queries
  cd $queries

  # create queries
  queries=$(ls)
  for q in ${queries}; do
    echo "gsql file name: $q"
    if [[ "${DISTRIBUTED_ENABLE}" == "true" && -z "$(cat $q | grep -i distributed)" ]]; then
      sed -i -e 's/create or replace query/create or replace distributed query/i' $q
    fi
    if [[ "${DISTRIBUTED_ENABLE}" == "false" && -n "$(cat $q | grep -i distributed)" ]]; then
      sed -i -e 's/create or replace distributed query/create or replace query/i' $q
    fi
    gsql "$q" | tee -a $log_file
  done

  # install queries in single_gpr mode
  if [[ "${SINGLE_GPR}" == "true" ]]; then
    echo "start install $graph queries in single_GPR mode..." | tee -a $log_file
    gsql -g ldbc_snb "set single_gpr=true install query all" &> /dev/null
  else
    echo "start install $graph queries in UDF mode..." | tee -a $log_file
    gsql -g ldbc_snb "install query all" &> /dev/null
  fi

  if [ $? -ne 0 ]; then
    echo "install queries fail. Please check." | tee -a $log_file
    exit 1
  fi

  generate_dir=$cwd/run_scripts
  rm -rf $generate_dir
  mkdir -p $generate_dir

  run_queries=$(ls)
  for query in ${run_queries}; do
    # generate run scripts
    echo "start generate run query script: ${query%%.*}..."
    bash $cwd/generate_script.sh ${query%%.*} $cwd/queries
    run_script=$generate_dir/${query%%.*}.sh
    echo "generate run query script successfully: $run_script ..."

    # check status
    res_status=$(echo `sh ${run_script} | jq .error`)
    if [ "$res_status" = "true" ]; then
      echo "query: ${query%%.*} run fail. Please check it." | tee -a $log_file
      exit 1
    else
      echo "run query result check successfully." | tee -a $log_file
    fi

    sum_cost=0
    min_cost=99999
    # set the time output format to be second only
    TIMEFORMAT=%R
    for i in $(seq ${RUN_TIMES}); do
      echo "========================start run query:${query%%.*},run_times:$i==================================" | tee -a $log_file
      time_cost=$({ time sh $run_script >/dev/null 2>&1; } 2>&1)
      echo "run ${query%%.*} cost time: $time_cost s" | tee -a $log_file
      echo "${query%%.*}_time_cost_$i=$time_cost s" | tee -a $result_file
      if [ $(echo "$time_cost <= $min_cost"|bc) = 1 ]; then
        min_cost=$time_cost
      fi
      sum_cost=`echo "$sum_cost + $time_cost"|bc`
    done
    average=`echo "$sum_cost $RUN_TIMES" |awk '{printf("%.3f",$1/$2)}'`
    echo "${query%%.*}_time_cost_avg=$average s" | tee -a $result_file
    echo "${query%%.*}_time_cost_min=$min_cost s" | tee -a $result_file
  done
else
  echo "run query not support ${GRAPH_NAME} now."
  echo "status=failed" >> $result_file
  exit 1
fi
echo "status=pass" >> $result_file
