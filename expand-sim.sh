#!/bin/bash

for i in {1..100}
do
  cat job.yaml | sed "s/\$ITEM/$i/" > ./jobs/job-$i.yaml
done