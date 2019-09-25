		extends KinematicBody2D

var movimento = Vector2()
const UP = Vector2(0, -1)
onready var chamaPrinc = get_node("FogoPrinc")
onready var chamaSecEsc = get_node("FogoSecEsc")
onready var chamaSecDir = get_node("FogoSecDir")
var pousado =  false
signal pousar

func conectarPessoa(pessoa):
	connect("pousar", pessoa, "avisarFuga", ["marcelo"])

func _physics_process(delta):

	
	if pousado:
		emit_signal("pousar", "marceçp")
		
	if Input.is_action_pressed("ui_up"):
		if self.scale.x == 1:
			if movimento.y > -300: 
				movimento.y -= 30
			chamaPrinc.set_region_rect(Rect2(0,0,0.009,0.009))
			chamaPrinc.show()
			if Input.is_action_pressed("ui_right"):
				movimento.x = 100
				chamaSecEsc.show()
			elif Input.is_action_pressed("ui_left"):
				movimento.x = -100
				chamaSecDir.show()
			if movimento.x != 0:
				if movimento.x < 0:
					movimento.x += 5
				else:
					movimento.x -= 5
			else:
				chamaSecDir.hide()
				chamaSecEsc.hide()
		else:
			self.scale.x += 0.01
			self.scale.y += 0.01
	elif Input.is_action_pressed("ui_down"):
		if self.scale.x == 1:
			movimento.y = 100
			chamaSecDir.show()
			chamaSecEsc.show()
	elif Input.is_action_pressed("aterisar"):
		if self.scale.x > 0.6:
			self.scale.x -= 0.01
			self.scale.y -= 0.01
		else:
			pousado = true
	else:
		chamaPrinc.hide()
		chamaSecDir.hide()
		chamaSecEsc.hide()
		movimento.y = 0
		if self.scale.x == 1:
			if Input.is_action_pressed("ui_right"):
				movimento.x = 100
				chamaSecEsc.show()
			elif Input.is_action_pressed("ui_left"):
				movimento.x = -100
				chamaSecDir.show()
			else:
				movimento.x = 0
			
			
	
	if is_on_floor():
		chamaSecDir.hide()
		chamaSecEsc.hide()
		movimento.x = 0
		if Input.is_action_pressed("ui_up"):
			movimento.y = -100
	
	
	movimento = move_and_slide(movimento, UP)
	
	if position.x <= -110:
		position.x = 2000
	elif position.x >= 2000:
		position.x = -110
	

func _ready():
	pass



