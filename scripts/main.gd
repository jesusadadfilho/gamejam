extends Node2D

signal uptdate_map

onready var pessoa  = preload("res://scenes/pessoa.tscn")
onready var end_pos = $nave
onready var nav = $nav
onready var map = $nav/map

func _ready():
	randomize()
	gerarPessoasMapa()
	set_process_input(true)
	
func gerarPessoasMapa():
	
	var pontos = $pontos
	for ponto in pontos.get_children():
		for i in range(0,3):
			var m = pessoa.instance()
			$nave.conectarPessoa(m)
			m.setAnimDirection()
			m.goal =  $nave.position
			add_child(m)
			m.position = ponto.position + Vector2(rand_range(-100,100), rand_range(-100,100))
			m.nav = nav

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
			var tile = map.world_to_map(event.position)
			if event.get_button_index() == 1:
				map.set_cell(tile.x, tile.y, 1)
			elif event.get_button_index() == 2:
				map.set_cell(tile.x, tile.y, 1)
	if event is InputEventMouseButton and not event.is_pressed():
		emit_signal("uptdate_map")
		

func _on_mob_time_timeout():
	pass
	#gerarPessoasMapa()
	#connect("uptdate_map",m, "update_path")
