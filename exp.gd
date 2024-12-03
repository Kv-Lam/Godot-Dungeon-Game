class_name levelxp extends Node

var xp: int = 0
var points: int = 0

func getXP() -> int:
	return xp

func levelUp(stat) -> int:
	if stat >= 10:
		print("Stat is maxed already")
		return 0
	else:
		stat + 1
		return stat
		
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
