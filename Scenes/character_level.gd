extends Control

@onready var node_stat_points = get_node("HBoxContainer/VBoxContainer/HBoxContainer/MainStats/HBoxContainer/Points")
var path_main_stats = "./HBoxContainer/VBoxContainer/HBoxContainer/MainStats"

var availablePoints = 5
var healthAdd = 0 
var manaAdd = 0 
var attackAdd = 0 
var defenseAdd = 0 
var dodgeAdd = 0 


func _ready():
	node_stat_points.set_text(str(availablePoints) + " Points")
	if availablePoints == 0:
		pass
	else:
		for button in get_tree().get_nodes_in_group("PlusButtons"):
			button.set_disabled(false)
	for button in get_tree().get_nodes_in_group("PlusButtons"):
		button.connect("pressed", Callable(IncreaseStat.bind(button.get_node("../..").get_name())))
	for button in get_tree().get_nodes_in_group("MinButtons"):
		button.connect("pressed", Callable(DecreaseStat.bind(button.get_node("../..").get_name())))
		
		
func IncreaseStat(stat):
	set(stat.to_lower() + "Add", get(stat.to_lower() + "Add") + 10)
	get_node(path_main_stats + "/" + stat + "/StatBackground/Stat/Change").set_text("+" + str(get(stat.to_lower() 
																				+ "Add")) + " ")
	#unlocking minus button
	get_node(path_main_stats + "/" + stat + "/StatBackground/Minus").set_disabled(false)
	#reduce available stat points
	availablePoints -= 1
	#update available stat point in lable
	node_stat_points.set_text(str(availablePoints) + " Points")
	#if available points is 0
	if availablePoints == 0:
		for button in get_tree().get_nodes_in_group("PlusButtons"):
			button.set_disabled(true)

func DecreaseStat(stat):
	set(stat.to_lower() + "Add", get(stat.to_lower() + "Add") - 10)
	if get(stat.to_lower() + "Add") == 0:
		get_node(path_main_stats + "/" + stat + "/StatBackground/Minus").set_disabled(true)
		get_node(path_main_stats + "/" + stat + "/StatBackground/Stat/Change").set_text("")
	else:
		get_node(path_main_stats + "/" + stat + "/StatBackground/Stat/Change").set_text("+" + str(get(stat.to_lower()
																				+ "Add")) + " ")
	availablePoints += 1
	node_stat_points.set_text(str(availablePoints) + " Points")
	for button in get_tree().get_nodes_in_group("PlusButtons"):
		button.set_disabled(false)
