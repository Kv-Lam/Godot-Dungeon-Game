#Kevin's

class_name MainMenu extends Control

@onready var new_game = $"MainMenuButtons/New Game" as Button
@onready var load_game = $"MainMenuButtons/Load Game" as Button
@onready var options: Button = $MainMenuButtons/Options
@onready var quit_game = $"MainMenuButtons/Quit Game" as Button
@onready var options_panel: PanelContainer = $OptionsPanel


#Called when the node enters the scene tree for the first time.
func _ready():
	new_game.pressed.connect(start_game)
	#load_game.pressed.connect() #Connect this to open up a load game menu, David.
	options.pressed.connect(options_menu)
	quit_game.pressed.connect(get_tree().quit)


func start_game() -> void:
	get_tree().change_scene_to_file("res://scenes/Room01.tscn")


func options_menu() -> void:
	options_panel.visible = true
