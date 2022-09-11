extends Spatial

signal killed(is_headshot)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var squashed = false
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
	var dead_screem_id = rng.randi_range(0, 19)
	$DeathScreamPlayer.set_stream(load("res://Assets/Audio/deaths/death" + str(dead_screem_id) + ".wav"))

func kill_seal():
	set_scale(Vector3(1.5, 0.2, 1.5))
	$DeathScreamPlayer.play()

func play_tone():
	get_tree().root.get_node("Game/AudioStreamPlayer").play()

func _on_Area_area_entered(area):
	if !squashed and area.get_parent().get_groups().has("weapon"):
		squashed = true
		emit_signal("killed", false)
		kill_seal()
		
		
		
		

