package main

import (
	"fmt"
	"github.com/gorilla/websocket"
	"log"
)

func main() {
	serverAddr := "ws://localhost:8080/ws"

	conn, _, err := websocket.DefaultDialer.Dial(serverAddr, nil)
	if err != nil {
		log.Fatal("Error connecting to WebSocket:", err)
	}
	defer conn.Close()

	message := "Hello, WebSocket Server!"

	err = conn.WriteMessage(websocket.TextMessage, []byte(message))
	if err != nil {
		log.Fatal("Error sending message:", err)
	}

	log.Printf("Sent message: %s\n", message)

	mtype, response, err := conn.ReadMessage()
	if err != nil {
		log.Fatal("Error reading response:", err)
	}

	log.Printf("Received response: %s (%d)\n", response, mtype)
}
