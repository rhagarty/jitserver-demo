#!/bin/bash
# The last parameter in the line below is the IP of the machine where liberty runs
# Output is written to  /output/acmeair.stats.0 inside the container
docker run --rm --net=host  -e JTHREAD=2 -e JDURATION=120 -e JPORT=9092 -e JUSERBOTTOM=100  -e JUSER=199 --name jmeter jmeter-acmeair:3.3 localhost