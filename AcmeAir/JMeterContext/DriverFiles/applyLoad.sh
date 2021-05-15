#!/bin/bash
cd $JMETER_HOME

if [ $# -gt 0 ]
  then
    sed -i 's/localhost/'$1'/g' hosts.csv
fi
echo jmeter -n -DusePureIDs=true -t AcmeAir-v3.jmx -j /output/acmeair.stats.0 -JPORT=$JPORT -JUSERBOTTOM=$JUSERBOTTOM -JUSER=$JUSER -JURL=$JURL -JTHREAD=$JTHREAD -JDURATION=$JDURATION
exec jmeter -n -DusePureIDs=true -t AcmeAir-v3.jmx -j /output/acmeair.stats.0 -JPORT=$JPORT -JUSERBOTTOM=$JUSERBOTTOM -JUSER=$JUSER -JURL=$JURL -JTHREAD=$JTHREAD -JDURATION=$JDURATION

