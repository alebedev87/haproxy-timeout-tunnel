#! /bin/bash

# set default tunnel tunnel to 5s
oc -n openshift-ingress-operator patch ingresscontroller default -p '{"spec":{"tuningOptions":{"tunnelTimeout":"5s"}}}' --type=merge

# WebSocket server exposed as a secure edge terminated route with 15s tunnel timeout
oc apply -f manifests/ns.yaml
oc apply -f manifests
