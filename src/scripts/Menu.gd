extends Container

# Imports
onready var Firebase = get_node("/root/Firebase")

# Global Variables
onready var Http : HTTPRequest = $HTTPRequestForm
onready var NameValue : Label = $LabelNameValue
onready var TravelsMadeValue : Label = $LabelTravelsMadeValue
onready var DistanceValue : Label = $LabelMaxDistanceValue
onready var LastTravelValue : Label = $LabelLastTravelValue
onready var PlayerName : LineEdit = $InputPlayerName
onready var ContinueButton : Button = $ButtonContinue
onready var StartButton : Button = $ButtonStart
onready var ChangeUserButton : Button = $ButtonChangeUser

# Actions Functions
func _on_InputPlayerName_text_changed(new_text):
	if new_text.length() > 2:
		self.ContinueButton.visible = true
	else:
		self.ContinueButton.visible = false

func _on_ButtonContinue_pressed():
	self.ContinueButton.visible = false
	self.PlayerName.editable = false
	
	var player = yield(Firebase.get_playerInfo(self.PlayerName.text, self.Http), "completed")
	
	if player == null:
		yield(Firebase.new_playerInfo(self.PlayerName.text, self.Http), "completed")
		player = Player.new(self.PlayerName.text, "Never", 0, 0)
		
	self.NameValue.text = player.Name
	self.LastTravelValue.text = player.LastPlayed
	self.TravelsMadeValue.text = str(player.Plays)
	self.DistanceValue.text = str(player.Score)
	
	self.ChangeUserButton.visible = true
	self.StartButton.visible = true
	
func _on_ButtonChangeUser_pressed():
	self.ChangeUserButton.visible = false
	self.StartButton.visible = false
	self.ContinueButton.visible = true
	self.PlayerName.text = ""
	self.PlayerName.editable = true
	
	self.NameValue.text = "Newbie"
	self.LastTravelValue.text = "Never"
	self.TravelsMadeValue.text = str("0")
	self.DistanceValue.text = str("0")

func _on_ButtonStart_pressed():
	get_tree().change_scene("res://src/scenes/game.tscn")

# Engine Functions
func _ready():
	self.ContinueButton.visible = false
	self.StartButton.visible = false
	self.ChangeUserButton.visible = false
	#Firebase.login(_http)
	pass
