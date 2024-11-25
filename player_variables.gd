extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void: #Calling
	pass

func addingStats(points) -> int:
	if points == 10:
		print("Your ability is already maxed out")
	else:
		points += 1
	return points


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: #Always running
	#BASE STATS
	var lvl = 0
	var points = 0
	var exp = 0
	var health = 10
	var attack = 0
	var defense = 0
	var stamina_or_mana = 10
	var Ability = {0 : "Ability1", 3 : "Ability2", 6 : "Ability3", 9 : "Ultimate"}
	
	#leveling up
	var LastXP = 0
	var CurrentXP = 0
	var LevelUp = (LastXP + CurrentXP) * 3
	if CurrentXP >= LevelUp:
		lvl += 1
		points += 1
		#adding to stats
		print("Level Up an Stat: ")
		addingStats(stat)
	
	
	
