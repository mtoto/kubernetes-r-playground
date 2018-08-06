#!/bin/bash

for i in {1..100}
do
  cat job.yaml | sed "s/\$ITEM/$i/" > ./jobs/job-$i.yaml
done

set -x

for j in $(kubectl get jobs -o custom-columns=:.metadata.name)
do
    kubectl delete jobs $j &
done