extends Spatial


signal exit_to_menu

func _ready():
	pass

func set_player(player):
	add_child(player, true)
	player.set_name("ARVROrigin")
	$ARVROrigin/LeftTouchController.connect("x_button_pressed", self, "_on_VRController_x_button_pressed")
	
func _on_VRController_x_button_pressed():
	emit_signal("exit_to_menu")	
