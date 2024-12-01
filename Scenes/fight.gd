extends Control


@onready var fight_button = $ColorRect/HBoxContainer/ColorRect/BottomContainer/Fight as Button
@onready var guard_button = $ColorRect/HBoxContainer/ColorRect/BottomContainer/Guard as Button
@onready var inventory_button = $ColorRect/HBoxContainer/ColorRect/BottomContainer/Inventory as Button
@onready var escape_button = $ColorRect/HBoxContainer/ColorRect/BottomContainer/Escape as Button


# Called when the node enters the scene tree for the first time.
func _ready():
	fight_button.pressed.connect(fight)
	guard_button.pressed.connect(guard)
	inventory_button.pressed.connect(open_inventory)
	escape_button.pressed.connect(escape)

func fight() -> void:
	print("Fight.")


func guard() -> void:
	print("Guard.")


func open_inventory() -> void:
	print("Open Inventory.")


func escape() -> void:
	print("Escape.")
