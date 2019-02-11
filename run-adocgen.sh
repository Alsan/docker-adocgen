#!/bin/bash

docker run \
       -d \
       --name adocgen \
       --rm \
       -p 8090:8080 \
       -v $(pwd):/documents \
       adocgen
