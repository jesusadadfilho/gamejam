		extends KinematicBody2D

var movimento = Vector2()
const UP = Vector2(0, -1)
onready var animateNav = get_node("AnimationPlayer")
var pousado =  false
signal pousar

func _physics_process(delta):
	
	if pousado:
		emit_signal("pousar", self)
		
	if Input.is_action_pressed("ui_up"):
		if self.scale.x == 1 and self.scale.y == 1:
			if movimento.y > -300: 
				movimento.y -= 30
			if Input.is_action_pressed("ui_right"):
				movimento.x = 100
			elif Input.is_action_pressed("ui_left"):
				movimento.x = -100
			if movimento.x != 0:
				if movimento.x < 0:
					movimento.x += 5
				else:
					movimento.x -= 5
	
	elif Input.is_action_pressed("ui_down"):
		if self.scale.x == 1:
			movimento.y = 100
	elif Input.is_action_just_pressed("aterisar"):
		if self.scale.x == 1:
			animateNav.play("aterisar")
			pousado = true
		else:
			animateNav.play("decolar")
			pousado = false
			
	else:
		movimento.y = 0
		if self.scale.x == 1 and self.scale.y == 1:
			if Input.is_action_pressed("ui_right"):
				movimento.x = 100
			elif Input.is_action_pressed("ui_left"):
				movimento.x = -100
			else:
				movimento.x = 0
			
			
	
	
	
	
	movimento = move_and_slide(movimento, UP)
	
	

func _ready():
	pass

func _on_Timer_timeout():
	$AudioStreamPlayer.play()
