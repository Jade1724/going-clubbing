extends Spatial

signal play_game

func _ready():
	
	# The first time the game is loaded. 
	if $ARVROrigin:
		$ARVROrigin/RightTouchController.connect("a_button_pressed", self, "_on_VRController_a_button_pressed")


func set_player(player):
	add_child(player, true)
	player.set_name("ARVROrigin")
	$ARVROrigin/RightTouchController.connect("a_button_pressed", self, "_on_VRController_a_button_pressed")


func _on_VRController_a_button_pressed():
	emit_signal("play_game")	
