extends SpinBox


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func saveObject() -> Dictionary:
	var dict := {
		"filepath": get_path(),
		"savedInt": var_to_str(value)
	}
	return dict
	
func loadObject(loadedDict: Dictionary) -> void:
	value = str_to_var(loadedDict.savedInt)
