#Kevin's
class_name MainMenu
extends Control

@onready var new_game = $"MainMenuButtons/New Game" as Button
@onready var load_game = $"MainMenuButtons/Load Game" as Button
@onready var options = $MainMenuButtons/Options as Button
@onready var quit_game = $"MainMenuButtons/Quit Game" as Button
@onready var options_panel = $OptionsPanel as PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	#new_game.pressed.connect() #Connect this to opening the menu to make a new game.
	#load_game.pressed.connect() #Connect this to open up a load game menu.
	options.pressed.connect(options_menu) #Connect this to open up an options menu.
	quit_game.pressed.connect(get_tree().quit)


func options_menu() -> void:
	options_panel.visible = true
