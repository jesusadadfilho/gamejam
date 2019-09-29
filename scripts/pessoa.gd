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
const BRUGUELO = 2
const VELHO = 3
const MULHER = 4

signal morrir

var pontuacaoTotal = 0

var fugir = false
var morto =  false

func _ready():
	randomize()
	pos  = position
	setCategoria()
	set_physics_process(true)

func setCategoria():
	var pessoa = int(rand_range(1,5))	
	if pessoa == NEGAO:
		speed = rand_range(40,50)
		set_sprite_categoria("negao")
	elif pessoa == BRUGUELO:
		speed = rand_range(20,30)
		set_sprite_categoria("menino")
	elif pessoa == VELHO:
		speed = rand_range(10,20)
		set_sprite_categoria("velho")
	elif pessoa == MULHER:
		speed = rand_range(20,30)
		set_sprite_categoria("mulher")
	
func set_sprite_categoria(cat):
	var textura = load("res://assets/imgs/pessoas/%s.png" % cat)
	sprite.texture = textura

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
			pontuacaoTotal += 1
			print(pontuacaoTotal)
			queue_free()
	else:
		mover(delta)
		

func set_nav(new_nav):
	nav = new_nav

func update_path():
	path = nav.get_simple_path(position, goal, false)
	if path.size() == 0:
		queue_free()
		

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
	$AnimationPlayer.play("morrer")
	remove_child($CollisionShape2D)
	$timeMorrer.start()
	emit_signal("morrir")

func conectarObject(object):
	connect("morrir", object, "removePessoa")
	

func avisarFuga():
	update_path()
	fugir =  true

func _on_timeMorrer_timeout():
	queue_free()
