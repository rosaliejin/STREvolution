#!/bin/bash

for species in $(ls /storage/yjin/TreeofLife/annotation/*.gtf | awk -F"/" '{print $NF}' | sed 's/.gtf//' | grep -v temp  )
do
    ./run_species.sh $species
done
