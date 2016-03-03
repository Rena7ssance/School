#!/bin/bash

date;
echo "Starting $1 Iterations ...";

COUNT=0

killHandler(){
  echo -en "\nForce Quitting after ${COUNT} iterations\nNo failures found\n";
  date;
  exit $?
}

trap killHandler SIGINT

if [ "$2" = "-m" ]; then
    make -s clean && make -s &> /dev/null;
fi

printf "%10d tests passed" 0
for i in $(seq 1 $1); do 
    make -s run &> /dev/null;
    diff test.out test.ok;
    if [ `echo $?` != "0" ]; then
        printf "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
        printf "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
        printf "FAILED AFTER ${COUNT} SUCCESSES\n";
        date;
        exit 1;
    fi 
    ((COUNT+=1))
    printf "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
    printf "%10d tests passed" $COUNT
done

printf "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
printf "SUCCEEDED ${COUNT} TIMES          \n";
date;

exit 0
