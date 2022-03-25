# The AcmeAir container assumes that a mongo database is available on a machine named mongodb
# We simulate this by running the acmeair container and the 
# mongo container (named mongodb) on the same network
# /tmp/vlogs directory can be used to store vlogs (-v /tmp/vlogs:/tmp/vlogs -e JVM_ARGS="-Xjit:verbose,vlog=/tmp/vlogs/vlog.txt" )
# Note that we must have write permissions for the directory on the host

docker network create mynet
docker run --rm -d --network=mynet --name mongodb mongo-acmeair --nojournal
sleep 2
docker exec -it mongodb mongorestore --drop /AcmeAirDBBackup
sleep 1

echo "Starting liberty-acmeair"
docker run --rm -d --network=mynet -m=256m --cpus=".5"  -p 9092:9090 -p 9404:9404 -e JVM_ARGS="-javaagent:/config/jmx_prometheus_javaagent-0.16.1.jar=9404:/config/jmxexporter.yml" --name acmeair-plain liberty-acmeair:openj9_11

sleep 2
echo "Starting liberty-acmeair with JITServer"
docker run --rm -d --network=mynet -m=256m --cpus=".5"  -p 9093:9090 -p 9405:9404 -e JVM_ARGS="-javaagent:/config/jmx_prometheus_javaagent-0.16.1.jar=9404:/config/jmxexporter.yml -XX:+UseJITServer -XX:+JITServerLogConnections -XX:JITServerAddress=jitserver -Xjit:verbose={JITServer}" --name acmeair-jitserver liberty-acmeair:openj9_11