extends Control

# Imports
onready var ApiService = get_node("/root/ApiService")

# Global Variables
onready var Http : HTTPRequest = $HTTPRequest
onready var LabelName : Label = $ContractContainer/NameContainer/LabelNameValue
onready var LabelTravelsMade : Label = $ContractContainer/BestDistanceContainer/LabelMaxDistanceValue
onready var LabelMaxDistance : Label = $ContractContainer/BestDistanceContainer/LabelMaxDistanceValue
onready var LabelLastTravel : Label = $ContractContainer/LastTravelContainer/LabelLastTravelValue
onready var InputPlayerName : LineEdit = $InputContainer/InputPlayerName
onready var ButtonContinue : Button = $ButtonContainer/CenterContainer/ButtonContinue
onready var ButtonStart : Button = $ButtonContainer/HBoxContainer/ButtonStart
onready var ButtonChangeUser : Button = $ButtonContainer/HBoxContainer/ButtonChangeUser
onready var LabelError : Label = $LeftDownContainer/LabelError
onready var AnimLoading : AnimatedSprite = $RightDownContainer/AnimatedLoad

# Functions
func ShowError(msg: String):
	self.LabelError.text = msg
	print(msg)

# Request Completed Functions
func GetPlayerInfoCompleted(result, response_code, headers, body):
	if response_code != 200:
		self.ShowError("Error in server request: response code " + str(response_code))
		self.LabelName.text = self.InputPlayerName.text
	else:
		var response = parse_json(body.get_string_from_utf8())
		var p = Player.new(str(response.Name), int(response.TopScore), int(response.Plays), str(response.LastPlayed), str(response.CreatedAt), str(response.UpdatedAt))
		
		self.LabelName.text = p.Name
		self.LabelLastTravel.text = p.LastPlayed.ConvertToString()
		self.LabelTravelsMade.text = str(p.Plays)
		self.LabelMaxDistance.text = str(p.TopScore)
		
	self.ButtonChangeUser.visible = true
	self.ButtonStart.visible = true
	self.AnimLoading.visible = false
		
# Actions Functions
func _on_InputPlayerName_text_changed(new_text: String):
	if new_text.length() > 2:
		self.ButtonContinue.visible = true
	else:
		self.ButtonContinue.visible = false

func _on_ButtonContinue_pressed():
	self.ButtonContinue.visible = false
	self.InputPlayerName.editable = false
	self.AnimLoading.visible = true
	
	Http.connect("request_completed", self, "GetPlayerInfoCompleted")
	var url := "http://127.0.0.1:3000/" + "player/" + self.InputPlayerName.text
	var err := Http.request(url, [], false, HTTPClient.METHOD_GET)
	
	if err != OK:
		self.ShowError("Error in server request: " + str(err))
		self.ButtonChangeUser.visible = true
		self.ButtonStart.visible = true
		self.AnimLoading.visible = false
	
func _on_ButtonChangeUser_pressed():
	self.ButtonChangeUser.visible = false
	self.ButtonStart.visible = false
	self.ButtonContinue.visible = true
	self.InputPlayerName.text = ""
	self.InputPlayerName.editable = true
	
	self.LabelName.text = "Newbie"
	self.LabelLastTravel.text = "Never"
	self.LabelTravelsMade.text = str("0")
	self.LabelMaxDistance.text = str("0")

func _on_ButtonStart_pressed():
	get_tree().change_scene("res://src/scenes/game.tscn")

# Engine Functions
func _ready():
	self.LabelError.text = ""
	self.ButtonContinue.visible = false
	self.ButtonStart.visible = false
	self.ButtonChangeUser.visible = false
	self.AnimLoading.visible = false
	self.Http.set_timeout(1)
	pass
