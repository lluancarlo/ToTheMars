class_name Player

var name: String
var lastPlayed: String
var score: int
var plays: int

func _init(name: String, lastPlayed: String, score: int, plays: int ):
	self.name = name.replace(" ","").capitalize()
	self.score = score
	self.plays = plays
	if lastPlayed.length() > 18:
		self.lastPlayed = convertDate(lastPlayed)
	else:
		self.lastPlayed = "Never"

#{day:25, dst:True, hour:21, minute:11, month:6, second:54, weekday:6, year:2022}
func convertDate(date: String):
	var obj = date.replace("{","").replace("}","").split(",")
	var day = obj[0].split(":")[1]
	var month = obj[4].split(":")[1]
	var year = obj[7].split(":")[1]
	var hour = obj[2].split(":")[1]
	var minutes = obj[3].split(":")[1]
	var seconds = obj[5].split(":")[1]
	return "%s/%s/%s at %s:%s:%s" % [day, month, year, hour, minutes, seconds]
