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

## Change route to unsecure

```bash
$ oc apply -f ./unsecure-route.yaml
```

## Run test client targeting unsecure route
```bash
$ ./run-cli.sh
WebSocket Client Connected
echo-protocol Connection Closed

real	0m15.387s
user	0m0.103s
sys	0m0.022
```
**Note**: route's tunnel timeout is used (`15s`)
