#Kevin's
class_name MainMenu
extends Control

@onready var new_game = $"MainMenuButtons/New Game" as Button
@onready var load_game = $"MainMenuButtons/Load Game" as Button
@onready var options: Button = $MainMenuButtons/Options
@onready var quit_game = $"MainMenuButtons/Quit Game" as Button
@onready var options_panel: PanelContainer = $OptionsPanel


#Called when the node enters the scene tree for the first time.
func _ready():
	#new_game.pressed.connect() #Connect this to opening the menu to make a new game.
	#load_game.pressed.connect() #Connect this to open up a load game menu.
	options.pressed.connect(options_menu) #Connects this to open up an options menu.
	quit_game.pressed.connect(get_tree().quit)


func options_menu() -> void:
	options_panel.visible = true


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
