extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var screen_size
var velocity = Vector2()
export var speed =   50
export var direction  =  1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.flip_h = false if direction == -1 else true
	velocity.x += speed * direction
	set_process(true)
	screen_size = get_viewport_rect().size
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _process(delta):
	
	position += (velocity * delta) 
	
	if position.x > screen_size.x and direction == 1:
		queue_free() 
		
	if position.x < 10 and direction == -1:
		queue_free() 
	#position.x = clamp(position.x, 0, screen_size.x)


func _on_carro_body_entered(body):
	if body.name ==  "Pessoa":
		body.morrer()
		
