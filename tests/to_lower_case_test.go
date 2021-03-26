package tests

import (
	"fmt"
	"regexp"
	"strings"
	"testing"
)

var matchAllCap = regexp.MustCompile("([a-z0-9])([A-Z])")

func ToSnakeCase(str string) string {
	snake := matchAllCap.ReplaceAllString(str, "${1}_${2}")
	return strings.ToLower(snake)
}

func TestToLowerCast(t *testing.T) {
	fmt.Println(ToSnakeCase("Tag"))
}
