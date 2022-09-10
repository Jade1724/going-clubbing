extends Spatial

signal play_game

func _ready():
	$ARVROrigin/RightTouchController.connect("a_button_pressed", self, "_on_VRController_a_button_pressed")


func _on_VRController_a_button_pressed():
	get_tree().root.get_node("Game/AudioStreamPlayer").play()
	emit_signal("play_game")	
