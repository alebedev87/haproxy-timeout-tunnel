#! /bin/bash

ROUTE_HOST=$(oc -n tunnel-timeout get route hello-openshift --template='{{.spec.host}}')
ROUTE_TLS=$(oc -n tunnel-timeout get route hello-openshift --template='{{.spec.tls}}')

if [ "${ROUTE_TLS}" == "<no value>" ]; then
    time HOST=${ROUTE_HOST} PORT=80 ./websocket-cli.js
else
    time HOST=${ROUTE_HOST} PORT=443 SCHEME=wss ./websocket-cli.js
fi
