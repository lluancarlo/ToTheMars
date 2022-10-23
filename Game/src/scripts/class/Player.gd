class_name Player
const DateTime = preload("res://src/scripts/class/DateTime.gd")

var Name: String
var TopScore: int
var Plays: int
var LastPlayed: DateTime
var CreatedAt: DateTime
var UpdatedAt: DateTime

func _init(name: String, score: int, plays: int, lastPlayed: String, createdAt: String, updatedAt: String ):
	self.Name = name.replace(" ","").capitalize()
	self.TopScore = score
	self.Plays = plays
	self.LastPlayed = convertDate(lastPlayed)
	self.CreatedAt = convertDate(createdAt)
	self.UpdatedAt = convertDate(updatedAt)

func convertDate(date: String) -> DateTime:
	if date == "Null":
		return null
	
	var day = date.substr(8,2)
	var month = date.substr(5,2)
	var year = date.substr(0,4)
	var hour = date.substr(11,2)
	var minutes = date.substr(14,2)
	var seconds = date.substr(17,2)
	return DateTime.new(int(day), int(month), int(year), int(hour), int(minutes), int(seconds))
