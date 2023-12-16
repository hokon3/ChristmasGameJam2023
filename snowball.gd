extends Area2D
var speed = 2
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func snowball_init(direction):
	velocity = direction * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity


func _on_body_entered(body):
	if (body.has_method("snowballed")):
		body.call_deferred("snowballed")
		queue_free()
	elif body.name == "TileMap":
		queue_free()
