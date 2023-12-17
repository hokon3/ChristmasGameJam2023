extends CharacterBody2D

signal tree_destroyed

var damage_treshhold = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func hit(damage):
	if (damage >= damage_treshhold):
		$AnimatedSprite2D.animation = "fire"
		$AnimatedSprite2D.scale.x = 2
		$AnimatedSprite2D.scale.y = 2
		$FireSound.play()
		$CollisionShape2D.disabled = true


func _on_animated_sprite_2d_animation_finished():
	if ($AnimatedSprite2D.animation == "fire"):
		queue_free()
