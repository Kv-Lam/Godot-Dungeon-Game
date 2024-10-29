#Kevin's
extends PanelContainer

@onready var options_panel: PanelContainer = $"."
@onready var close_options: Button = $"MarginContainer/VBoxContainer/Close Options"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	close_options.pressed.connect(exit_options)
	pass # Replace with function body.


func exit_options() -> void:
	options_panel.visible = false
	
