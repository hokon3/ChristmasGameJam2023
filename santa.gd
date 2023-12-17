extends CharacterBody2D
signal deadSanta

var shield = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "idle"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func hit(damage):
	if shield:
		$Shield.visible = true
		$ShieldTimer.start()
	else:
		$CollisionShape2D.disabled = true
		$AnimatedSprite2D.play("fire")
		$FireSound.play()

func break_shield():
	if shield:
		shield = false
		$shieldBreakSFX.play(0.33)

func _on_animated_sprite_2d_animation_finished():
	if ($AnimatedSprite2D.animation == "fire"):
		queue_free()
		deadSanta.emit()


func _on_shield_timer_timeout():
	$Shield.visible = false
