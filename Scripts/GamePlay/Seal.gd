extends Spatial

signal killed(is_headshot)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var squashed = false
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func kill_seal():
	set_scale(Vector3(1.5, 0.2, 1.5))


func play_tone():
	get_tree().root.get_node("Game/AudioStreamPlayer").play()

func _on_Area_area_entered(area):
	if !squashed and area.get_parent().get_groups().has("weapon"):
		squashed = true
		emit_signal("killed", false)
		kill_seal()
		play_tone()
		
		
		
		

