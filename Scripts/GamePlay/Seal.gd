extends Spatial

signal killed(is_headshot)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func play_tone():
	get_tree().root.get_node("Game/AudioStreamPlayer").play()

func _on_Area_area_entered(area):
	#play_tone()
	if area.get_parent().get_groups().has("weapon"):
		play_tone()
		emit_signal("killed", false)
		queue_free()
		

