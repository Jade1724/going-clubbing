extends Spatial


onready var seal_count_label = $SealCountSection/Viewport/VBoxContainer/Value
onready var headhshot_count_label = $HeadShotSection/Viewport/VBoxContainer/Value
onready var score_label = $ScoreSection/Viewport/VBoxContainer/Value

func show_game_results(data):
	if data:
		set_seal_count(data.get_seal_count())
		set_headshot_count(data.get_headshot_count())
		set_score_label(data.get_score())
		get_tree().root.get_node("Game/AudioStreamPlayer").play()
	
	set_visible(true)
	
func set_seal_count(count):
	seal_count_label.set_text(str(count))

	
func set_headshot_count(count):
	headhshot_count_label.set_text(str(count))


func set_score_label(count):
	score_label.set_text(str(count))
