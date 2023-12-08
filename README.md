## Prerequisites

To run the test WebSocket client on your machine, make sure you have the following packages installed:
```bash
$ sudo yum install -y nodejs
$ npm install websocket
```

## Deploy test workload

```bash
$ ./deploy.sh
```

## Run test client targeting secure edge terminated route

```bash
$ ./run-cli.sh
WebSocket Client Connected
echo-protocol Connection Closed

real	0m5.611s
user	0m0.121s
sys	0m0.016s
```
**Note**: default tunnel timeout is used (`5s`)

## Change route to unsecured

```bash
$ oc apply -f ./unsecured-route.yaml
```

## Run test client targeting unsecured route

```bash
$ ./run-cli.sh
WebSocket Client Connected
echo-protocol Connection Closed

real	0m15.387s
user	0m0.103s
sys	0m0.022
```
**Note**: route's tunnel timeout is used (`15s`)

## Setting the timeout to higher values

By default the test client does not send anything and has keepalives disabled.
That makes it a subject for the router's client timeout which is set to `30s` by default.   
Therefore the client timeout needs to be increased in order to test the tunnel timeout higher than `30s`:
```bash
oc explain ingresscontroller.spec.tuningOptions.clientTimeout
GROUP:      operator.openshift.io
KIND:       IngressController
VERSION:    v1

FIELD: clientTimeout <string>

DESCRIPTION:
    clientTimeout defines how long a connection will be held open while waiting
    for a client response.
     If unset, the default timeout is 30s
```
