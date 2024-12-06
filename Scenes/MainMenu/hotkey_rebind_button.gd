extends Control

@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button
@onready var keybind_duplicate = $"../../../../Keybind Duplicate" as AcceptDialog

@export var action_name: String = "left"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_unhandled_key_input(false)
	load_keybind()
	set_action_name()
	set_option_text()


#Sets text for different keybinds.
func set_action_name():
	label.text = "Unassigned"
	
	match action_name:
		"left":
			label.text = "Move Left"
		"right":
			label.text = "Move Right"
		"up":
			label.text = "Move Up"
		"down":
			label.text = "Move Down"
		"sprint":
			label.text = "Sprint"
		"interact":
			label.text = "Interact"


#Set text for what the player has set the keybind as.
func set_option_text() -> void:
	var action_events = InputMap.action_get_events(action_name)

	#Check if there are action events. If not, return early. Just for safety.
	if action_events.size() == 0:
		button.text = "Unassigned"
		return
	
	var action_event = action_events[0] #Gets name of the action event.
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode) #Gets the keybind associated with the action event.
	
	button.text = "%s" % action_keycode #Sets what key is displayed.

#For when the player is setting a keybind for an action event.
func _on_button_toggled(toggled_on: bool) -> void:
	if(toggled_on): #Player has selected a keybind to change, so update that one.
		button.text = "Press any key..."
		set_process_unhandled_key_input(toggled_on)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.set_process_unhandled_key_input(false) #Disables key input handling for other buttons.
	else: #Resets all the buttons back to how they originally were (displaying their keybind) if clicked off.
		for i in get_tree().get_nodes_in_group("hotkey_button"): #Resets other buttons.
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
		set_option_text()



func _unhandled_key_input(event: InputEvent) -> void:
	rebind_action_key(event)
	button.button_pressed = false


#Rebinds a keybind.
func rebind_action_key(event: InputEvent) -> void:
	var is_duplicate = false #Used to make sure no duplicate keybinds.
	var action_event = event
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	#Check if there is a duplicate keybind.
	for i in get_tree().get_nodes_in_group("hotkey_button"):
		if i.action_name != self.action_name: #Makes sure the player is not using the previous assigned key.
			if i.button.text == "%s" % action_keycode: #Checks if the key the user entered is the same as a previous keybind.
				is_duplicate = true
				keybind_duplicate.visible = true
				break

	if not is_duplicate:
		# Update the InputMap directly.
		InputMap.action_erase_events(action_name)
		InputMap.action_add_event(action_name, event)
		set_process_unhandled_key_input(false)
		set_option_text() #Update displayed keybind.
		get_viewport().gui_release_focus() #Makes the button no longer focused after inputting a valid keybind.

		#Save the new keybinding in the SettingsManager.
		SettingsManager.save_keybind(action_name, action_keycode)


#Load the keybind from the SettingsManager and apply it to the action.
func load_keybind():
	var keybind = SettingsManager.load_keybind(action_name)
	if keybind:
		var event = InputEventKey.new()
		event.physical_keycode = keybind
		InputMap.action_erase_events(action_name)
		InputMap.action_add_event(action_name, event)
		set_option_text()
