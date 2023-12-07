#!/usr/bin/env node

const host = process.env.HOST || 'localhost';
const port = process.env.PORT || 8080;
const scheme = process.env.SCHEME || 'ws';
const send = process.env.SEND || false;

process.env["NODE_TLS_REJECT_UNAUTHORIZED"] = 0;

var WebSocketClient = require('websocket').client;
var config = {
    keepalive: false
}
var client = new WebSocketClient(config);

client.on('connectFailed', function(error) {
    console.log('Connect Error: ' + error.toString());
});

client.on('connect', function(connection) {
    console.log('WebSocket Client Connected');
    connection.on('error', function(error) {
        console.log("Connection Error: " + error.toString());
    });
    connection.on('close', function() {
        console.log('echo-protocol Connection Closed');
    });
    connection.on('message', function(message) {
        if (message.type === 'utf8') {
            console.log("Received: '" + message.utf8Data + "'");
        }
    });

    function sendNumber() {
        if (connection.connected) {
            var number = Math.round(Math.random() * 0xFFFFFF);
            connection.sendUTF(number.toString());
            setTimeout(sendNumber, 100000);
        }
    }
    if (send) {
        sendNumber();
    }
});

client.connect(`${scheme}://${host}:${port}/`, 'echo-protocol');
