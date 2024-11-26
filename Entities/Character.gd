class_name BaseCharacter extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var exp = Exp.get_xp()
	print_debug(exp)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
