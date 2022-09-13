extends Spatial

onready var start_game_count_down_timer = $StartGameCountDownTimer
onready var game_play_timer = $GamePlayTimer
onready var game_results = $GameResults

const GAME_PLAY_DURATION = 30
const Point = {
	NORMAL = 10,
	HEADSHOT = 20
}

var current_left_time = GAME_PLAY_DURATION
var game_play_timer_left_time
var timer_watch
var seal_kill_count = 0
var headshot_count = 0
var score = 0
var GamePlayData = load("res://Scripts/Classes/GamePlayData.gd")

signal exit_to_menu

func _ready():
	game_play_timer.set_one_shot(true)
	game_play_timer.set_wait_time(GAME_PLAY_DURATION)
	
	for seal in $SealHolder.get_children():
		seal.connect("killed", self, "_on_Seal_killed")

func _process(delta):
	game_play_timer_left_time = ceil(game_play_timer.get_time_left())
	if current_left_time != game_play_timer_left_time:
		current_left_time = game_play_timer_left_time
		timer_watch.set_left_time(current_left_time)
		
		if current_left_time == 5:
			$AnnounceCloseToTimesUp.play()

func set_player(player):
	add_child(player, true)
	player.set_name("ARVROrigin")
	$ARVROrigin/LeftTouchController.connect("x_button_pressed", self, "_on_VRController_x_button_pressed")
	timer_watch = $ARVROrigin/LeftTouchController/TimerWatch
	timer_watch.set_left_time(GAME_PLAY_DURATION)
	timer_watch.set_visible(true)
	

func _on_VRController_x_button_pressed():
	stop_BGM()
	emit_signal("exit_to_menu")
	
func play_BGM():
	$BGM.play()

func stop_BGM():
	$BGM.stop()

func _on_StartGameCountDownTimer_timeout():
	$AnnounceGameStart.play()
	game_play_timer.start()
	play_BGM()

func _on_Seal_killed(is_headshot):
	
	seal_kill_count += 1
	
	if seal_kill_count == 10:
		$Announce10Kills.play()
	elif seal_kill_count == 20:
		$Announce20Kills.play()
	elif seal_kill_count == 30:
		$Announce30Kills.play()
	
	if is_headshot:
		headshot_count += 1
		score += Point.HEADSHOT
	else:
		score += Point.NORMAL


func _on_GamePlayTimer_timeout():
	$AnnounceTimesUp.play()
	stop_BGM()
	var game_results_data = GamePlayData.new()
	
	game_results_data.set_seal_count(seal_kill_count)
	game_results_data.set_headshot_count(headshot_count)
	game_results_data.set_score(score)
	
	game_results.show_game_results(game_results_data)
	
	
# 10 kills, 20 kills, 30 kills, game start, game times up, 5 seconds before end
