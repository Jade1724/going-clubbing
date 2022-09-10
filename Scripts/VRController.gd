extends "res://addons/godot_ovrmobile/example_scenes/oculus_touch_controller.gd"

signal a_button_pressed

# this is a function connected to the button release signal from the controller
func _on_LeftTouchController_button_pressed(button):

	if (button == CONTROLLER_BUTTON.YB):
		pass
	

	if (button == CONTROLLER_BUTTON.XA):
		pass


func _on_RightTouchController_button_pressed(button):
	if (button == CONTROLLER_BUTTON.YB):
		pass

	if (button == CONTROLLER_BUTTON.XA):
		emit_signal("a_button_pressed")
