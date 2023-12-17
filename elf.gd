extends CharacterBody2D
@export var snowball: PackedScene
var player: CharacterBody2D
var speed = 100
var alive = true
var hp = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "walk"
	$AnimatedSprite2D.play()

func elfInit(playerNode: CharacterBody2D):
	player = playerNode

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (alive && player != null):
		var playerLoc = to_global(player.position)
		var distance = to_global(position).distance_to(playerLoc)
		var moveTo = to_global(position).direction_to(playerLoc)
		velocity = moveTo * speed
		if (velocity.x > 0):
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		if (distance > 100):
			$AnimatedSprite2D.animation = "walk"
			move_and_slide()
		else:
			$AnimatedSprite2D.animation = "throw"


func _on_animated_sprite_2d_animation_looped():
	if ($AnimatedSprite2D.animation == "throw"):
		var ball = snowball.instantiate()
		ball.snowball_init(velocity/speed)
		add_child(ball)

func hit(damage):
	hp = hp - damage
	if (hp <= 0):
		alive = false
		$CollisionShape2D.disabled = true
		$AnimatedSprite2D.play("fire")
		$FireSound.play()

func _on_animated_sprite_2d_animation_finished():
	if ($AnimatedSprite2D.animation == "fire"):
		queue_free()
