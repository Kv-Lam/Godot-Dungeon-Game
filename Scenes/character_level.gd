extends Control

@onready var node_stat_points = get_node("HBoxContainer/VBoxContainer/HBoxContainer/MainStats/HBoxContainer/Points")
var path_main_stats = "HBoxContainer/VBoxContainer/HBoxContainer/MainStats"

var availablePoints = 5
var healthAdd = 0 
var manaAdd = 0 
var attackAdd = 0 
var defenseAdd = 0 
var dodgeAdd = 0 

func _ready() -> void:
	node_stat_points.set_text(str(availablePoints) + " Points")
	if availablePoints == 0:
		pass
	else:
		for button in get_tree().get_nodes_in_group("PlusButtons"):
			button.set_disabled(false)
	for button in get_tree().get_nodes_in_group("PlusButtons"):
		button.connect("pressed", self, "IncreaseStat", [button.get_node("../..").get_name()])
	for button in get_tree().get_nodes_in_group("MinButtons"):
		button.connect("pressed", self, "DecreaseStat", [button.get_node("../..").get_name()])
		
		
func IncreaseStat(stat):
	print(stat + "Plus")
	
	
func DecreaseStat(stat):
	print(stat + "Minus")
