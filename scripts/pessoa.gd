extends KinematicBody2D

export var speed = 50
var nav = null setget set_nav
var path = []
var goal = Vector2()
onready var sprite = $Sprite
var dir = 0
var pos = Vector2()
var direction = 1

const FRENTE = 0
const COSTA = 1
const ESQUERDA  = 2
const DIREITA = 3

const NEGAO = 1

var fugir = false
var morto =  false

func _ready():
	pos  = position
	sprite.texture =  get_sprite_categoria()
	set_physics_process(true)
	
func get_sprite_categoria():
	var textura = load("res://assets/imgs/pessoas/negao/negao.png")
	return textura

func _physics_process(delta):
	if (fugir and not morto):
		set_direcao()
		if path.size() > 1:
			var d = position.distance_to(path[0])
			if d > 2:
				position =  position.linear_interpolate(path[0], (speed*delta/d))
			else:
				path.remove(0)
		else:
			queue_free()
	else:
		mover(delta)
		

func set_nav(new_nav):
	nav = new_nav
	update_path()

func update_path():
	path = nav.get_simple_path(position, goal, false)
	if path.size() == 0:
		pass
		

func set_direcao():
	var inter = 2
	if position.x > pos.x:
		dir =  DIREITA
	elif position.x < pos.x:
		dir = ESQUERDA
	elif position.y > pos.y:
		dir = FRENTE
	elif position.y < pos.y:
		dir = COSTA
		
	pos = position
	setAnimDirection()


func setAnimDirection():
	if dir == FRENTE:
		if fugir:
			$AnimationPlayer.play("front")
		else:
			$AnimationPlayer.play("parado")
	elif dir == COSTA:
		$AnimationPlayer.play("costa")
	elif dir == ESQUERDA:
		$AnimationPlayer.play("esquerda")
	elif dir == DIREITA:
		$AnimationPlayer.play("direita")
			
		
		

func _on_time_timeout():
	var result  = rand_range(0, 2)
	direction = -1 if result == 0 else 1


func mover(delta):
	set_direcao()
	setAnimDirection()
	var velocidade = Vector2()
	velocidade.x  += 10
	if not fugir:
		var movimento = move_and_slide(velocidade * delta)


func morrer():
	morto  = true
	remove_child($CollisionShape2D)
	$AnimationPlayer.play("morrer")
	$timeMorrer.start()
	

func avisarFuga():
	fugir =  true

func _on_timeMorrer_timeout():
	queue_free()
