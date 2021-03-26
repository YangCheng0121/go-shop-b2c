package sysinit

func init() {
	logsInit()
	dbInit()
	corsInit()
	sysInit()
}
