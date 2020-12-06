docker rm -f some-scylla
docker run -v `pwd`:/my-data --name some-scylla --hostname some-scylla -d scylladb/scylla:4.2.1
sleeptime=60
echo "Sleeping $sleeptime seconds to wait for scylla startup, then we'll import some data. If you get errors, raise this value." 
sleep $sleeptime
echo "Creating pa195 keyspace and people table."
docker exec -it some-scylla cqlsh -f /my-data/make_table.txt
echo "Importing data."
docker exec -it some-scylla cqlsh -f /my-data/people-insert.json
