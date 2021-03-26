package setting

import (
	"encoding/xml"
	"io/ioutil"
	"os"
	"time"
)

type SConfig struct {
	XMLName xml.Name  `xml:"go-shop-b2c"` // 指定最外层的标签为go-shop-b2c
	Setting []Setting `xml:"setting"`
}

type Setting struct {
	Name  string `json:"name"  xml:"name,attr"`
	Value string `json:"value" xml:",innerxml"`
}

func GetValueByKey(key string) (str string, err error) {
	s, err := GetAllSetting()
	if err != nil {
		return "", err
	}

	for _, v := range s {
		if v.Name == key {
			str = v.Value
		}
	}
	return str, nil
}

func ResolveImageUploadPath() (str string, err error) {
	str, err = GetValueByKey("imageUploadPath")
	if err != nil {
		return "", err
	}

	current := time.Now()
	return current.Format(str), nil
}

func UpdateSetting(s SConfig) (err error) {
	output, err := xml.MarshalIndent(&s, "", "	")
	if err != nil {
		return err
	}
	output = []byte(xml.Header + string(output))

	f, err := os.Create("./go-shop-b2c.xml")
	if err != nil {
		return err
	}
	defer f.Close()

	_, err = f.Write(output)
	if err != nil {
		return err
	}
	return
}

func GetAllSetting() (setting []Setting, err error) {
	file, err := os.Open("go-shop-b2c.xml") // For read access.
	if err != nil {
		return nil, err
	}

	defer file.Close()

	data, err := ioutil.ReadAll(file)

	v := SConfig{}
	err = xml.Unmarshal(data, &v)
	if err != nil {
		return nil, err
	}
	return v.Setting, nil
}
