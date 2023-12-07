package test

import "testing"

func Report(t *testing.T, value string, expected string, err error) {
	if err != nil {
		t.Fatalf(err.Error())
	}

	if expected == "" {
		t.Logf("Value: %v", value)
	} else {
		if value != expected {
			t.Fatalf("Expected %v but got %v", expected, value)
		} else {
			t.Logf("Pass! Value: %v", value)
		}
	}
}
