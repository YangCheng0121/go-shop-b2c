package tests

import (
	"fmt"
	"testing"
	"time"
)

// 这是一个悲剧
func TestGoRoutine(t *testing.T) {
	fmt.Println("Reveal romantic feelings...")
	go sendLove()
	go responseLove()
	waitFor()
	fmt.Println("Leaving ☠️....")
}

func waitFor() {
	for i := 0; i < 5; i++ {
		fmt.Println("Keep waiting...")
		time.Sleep(1 * 1e9)
	}
}

func sendLove() {
	fmt.Println("Love you, mm ❤️")
}

func responseLove() {
	time.Sleep(6 * 1e9)
	fmt.Println("Love you, too")
}
