extends Spatial

# == ARVR setup ========
var perform_runtime_config = false
onready var ovr_init_config = preload("res://addons/godot_ovrmobile/OvrInitConfig.gdns").new()
onready var ovr_performance = preload("res://addons/godot_ovrmobile/OvrPerformance.gdns").new()
# == End of ARVR setup =====

var game_play_scene = preload("res://Levels/GamePlay.tscn")
var menu_scene = preload("res://Levels/Menu.tscn")

#GREYS
var rng = RandomNumberGenerator.new()
#END GREYS

func _ready():
	setup_arvr_mode()
	$Menu.connect("play_game", self, "_on_Menu_play_game")
	#GREYS
	rng.randomzie()
	var Seal = get_tree().current_scene.get_node("Seal")
	var seal_anim = Seal.get_node("AnimationPlayer") #AnimationPlayer
	seal_anim.play("jump")
	#END GREYS

signal exit_to_menu


#randomly plays either jump or look about animation on a seal if it is not currently in an animation
func random_seal_animation(seal):
	var num = rng.randi_range(0,1)
	if num: # and seal not in animation !seal.is_playing()
		pass #play jump
	#elif: #!seal.is_playing()
	#	pass #seal idle
	
func setup_arvr_mode():
	var interface = ARVRServer.find_interface("OVRMobile")
	if interface:
		ovr_init_config.set_render_target_size_multiplier(1)

		if interface.initialize():
			get_viewport().arvr = true
			

func _process(_delta):
	if not perform_runtime_config:
		ovr_performance.set_clock_levels(1, 1)
		ovr_performance.set_extra_latency_mode(1)
		perform_runtime_config = true


func go_to_gameplay(player):
	var game_play_level_instance = game_play_scene.instance()
	
	add_child(game_play_level_instance, true)
	game_play_level_instance.set_name("GamePlay")
	game_play_level_instance.set_player(player)
	game_play_level_instance.connect("exit_to_menu", self, "_on_GamePlay_exit_to_menu")
	
	
func go_to_menu(player):
	var menu_level_instance = menu_scene.instance()
	
	add_child(menu_level_instance, true)
	menu_level_instance.set_name("Menu")
	menu_level_instance.set_player(player)
	menu_level_instance.connect("play_game", self, "_on_Menu_play_game")
	
func _on_Menu_play_game():
	
	# Detatch the player from Menu level
	var player = $Menu/ARVROrigin
	if player and player.get_parent():
		player.get_parent().remove_child(player)
	# Delete Menu level
	$Menu.queue_free()
	
	# Go to the GamePlay level
	go_to_gameplay(player)

func _on_GamePlay_exit_to_menu():
	
	# Detatch the player from Menu level
	var player = $GamePlay/ARVROrigin
	if player and player.get_parent():
		player.get_parent().remove_child(player)
	# Delete GamePlay scene
	$GamePlay.queue_free()
	
	go_to_menu(player)
