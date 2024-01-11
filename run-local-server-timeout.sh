#! /bin/bash

# local server replying with a delay
socat TCP4-LISTEN:8080,reuseaddr,fork EXEC:'/bin/bash -c \"sleep 300; printf \\\"HTTP/1.0 200 OK\r\n\r\n\\\"; sed -e \\\"/^\r/q\\\"\"'

# haproxy with the config
./haproxy -f haproxy-server-minimal.config

# client
time curl -k https://localhost:8843
