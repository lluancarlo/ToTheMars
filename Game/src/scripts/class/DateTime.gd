class_name DateTime

var Day: int
var Month: int
var Year: int
var Hour: int
var Minute: int
var Second: int

func _init(day: int, month: int, year: int, hour: int, minute: int, second: int ):
	self.Day = day
	self.Month = month
	self.Year = year
	self.Hour = hour
	self.Minute = minute
	self.Second = second

func ConvertToString() -> String:
	return str(self.Day) + "/" + str(self.Month) + "/" + str(self.Year) + " at " + str(self.Hour) + ":" + str(self.Minute) + ":" + str(self.Second)
