extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	placeholder_text = "Text to save"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func saveObject() -> Dictionary:
	var dict := {
		"filepath": get_path(),
		"savedText": text
	}
	return dict
	
func loadObject(loadedDict: Dictionary) -> void:
	text = loadedDict.savedText
