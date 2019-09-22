extends KinematicBody2D

#onready var nave = $"../player"  
export var speed = 50
var nav = null setget set_nav
var path = []
var goal = Vector2()

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	if path.size() > 1:
		var d = position.distance_to(path[0])
		if d > 2:
			position =  position.linear_interpolate(path[0], (speed*delta/d))
		else:
			path.remove(0)
	else:
		queue_free()

func set_nav(new_nav):
	nav = new_nav
	update_path()

func update_path():
	path = nav.get_simple_path(position, goal, false)

	if path.size() == 0:
		queue_free()
	



# Called every fram

func _process(delta):
	#ai_move()
	pass
	
func ai_get_direction():
	pass
	#return nave.position - self.position
	
func ai_move():
			var direction = ai_get_direction()
			var motion = direction.normalized() * speed
			move_and_slide(motion)
