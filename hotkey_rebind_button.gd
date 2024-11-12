extends Control

@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button


@export var action_name: String = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_unhandled_key_input(false)


func set_action_name():
	label.text = "Unassigned"
	
	match action_name:
		"left":
			label.text = "Move Left"
		"right":
			label.text = "Move Right"
		"down":
			label.text = "Move Down"
		"up":
			label.text = "Move Up"
		"sprint":
			label.text = "Sprint Key"
		
