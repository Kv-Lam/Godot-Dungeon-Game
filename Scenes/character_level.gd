extends Control

#creating variables so the pathing in the code is shorter
@onready var node_stat_points = get_node("HBoxContainer/VBoxContainer/HBoxContainer/MainStats/HBoxContainer/Points")
var path_main_stats = "./HBoxContainer/VBoxContainer/HBoxContainer/MainStats"

#dynamic variables that will change as players level up
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
		#defaulting buttons to be disabled so you cant click it
		for button in get_tree().get_nodes_in_group("PlusButtons"):
			button.set_disabled(false)
	#connecting all of the buttons
	for button in get_tree().get_nodes_in_group("PlusButtons"):
		button.connect("pressed", Callable(IncreaseStat.bind(button.get_node("../..").get_name())))
	for button in get_tree().get_nodes_in_group("MinButtons"):
		button.connect("pressed", Callable(DecreaseStat.bind(button.get_node("../..").get_name())))
		
#function to increase player stats
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

#function to decrease stat points
func DecreaseStat(stat):
	#instead of +0 when decreasing past 10 this code makes the text box disappear
	set(stat.to_lower() + "Add", get(stat.to_lower() + "Add") - 10)
	#disabling decrease so the button cannot be pressed anymore pass 0
	if get(stat.to_lower() + "Add") == 0:
		get_node(path_main_stats + "/" + stat + "/StatBackground/Minus").set_disabled(true)
		get_node(path_main_stats + "/" + stat + "/StatBackground/Stat/Change").set_text("")
	else:
		get_node(path_main_stats + "/" + stat + "/StatBackground/Stat/Change").set_text("+" + str(get(stat.to_lower()
	#adding back available points																			+ "Add")) + " ")
	availablePoints += 1
	node_stat_points.set_text(str(availablePoints) + " Points")
	for button in get_tree().get_nodes_in_group("PlusButtons"):
		button.set_disabled(false)
