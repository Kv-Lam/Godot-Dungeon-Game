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

func set_option_text() -> void:
	var action_events = InputMap.action_get_events(action_name)

	#Check if there are events for the action. If not, return early.
	if action_events.size() == 0:
		button.text = "Unassigned"
		return
	
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	button.text = "%s" % action_keycode

func _on_button_toggled(toggled_on: bool) -> void:
	if(toggled_on):
		button.text = "Press any key..."
		set_process_unhandled_key_input(toggled_on)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.set_process_unhandled_key_input(false)
	else:
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
		set_option_text()

func _unhandled_key_input(event: InputEvent) -> void:
	rebind_action_key(event)
	button.button_pressed = false

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

func load_keybind():
	#Load the keybind from the SettingsManager and apply it to the action.
	var keybind = SettingsManager.load_keybind(action_name)
	if keybind:
		var event = InputEventKey.new()
		event.physical_keycode = keybind
		InputMap.action_erase_events(action_name)
		InputMap.action_add_event(action_name, event)
		set_option_text()
