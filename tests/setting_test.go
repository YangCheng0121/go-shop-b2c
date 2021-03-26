package tests

import (
	"encoding/xml"
	"fmt"
	"io/ioutil"
	"os"
	"testing"

	_ "github.com/astaxie/beego/config/xml"
	"github.com/astaxie/beego/logs"
)

type SConfig struct {
	XMLName xml.Name  `xml:"bee-shop-b2c"` // 指定最外层的标签为config
	Setting []Setting `xml:"setting"`      // 读取smtpServer配置项，并将结果保存到SmtpServer变量中
}

type Setting struct {
	Name  string `xml:"name,attr"`
	Value string `xml:"value,attr"`
}

func TestSetting(t *testing.T) {
	file, err := os.Open("../go-shop-b2c.xml") // For read access.
	if err != nil {
		panic(err)
	}
	defer file.Close()
	data, err := ioutil.ReadAll(file)
	logs.Info("data:", data)

	v := SConfig{}
	err = xml.Unmarshal(data, &v)
	for i, element := range v.Setting {
		fmt.Println(i, element)
	}
}
