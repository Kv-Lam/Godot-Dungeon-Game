extends Node

#Paths to configuration files.
const AUDIOS_PATH = "user://audio.cfg"
const KEYBINDS_PATH = "user://keybinds.cfg"

#Dictionaries to store settings.
var audio_settings : Dictionary = {}
var keybinds : Dictionary = {}

#Called when the node is ready
func _ready():
	#Load the saved audio and keybindings on start.
	load_audios()
	load_keybinds()

#Save audio settings to the configuration file.
func save_audios(bus_name: String, value: float) -> void:
	audio_settings[bus_name] = value
	save_audio()

#Save the keybindings to the configuration file.
func save_keybind(action_name: String, keycode: String) -> void:
	keybinds[action_name] = keycode
	save_keybinds()

#Load audio settings from the configuration file.
func load_audios() -> void:
	if FileAccess.file_exists(AUDIOS_PATH):
		var file = FileAccess.open(AUDIOS_PATH, FileAccess.READ)
		var data = file.get_as_text()
		
		# Create a JSON instance
		var json = JSON.new()
		
		# Parse the data
		var result = json.parse(data)
		
		if result == OK:
			audio_settings = json.get_data()
		file.close()

#Load keybindings from the configuration file.
func load_keybinds() -> void:
	if FileAccess.file_exists(KEYBINDS_PATH):
		var file = FileAccess.open(KEYBINDS_PATH, FileAccess.READ)
		var data = file.get_as_text()
		
		var json = JSON.new()
		
		var result = json.parse(data)
		
		if result == OK:
			keybinds = json.get_data()
		file.close()

#Save audio values to a file.
func save_audio() -> void:
	var file = FileAccess.open(AUDIOS_PATH, FileAccess.WRITE)
	
	var json_data = JSON.stringify(audio_settings)
	file.store_string(json_data)
	file.close()

#Save keybindings to a file.
func save_keybinds() -> void:
	var file = FileAccess.open(KEYBINDS_PATH, FileAccess.WRITE)
	
	var json_data = JSON.stringify(keybinds)
	file.store_string(json_data)
	file.close()

#Get a specific audio setting by bus name.
func load_audio(bus_name: String) -> float:
	return audio_settings.get(bus_name, 1.0) #Default to 1.0 if not set.

#Get the Key for a specific action name.
func load_keybind(action_name: String) -> Key:
	return OS.find_keycode_from_string(keybinds.get(action_name, "")) #Default empty string if not set.
