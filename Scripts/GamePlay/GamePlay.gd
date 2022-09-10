extends Spatial

onready var start_game_count_down_timer = $StartGameCountDownTimer
onready var game_play_timer = $GamePlayTimer

const GAME_PLAY_DURATION = 30

var current_left_time = GAME_PLAY_DURATION
var game_play_timer_left_time
var timer_watch

signal exit_to_menu

func _ready():
	game_play_timer.set_one_shot(true)
	game_play_timer.set_wait_time(GAME_PLAY_DURATION)
	

func _process(delta):
	game_play_timer_left_time = ceil(game_play_timer.get_time_left())
	if current_left_time != game_play_timer_left_time:
		current_left_time = game_play_timer_left_time
		timer_watch.set_left_time(current_left_time)

func set_player(player):
	add_child(player, true)
	player.set_name("ARVROrigin")
	$ARVROrigin/LeftTouchController.connect("x_button_pressed", self, "_on_VRController_x_button_pressed")
	timer_watch = $ARVROrigin/LeftTouchController/TimerWatch
	timer_watch.set_visible(true)
	
func _on_VRController_x_button_pressed():
	emit_signal("exit_to_menu")
	

func _on_StartGameCountDownTimer_timeout():
	game_play_timer.start()
