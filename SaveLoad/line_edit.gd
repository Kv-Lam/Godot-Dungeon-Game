extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	placeholder_text = "Text to save"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Grabs the information from the user and stores it in a dictionary
func saveObject() -> Dictionary:
	var dict := {
		"filepath": get_path(),
		"savedText": text
	}
	return dict
#Loads the information saved from the user
func loadObject(loadedDict: Dictionary) -> void:
	text = loadedDict.savedText
