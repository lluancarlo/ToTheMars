extends Node

const USER_NAME := "game-client@mail.com"
const USER_PASS := "3kNMmndC8hofBA32"
const API_KEY := "AIzaSyDA0RWAUfRNrQ5VrbhGVGq8VNaNykL_Lhw"
const PROJECT_ID := "tothemars-godot"

const LOGIN_URL := "https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=%s" % API_KEY
const FIRESTORE_URL := "https://firestore.googleapis.com/v1/projects/%s/databases/(default)/documents/" % PROJECT_ID

var user_info := {}

func _get_user_info(result: Array) -> Dictionary:
	var result_body := JSON.parse(result[3].get_string_from_ascii()).result as Dictionary
	return {
		"token": result_body.idToken,
		"id": result_body.localId
	}

func _get_request_headers() -> PoolStringArray:
	return PoolStringArray([])

func login(http: HTTPRequest) -> void:
	var body := {
		"email": USER_NAME,
		"password": USER_PASS,
		"returnSecureToken": true
	}
	http.request(LOGIN_URL, [], false, HTTPClient.METHOD_POST, to_json(body))
	var result := yield(http, "request_completed") as Array
	if result[1] == 200:
		user_info = _get_user_info(result)

func get_playerInfo(playerName: String, http: HTTPRequest) -> Player:
	var url := FIRESTORE_URL + "players"
	http.request(url, _get_request_headers(), false, HTTPClient.METHOD_GET)
	var result := yield(http, "request_completed") as Array
	var response_code = result[1]
	match response_code:
		200:
			var response_body = JSON.parse(result[3].get_string_from_ascii())
			var players = response_body.result.documents
			
			for i in range(0, players.size()):
				if players[i].fields.name.stringValue.to_upper() == playerName.to_upper():
					return Player.new(
						str(players[i].fields.name["stringValue"]),
						str(players[i].fields.lastPlayed["stringValue"]),
						int(players[i].fields.maxScore["integerValue"]),
						int(players[i].fields.plays["integerValue"])
					)
					break
		_:
			print("User not found!")
			return null
	return null

func new_playerInfo(playerName: String, http: HTTPRequest) -> String:
	var document := { "fields": {
		"name": { "stringValue": playerName },
		"lastPlayed": { "stringValue": "Never" },
		"maxScore": { "integerValue": 0 },
		"plays": { "integerValue": 0 },
	}}
	var body := to_json(document)
	var url := FIRESTORE_URL + "players"
	http.request(url, _get_request_headers(), false, HTTPClient.METHOD_POST, body)
	var result := yield(http, "request_completed") as Array
	var response_code = result[1]
	match response_code:
		200:
			var response_body = JSON.parse(result[3].get_string_from_ascii())
			print(response_body.result)
			return "Player created successfully."
		_:
			return "Error on create player."

func update_playerInfo(fields: Dictionary, http: HTTPRequest) -> void:
	var document := { "fields": fields }
	var body := to_json(document)
	var url := FIRESTORE_URL + "players"
	http.request(url, _get_request_headers(), false, HTTPClient.METHOD_PATCH, body)
