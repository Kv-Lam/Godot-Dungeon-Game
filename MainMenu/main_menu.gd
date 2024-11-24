#Kevin's
class_name MainMenu
extends Control

@onready var new_game = $"MainMenuButtons/New Game" as Button
@onready var load_game = $"MainMenuButtons/Load Game" as Button
@onready var options: Button = $MainMenuButtons/Options
@onready var quit_game = $"MainMenuButtons/Quit Game" as Button
@onready var options_panel: PanelContainer = $OptionsPanel


# Called when the node enters the scene tree for the first time.
func _ready():
	load_settings()
	#new_game.pressed.connect() #Connect this to opening the menu to make a new game.
	#load_game.pressed.connect() #Connect this to open up a load game menu.
	options.pressed.connect(options_menu) #Connects this to open up an options menu.
	quit_game.pressed.connect(get_tree().quit)


func options_menu() -> void:
	options_panel.visible = true


# Load the settings from the file
#func load_settings():
	#var config = ConfigFile.new()
#
	## Check if the config file exists, then load it
	#if config.load("user://settings.cfg") == OK:
		#print("Found file.")
		## Set audio volumes, with default 1
		#for audio_name in config.get_section_keys("audio"):
			#AudioServer.set_bus_volume_db(AudioServer.get_bus_index(audio_name), config.get_value("audio", audio_name, 1))
		#
		## Set keybinds, with default key for each
		#for keybind_name in config.get_section_keys("input"):
			#InputMap.action_erase_events(keybind_name)
			#var new_event = InputEventKey.new()
			#new_event.physical_keycode = config.get_value("input", keybind_name) 
			#InputMap.action_add_event(keybind_name, new_event)
	#else:
		## If the settings file doesn't exist, print a warning (or apply default settings)
		#apply_default_keybinds()
		
func load_settings():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
	# Set audio. Default 1.
		for audio_name in config.get_section_keys("audio"):
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index(audio_name), config.get_value("audio", audio_name, 1))
		
			# Set keybinds.
		for keybind_name in config.get_section_keys("input"):
			var keybind_value = config.get_value("input", keybind_name, KEY_UNKNOWN)
			if keybind_value != KEY_UNKNOWN:
				# Add the action to InputMap if not already added
				if not InputMap.has_action(keybind_name):
					InputMap.add_action(keybind_name)
				
				# Add the event to the action
				var new_event = InputEventKey.new()
				new_event.physical_keycode = keybind_value
				InputMap.action_erase_events(keybind_name)
				InputMap.action_add_event(keybind_name, new_event)



func apply_default_keybinds() -> void:
	#Set default keybinds
	var key_event = InputEventKey.new()
	key_event.physical_keycode = KEY_A
	InputMap.action_add_event("left", key_event)
	
	key_event = InputEventKey.new()
	key_event.physical_keycode = KEY_D
	InputMap.action_add_event("right", key_event)
	
	key_event = InputEventKey.new()
	key_event.physical_keycode = KEY_W
	InputMap.action_add_event("up", key_event)
	
	key_event = InputEventKey.new()
	key_event.physical_keycode = KEY_S
	InputMap.action_add_event("left", key_event)
	
	key_event = InputEventKey.new()
	key_event.physical_keycode = KEY_SHIFT
	InputMap.action_add_event("sprint", key_event)
	
	key_event = InputEventKey.new()
	key_event.physical_keycode = KEY_SPACE
	InputMap.action_add_event("interact", key_event)
