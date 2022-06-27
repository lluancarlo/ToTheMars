extends Container

# Global Variables
onready var Firebase = get_node("/root/Firebase")
onready var _http : HTTPRequest = $HTTPRequestForm
onready var _nameValue : Label = $LabelNameValue
onready var _travelsMadeValue : Label = $LabelTravelsMadeValue
onready var _distanceValue : Label = $LabelMaxDistanceValue
onready var _lastTravelValue : Label = $LabelLastTravelValue
onready var _playerName : LineEdit = $InputPlayerName
onready var _continueButton : Button = $ButtonContinue
onready var _startButton : Button = $ButtonStart
onready var _changeUserButton : Button = $ButtonChangeUser

# Actions Functions
func _on_InputPlayerName_text_changed(new_text):
	if new_text.length() > 2:
		_continueButton.visible = true
	else:
		_continueButton.visible = false

func _on_ButtonContinue_pressed():
	_continueButton.visible = false
	_playerName.editable = false
	
	var player = yield(Firebase.get_playerInfo(_playerName.text, _http), "completed")
	
	if player == null:
		yield(Firebase.new_playerInfo(_playerName.text, _http), "completed")
		player = Player.new(_playerName.text, "Never", 0, 0)
		
	_nameValue.text = player.name
	_lastTravelValue.text = player.lastPlayed
	_travelsMadeValue.text = str(player.plays)
	_distanceValue.text = str(player.score)
	
	_changeUserButton.visible = true
	_startButton.visible = true
	
func _on_ButtonChangeUser_pressed():
	_changeUserButton.visible = false
	_startButton.visible = false
	_continueButton.visible = true
	_playerName.text = ""
	_playerName.editable = true
	
	_nameValue.text = "Newbie"
	_lastTravelValue.text = "Never"
	_travelsMadeValue.text = str("0")
	_distanceValue.text = str("0")

func _on_ButtonStart_pressed():
	get_tree().change_scene("res://src/scenes/game.tscn")

# Engine Functions
func _ready():
	_continueButton.visible = false
	_startButton.visible = false
	_changeUserButton.visible = false
	#Firebase.login(_http)
	pass
