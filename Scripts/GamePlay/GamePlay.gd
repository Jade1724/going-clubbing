extends Spatial

onready var start_game_count_down_timer = $StartGameCountDownTimer
onready var game_play_timer = $GamePlayTimer

const GAME_PLAY_DURATION = 30

var current_left_time = GAME_PLAY_DURATION
var game_play_timer_left_time
var timer_watch
var seal_kill_count = 0
var rng = RandomNumberGenerator.new()

signal exit_to_menu

func _ready():
	rng.randomzie()
	var Seal = get_tree().current_scene.get_note("Seal")
	var seal_anim = Seal.get_node("AnimatedSprite")
	seal_anim.play("jump")
	game_play_timer.set_one_shot(true)
	game_play_timer.set_wait_time(GAME_PLAY_DURATION)
	

#randomly plays either jump or look about animation on a seal if it is not currently in an animation
func random_seal_animation(seal):
	var num = rng.randi_range(0,1)
	if num: # and seal not in animation !seal.is_playing()
		pass #play jump
	#elif: #!seal.is_playing()
	#	pass #seal idle
	

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
	
	# TODO connect from seal
	$ARVROrigin/LeftTouchController.connect("killed", self, "_on_Seal_killed")
	
func _on_VRController_x_button_pressed():
	emit_signal("exit_to_menu")
	

func _on_StartGameCountDownTimer_timeout():
	game_play_timer.start()

func _on_Seal_killed():
	seal_kill_count += 1

func _on_GamePlayTimer_timeout():
	get_tree().root.get_node("Game/AudioStreamPlayer").play()
	
	
