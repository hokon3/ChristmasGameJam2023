extends Node

@export var elfScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("mute"):
		if $BGMusic.playing:
			$BGMusic.stop()
		else:
			$BGMusic.play()

func new_game():
	$elfTimer.start()
	$Player.revive()
	
func game_over():
	$elfTimer.stop()
	get_tree().call_group("elfs", "queue_free")
	$hud.show_game_over()

func _on_elf_timer_timeout():
	var elf = elfScene.instantiate()
	elf.elfInit($Player)
	var elf_spawn_location = get_node("elfPath/elfSpawnLocation")
	elf_spawn_location.progress_ratio = randf()
	elf.position = elf_spawn_location.position
	add_child(elf)


func _on_santa_dead_santa():
	$hud.show_victory()
	get_tree().call_group("elfs", "queue_free")


func _on_player_health_change(health):
	$hud.update_health(health)
