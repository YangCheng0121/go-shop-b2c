package tests

import (
	"github.com/astaxie/beego/logs"
	"testing"
)

func TestTotalFee(t *testing.T) {
	var totalFee int
	totalFee = 1
	logs.Info("TotalFee:", totalFee)
	logs.Info("TotalFee-int64", int64(totalFee))
	logs.Info("TotalFee-int64/100", float64(int64(totalFee))/100)
}
