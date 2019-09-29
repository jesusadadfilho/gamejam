extends Node2D

signal uptdate_map
onready var pessoa  = preload("res://scenes/pessoa.tscn")
onready var label_count = get_node("Control/label_count")
onready var nav = $nav
onready var map = $nav/map
var pessoas = []
var avisarfuga =  false
var time_start = 0
var time_now = 0


func _ready():
	time_start = OS.get_unix_time()
	randomize()
	gerarPessoasMapa()
	set_process_input(true)
	set_process(true)
	
	
func _process(delta):
	## Funcao para reiniciar o game quando o tempo chega em 30 segundos
	time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	var str_elapsed = "%02d : %02d" % [minutes, seconds]
	label_count.set_text(str(seconds))
	if seconds == 31:
		get_tree().reload_current_scene()

		
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
			pes.goal =  $nave.position
			pes.avisarFuga()
	
func removePessoa():
	self.pessoas