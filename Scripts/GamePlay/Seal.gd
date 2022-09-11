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
	
	var dead_screem_id = rng.randi_range(0, 10)
	var death_sound_id = rng.randi_range(12, 19)
	$DeathScreamPlayer.set_stream(load("res://Assets/Audio/deaths/death" + str(dead_screem_id) + ".wav"))
	$DeathSoundPlayer.set_stream(load("res://Assets/Audio/deaths/death" + str(death_sound_id) + ".wav"))

func kill_seal():
	set_scale(Vector3(1.5, 0.2, 1.5))
	$DeathScreamPlayer.play()
	$DeathSoundPlayer.play()

func play_tone():
	get_tree().root.get_node("Game/AudioStreamPlayer").play()

func _on_Area_area_entered(area):
	if !squashed and area.get_parent().get_groups().has("weapon"):
		squashed = true
		emit_signal("killed", false)
		kill_seal()

func _on_HeadArea_area_entered(area):
	if !squashed and area.get_parent().get_groups().has("weapon"):
		squashed = true
		emit_signal("killed", true)
		kill_seal()
