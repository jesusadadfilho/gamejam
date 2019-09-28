extends Node2D

signal uptdate_map
onready var pessoa  = preload("res://scenes/pessoa.tscn")
onready var nav = $nav
onready var map = $nav/map
var pessoas = []
var avisarfuga =  false


func _ready():
	randomize()
	gerarPessoasMapa()
	set_process_input(true)
	set_process(true)
	
func gerarPessoasMapa():
	var ponto = $center
	var intervalo  = 500
	for i in range(0, 16):
		var m = pessoa.instance()
		m.nav = nav
		m.position =  Vector2($center.position.x + rand_range((-1)*intervalo, intervalo), $center.position.y + rand_range((-1)*intervalo, intervalo))
		pessoas.append(m)
		add_child(m)
		m.setAnimDirection()

func _on_nave_pousar(nave):
	if not pessoas.empty():
		for pes in pessoas:
			pes. goal =  $nave.position
			pes.avisarFuga()
	
func removePessoa():
	self.pessoas