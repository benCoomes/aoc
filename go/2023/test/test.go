package test

import "testing"

func Report[C comparable](t *testing.T, value C, expected C, err error) {
	if err != nil {
		t.Fatalf(err.Error())
	}

	var zeroVal C
	if expected == zeroVal {
		t.Logf("Value: %v", value)
	} else {
		if value != expected {
			t.Fatalf("Expected %v but got %v", expected, value)
		} else {
			t.Logf("Pass! Value: %v", value)
		}
	}
}
