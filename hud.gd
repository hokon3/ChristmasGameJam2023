extends CanvasLayer
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_health(hp):
	for n in 3:
		var orbTag = "HealthOrb" + str(n+1)
		var orb = get_node(orbTag)
		if (orb):
			if (n + 1 > hp):
				get_node(orbTag).visible = false
			else:
				get_node(orbTag).visible = true

func _on_start_button_pressed():
	$Start_Button.visible = false
	$IntroImage.visible = false
	$IntroText.visible = false
	$Game_title.visible = false
	$CreditsButton.visible = false
	start_game.emit()
	
func show_game_over():
	$Restart_Button.visible = true
	$Game_over.visible = true
	
func show_victory():
	$Restart_Button.visible = true
	$Victory.visible = true

func _on_restart_button_pressed():
	get_tree().reload_current_scene()


func _on_credits_button_pressed():
	if ($creditsContainer.visible):
		$creditsContainer.visible = false
		$CreditsButton.text = "Show credits"
	else:
		$creditsContainer.visible = true
		$CreditsButton.text = "Hide credits"
