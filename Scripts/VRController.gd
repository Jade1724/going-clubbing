extends "res://addons/godot_ovrmobile/example_scenes/oculus_touch_controller.gd"

signal a_button_pressed
signal x_button_pressed

# Temporary signal for debugging TODO Remove later
signal killed(is_headhshot)

# this is a function connected to the button release signal from the controller
func _on_LeftTouchController_button_pressed(button):

	if (button == CONTROLLER_BUTTON.YB):
		# TODO move this signal to Seal later
		emit_signal("killed", true) # headshot

	if (button == CONTROLLER_BUTTON.XA):
		emit_signal("x_button_pressed")

func _on_RightTouchController_button_pressed(button):
	if (button == CONTROLLER_BUTTON.YB):
		# TODO move this signal to Seal later
		emit_signal("killed", false) # normal kill

	if (button == CONTROLLER_BUTTON.XA):
		emit_signal("a_button_pressed")
